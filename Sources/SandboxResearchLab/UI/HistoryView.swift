import SwiftUI
import UniformTypeIdentifiers
import ResearchCore

struct HistoryView: View {
    @EnvironmentObject private var store: LabStore
    @State private var importing = false
    @State private var pendingDelete: ResearchSession?
    var body: some View {
        List {
            Section {
                NavigationLink { CompareView() } label: { Label("Compare two sessions", systemImage: "arrow.left.arrow.right") }
                    .disabled(store.sessions.count < 2)
                Button { importing = true } label: { Label("Import session JSON", systemImage: "square.and.arrow.down") }.disabled(store.busy)
                Text("Import an exported session to compare iOS versions across devices. Imported data is not authenticated.").font(.caption).foregroundStyle(.secondary)
            }
            Section("Saved sessions · \(store.sessions.count)") {
                if store.sessions.isEmpty { ContentUnavailableView("No saved sessions", systemImage: "clock", description: Text("Your recorded research appears here.")) }
                ForEach(store.sessions) { session in
                    NavigationLink { SessionDetailView(sessionID: session.id, fallback: session) } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(session.title).font(.headline)
                            Text(session.startTime.formatted(date: .abbreviated, time: .shortened)).font(.subheadline)
                            Text("\(session.experiments.count) experiments · \(session.completion.rawValue)").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                    .swipeActions {
                        Button(role: .destructive) { pendingDelete = session } label: { Label("Delete", systemImage: "trash") }.disabled(store.busy)
                        Button { Task { await store.export(session) } } label: { Label("Export", systemImage: "square.and.arrow.up") }.tint(.teal)
                    }
                }
            }
        }.navigationTitle("History")
            .fileImporter(isPresented: $importing, allowedContentTypes: [.json]) { result in
                switch result {
                case .success(let url): Task { await store.importSession(url) }
                case .failure(let error): store.errorMessage = error.localizedDescription
                }
            }
            .alert("Delete this research session?", isPresented: Binding(get: { pendingDelete != nil }, set: { if !$0 { pendingDelete = nil } })) {
                Button("Delete", role: .destructive) {
                    if let session = pendingDelete { Task { await store.delete(session) } }; pendingDelete = nil
                }
                Button("Cancel", role: .cancel) { pendingDelete = nil }
            } message: { Text("This removes its local history and notes. Files already exported elsewhere remain there.") }
    }
}

struct SessionDetailView: View {
    @EnvironmentObject private var store: LabStore
    let sessionID: UUID
    let fallback: ResearchSession
    @State private var notes = ""
    private var session: ResearchSession {
        if store.current?.id == sessionID, let current = store.current { return current }
        return store.sessions.first { $0.id == sessionID } ?? fallback
    }
    var body: some View {
        List {
            Section {
                DetailValue(title: "Session", value: session.id.uuidString)
                DetailValue(title: "Started", value: session.startTime.formatted(date: .abbreviated, time: .standard))
                LabeledContent("Completion", value: session.completion.rawValue)
                Button { Task { await store.export(session) } } label: { Label("Export JSON & Markdown", systemImage: "square.and.arrow.up") }
                NavigationLink("Read generated report") { ReportView(session: session) }
            }
            Section("Environment") { EnvironmentView(environment: session.environment) }
            Section("File access matrix") { FileMatrixView(session: session) }
            Section("Experiments") {
                ForEach(session.experiments) { run in
                    NavigationLink { RunDetailView(run: run, sessionID: sessionID) } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(run.definition.name).font(.headline)
                            StateBadge(state: run.result)
                            Text("\(run.operations.count) operations · \(run.errors.count) errors").font(.caption).foregroundStyle(.secondary)
                        }
                    }
                }
            }
            Section("Researcher notes") {
                TextEditor(text: $notes).frame(minHeight: 100).disabled(store.busy)
                Button("Save notes") { Task { await store.saveNotes(sessionID: sessionID, notes: notes) } }.disabled(store.busy)
            }
        }.navigationTitle(session.title).navigationBarTitleDisplayMode(.inline)
            .onAppear { notes = session.researcherNotes }
    }
}

