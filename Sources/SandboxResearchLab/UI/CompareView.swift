import SwiftUI
import ResearchCore

struct CompareView: View {
    @EnvironmentObject private var store: LabStore
    @State private var beforeID: UUID?
    @State private var afterID: UUID?
    private var before: ResearchSession? { store.sessions.first { $0.id == beforeID } }
    private var after: ResearchSession? { store.sessions.first { $0.id == afterID } }
    var body: some View {
        List {
            Section("Chronological direction") {
                Picker("Baseline (A)", selection: $beforeID) { options }
                Picker("Follow-up (B)", selection: $afterID) { options }
                Text("New failures and newly allowed operations are measured from A to B. Keep app build, signing, device state and procedure comparable.").font(.footnote).foregroundStyle(.secondary)
            }
            if let before, let after, before.id != after.id {
                let comparison = SessionComparison(before: before, after: after)
                Section("Context") {
                    DetailValue(title: "A", value: before.environment.osVersion)
                    DetailValue(title: "B", value: after.environment.osVersion)
                    ForEach(comparison.contextDifferences, id: \.self) { Text($0).foregroundStyle(.orange) }
                    Text("Differences are not proof that an OS change caused them.").font(.footnote)
                }
                Section("Summary") {
                    LabeledContent("Changed results / errors", value: String(comparison.changes.count))
                    LabeledContent("New failures", value: String(comparison.changes.filter(\.newFailure).count))
                    LabeledContent("Newly allowed operations", value: String(comparison.changes.filter(\.newPermission).count))
                    LabeledContent("Changed errors", value: String(comparison.changes.filter(\.errorChanged).count))
                    LabeledContent("Changes needing review", value: String(comparison.changes.filter(\.needsReview).count))
                    LabeledContent("B: all NEEDS_REVIEW records", value: String(after.logs.filter { $0.result == .needsReview }.count))
                }
                Section("Changed evidence") {
                    if comparison.changes.isEmpty { Text("No state, error or comparable configuration changes. Random paths and timestamps are intentionally ignored.") }
                    ForEach(comparison.changes) { change in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(change.experimentID).font(.headline)
                            Text(change.operation).font(.caption).foregroundStyle(.secondary)
                            HStack { Text("A"); StateBadge(state: change.before?.result ?? .notTested); Image(systemName: "arrow.right"); Text("B"); StateBadge(state: change.after?.result ?? .notTested) }
                            Text("A: \(change.before?.actualResult ?? "Operation absent")").font(.caption)
                            Text("B: \(change.after?.actualResult ?? "Operation absent")").font(.caption)
                            if change.errorChanged {
                                Text("Error A: \(errorText(change.before?.error))\nError B: \(errorText(change.after?.error))").font(.caption).foregroundStyle(.orange)
                            }
                            if change.newPermission { Text("Newly allowed; manually verify signing and state before attributing to iOS.").font(.caption).foregroundStyle(.purple) }
                        }.padding(.vertical, 4)
                    }
                }
            } else { Section { Text("Select two different sessions.").foregroundStyle(.secondary) } }
        }.navigationTitle("Compare sessions").navigationBarTitleDisplayMode(.inline)
            .onAppear {
                if afterID == nil { afterID = store.sessions.first?.id }
                if beforeID == nil { beforeID = store.sessions.dropFirst().first?.id }
            }
    }
    private var options: some View {
        Group {
            Text("Choose session").tag(nil as UUID?)
            ForEach(store.sessions) { session in
                Text("\(session.startTime.formatted(date: .abbreviated, time: .shortened)) · \(session.title) · \(session.id.uuidString.prefix(6))").tag(Optional(session.id))
            }
        }
    }
    private func errorText(_ error: ResearchError?) -> String { error.map { "\($0.domain) \($0.code): \($0.description)" } ?? "None" }
}
