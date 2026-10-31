import SwiftUI
import ResearchCore

struct RootView: View {
    @EnvironmentObject private var store: LabStore
    var body: some View {
        TabView {
            NavigationStack { DashboardView() }.tabItem { Label("Dashboard", systemImage: "square.grid.2x2.fill") }
            NavigationStack { ExperimentsView() }.tabItem { Label("Experiments", systemImage: "testtube.2") }
            NavigationStack { ManualLabView() }.tabItem { Label("Manual Lab", systemImage: "hand.tap.fill") }
            NavigationStack { HistoryView() }.tabItem { Label("History", systemImage: "clock.arrow.circlepath") }
            NavigationStack { LogsView() }.tabItem { Label("Logs", systemImage: "text.alignleft") }
        }
        .tint(.teal)
        .sheet(item: $store.shareArtifact) { artifact in
            ShareSheet(artifact: artifact) { activity, completed, error in
                guard artifact.isExperiment else { return }
                Task { @MainActor in await store.shareCompleted(activity: activity, completed: completed, error: error) }
            }
            .interactiveDismissDisabled(artifact.isExperiment)
        }
        .alert("Research Lab", isPresented: Binding(get: { store.errorMessage != nil }, set: { if !$0 { store.errorMessage = nil } })) {
            Button("OK", role: .cancel) { store.errorMessage = nil }
        } message: { Text(store.errorMessage ?? "") }
    }
}

struct DashboardView: View {
    @EnvironmentObject private var store: LabStore
    var body: some View {
        List {
            Section {
                VStack(alignment: .leading, spacing: 14) {
                    Image(systemName: "shield.lefthalf.filled").font(.system(size: 38)).foregroundStyle(.teal)
                    Text("Observe the boundary.").font(.title2.bold())
                    Text("A defensive lab for your own app container, Keychain and public iOS capabilities.")
                        .font(.subheadline).foregroundStyle(.secondary)
                    Button { Task { await store.runSuite() } } label: {
                        Label("Run Safe Research Suite", systemImage: "play.fill").font(.headline).frame(maxWidth: .infinity).padding(.vertical, 6)
                    }.buttonStyle(.borderedProminent).disabled(store.busy)
                    if store.isRunning && store.total > 0 {
                        ProgressView(value: Double(store.progress), total: Double(store.total))
                    }
                    Text(store.activity).font(.caption).foregroundStyle(.secondary)
                }.padding(.vertical, 10)
            }
            if let session = store.current ?? store.sessions.first {
                Section("Latest research session") {
                    NavigationLink { SessionDetailView(sessionID: session.id, fallback: session) } label: {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(session.title).font(.headline)
                            Text(session.startTime, style: .date).foregroundStyle(.secondary)
                            Text("\(session.experiments.count) experiments · \(session.logs.count) evidence records · \(session.completion.rawValue)").font(.caption)
                        }
                    }
                    let reviewCount = session.logs.filter { $0.result == .needsReview }.count
                    LabeledContent("Needs manual review", value: String(reviewCount))
                    Button { Task { await store.export(session) } } label: { Label("Export JSON & Markdown", systemImage: "square.and.arrow.up") }
                }
            } else {
                Section { ContentUnavailableView("No research yet", systemImage: "testtube.2", description: Text("Run the suite to collect your first real observations.")) }
            }
            Section("Current environment") { EnvironmentView(environment: EnvironmentService.capture()) }
            Section("Interpretation") {
                Text("PASS verifies the stated operation. DENIED can be normal enforcement. NEEDS_REVIEW calls for reproduction, never an automatic vulnerability claim.")
                    .font(.footnote).foregroundStyle(.secondary)
                Text("Persistence needs a second launch. Lock-state and communication tests are in Manual Lab.")
                    .font(.footnote).foregroundStyle(.secondary)
            }
            if !store.warnings.isEmpty {
                Section("History files needing attention") {
                    ForEach(store.warnings, id: \.self) { Text($0).font(.caption).foregroundStyle(.orange).textSelection(.enabled) }
                    Text("Unreadable files are preserved; no evidence was silently discarded.").font(.caption)
                }
            }
        }.navigationTitle("Sandbox Lab")
    }
}

struct ExperimentsView: View {
    @EnvironmentObject private var store: LabStore
    var body: some View {
        List {
            Section {
                NavigationLink("Entitlements & signing provenance") { ConfigurationView() }
                NavigationLink("Discovered container paths") { ContainerPathsView() }
            }
            ForEach(ResearchCore.Category.allCases, id: \.self) { category in
                let definitions = ExperimentCatalog.automatic.filter { $0.category == category }
                if !definitions.isEmpty {
                    Section(category.rawValue) {
                        ForEach(definitions) { definition in
                            NavigationLink { ExperimentView(definition: definition) } label: {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text(definition.name).font(.headline)
                                    if let run = store.sessions.lazy.flatMap(\.experiments).first(where: { $0.definition.id == definition.id }) {
                                        StateBadge(state: run.result)
                                    } else { Text("Not run yet").font(.caption).foregroundStyle(.secondary) }
                                }
                            }
                        }
                    }
                }
            }
        }.navigationTitle("Experiments")
    }
}

struct ExperimentView: View {
    @EnvironmentObject private var store: LabStore
    let definition: ExperimentDefinition
    var body: some View {
        List {
            Section("Objective") { Text(definition.objective) }
            Section("Method") { Text(definition.method) }
            Section("Expected behavior") { Text(definition.expectedBehavior) }
            Section {
                Button { Task { await store.runOne(definition) } } label: { Label("Run experiment", systemImage: "play.fill") }.disabled(store.busy)
                if let current = store.current, current.experiments.contains(where: { $0.definition.id == definition.id }) {
                    NavigationLink("View recorded session") { SessionDetailView(sessionID: current.id, fallback: current) }
                }
            }
        }.navigationTitle(definition.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct ContainerPathsView: View {
    var body: some View {
        List {
            Section { Text("Resolved using Foundation for this app. Tests create unique child directories and remove only their own files.").font(.footnote) }
            ForEach(LabPaths.locations()) { location in DetailValue(title: location.name, value: location.url.path) }
        }.navigationTitle("Own container")
    }
}

struct ConfigurationView: View {
    var body: some View {
        List {
            ForEach(ConfigurationService.facts) { fact in
                VStack(alignment: .leading, spacing: 6) {
                    Text(fact.knowledge.rawValue.uppercased()).font(.caption2.bold()).foregroundStyle(.teal)
                    DetailValue(title: fact.name, value: fact.value)
                }
            }
            Section("Optional App Group setup") {
                Text("In Xcode, select the app target → Signing & Capabilities → + Capability → App Groups. Register/select your own group. Set LabAppGroupIdentifier in Resources/Info.plist to exactly that group. Rebuild and sign with a profile granting it.")
                Text("An empty identifier is supported. Ordinary file and Keychain tests need no App Group. Linux setup is documented in Documentation/App-Groups.md.").font(.footnote).foregroundStyle(.secondary)
            }
        }.navigationTitle("Configuration").navigationBarTitleDisplayMode(.inline)
    }
}