struct FileMatrixView: View {
    let session: ResearchSession
    private let columns = ["READ", "WRITE", "CREATE", "DELETE", "ENUMERATE", "ATTRIBUTES"]
    var body: some View {
        let runs = session.experiments.filter { $0.definition.id.hasPrefix("files.") }
        if runs.isEmpty { Text("No file access experiments in this session.").foregroundStyle(.secondary) }
        else {
            ScrollView(.horizontal) {
                Grid(alignment: .leading, horizontalSpacing: 14, verticalSpacing: 12) {
                    GridRow {
                        Text("Location").frame(width: 140, alignment: .leading)
                        ForEach(columns, id: \.self) { Text($0).font(.caption2.bold()).frame(width: 80) }
                    }
                    ForEach(runs) { run in
                        GridRow {
                            Text(run.definition.name).font(.caption).frame(width: 140, alignment: .leading)
                            ForEach(columns, id: \.self) { operation in
                                let evidence = run.operations.first { $0.operation == operation }
                                VStack(spacing: 3) {
                                    StateBadge(state: evidence?.result ?? (run.result == .notSupported ? .notSupported : .notTested), compact: true)
                                    Text((evidence?.result ?? (run.result == .notSupported ? .notSupported : .notTested)).rawValue).font(.system(size: 8))
                                }.frame(width: 80)
                            }
                        }
                    }
                }.padding(.vertical, 6)
            }
        }
    }
}

struct RunDetailView: View {
    let run: ExperimentRun
    let sessionID: UUID
    var body: some View {
        List {
            Section { StateBadge(state: run.result); Text(MarkdownReport.interpretation(run.result)).font(.footnote) }
            Section("Objective") { Text(run.definition.objective) }
            Section("Method") { Text(run.definition.method) }
            Section("Expected behavior") { Text(run.definition.expectedBehavior) }
            Section("Evidence") {
                ForEach(run.operations) { evidence in
                    NavigationLink { EvidenceView(evidence: evidence, sessionID: sessionID) } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack { Text(evidence.operation).font(.subheadline.bold()); Spacer(); StateBadge(state: evidence.result, compact: true) }
                            Text(evidence.actualResult).font(.caption).foregroundStyle(.secondary).lineLimit(3)
                        }
                    }
                }
            }
            if !run.researchNotes.isEmpty { Section("Research notes") { Text(run.researchNotes) } }
        }.navigationTitle(run.definition.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct EvidenceView: View {
    @EnvironmentObject private var store: LabStore
    let evidence: Evidence
    let sessionID: UUID
    @State private var notes = ""
    var body: some View {
        List {
            Section { StateBadge(state: evidence.result); DetailValue(title: "Evidence ID", value: evidence.id.uuidString) }
            Section("Observation") {
                DetailValue(title: "Timestamp", value: ResearchFormat.date(evidence.timestamp))
                DetailValue(title: "Operation", value: evidence.operation)
                DetailValue(title: "Resource", value: evidence.resource)
                DetailValue(title: "Expected", value: evidence.expectedResult)
                DetailValue(title: "Actual", value: evidence.actualResult)
                ForEach(evidence.details.keys.sorted(), id: \.self) { key in DetailValue(title: key, value: evidence.details[key] ?? "") }
            }
            if let error = evidence.error {
                Section("Exact error") {
                    DetailValue(title: "Domain / code", value: "\(error.domain) / \(error.code)")
                    DetailValue(title: "Description", value: error.description)
                    if let underlying = error.underlying { DetailValue(title: "Underlying", value: underlying) }
                }
            }
            Section("Environment at observation") { EnvironmentView(environment: evidence.environment) }
            Section("Researcher note") {
                TextEditor(text: $notes).frame(minHeight: 100).disabled(store.busy)
                Button("Save evidence note") { Task { await store.saveNotes(sessionID: sessionID, notes: notes, evidenceID: evidence.id) } }.disabled(store.busy)
            }
        }.navigationTitle("Evidence").navigationBarTitleDisplayMode(.inline)
            .onAppear { notes = store.sessions.first(where: { $0.id == sessionID })?.logs.first(where: { $0.id == evidence.id })?.researcherNotes ?? evidence.researcherNotes }
    }
}

struct ReportView: View {
    let session: ResearchSession
    var body: some View {
        ScrollView { Text(MarkdownReport.generate(session)).font(.system(.footnote, design: .monospaced)).textSelection(.enabled).frame(maxWidth: .infinity, alignment: .leading).padding() }
            .navigationTitle("Markdown report").navigationBarTitleDisplayMode(.inline)
    }
}
