import SwiftUI
import ResearchCore

struct LogsView: View {
    @EnvironmentObject private var store: LabStore
    @State private var category: ResearchCore.Category?
    @State private var result: ResultState?
    @State private var experimentID: String?
    @State private var query = ""
    private var entries: [(UUID, Evidence)] {
        let filter = LogFilter(experimentID: experimentID, category: category, result: result, query: query)
        return store.sessions.flatMap { session in filter.apply(session.logs).map { (session.id, $0) } }
    }
    private var experimentIDs: [String] { Set(store.sessions.flatMap(\.experiments).map { $0.definition.id }).sorted() }
    var body: some View {
        List {
            Section("Filters") {
                Picker("Category", selection: $category) {
                    Text("All categories").tag(nil as ResearchCore.Category?)
                    ForEach(ResearchCore.Category.allCases, id: \.self) { Text($0.rawValue).tag(Optional($0)) }
                }
                Picker("Result", selection: $result) {
                    Text("All results").tag(nil as ResultState?)
                    ForEach(ResultState.allCases, id: \.self) { Text($0.rawValue).tag(Optional($0)) }
                }
                Picker("Experiment", selection: $experimentID) {
                    Text("All experiments").tag(nil as String?)
                    ForEach(experimentIDs, id: \.self) { Text($0).tag(Optional($0)) }
                }
            }
            Section("Evidence · \(entries.count)") {
                if entries.isEmpty { ContentUnavailableView.search(text: query) }
                ForEach(entries, id: \.1.id) { sessionID, evidence in
                    NavigationLink { EvidenceView(evidence: evidence, sessionID: sessionID) } label: {
                        VStack(alignment: .leading, spacing: 5) {
                            HStack { Text(evidence.operation).font(.subheadline.bold()); Spacer(); StateBadge(state: evidence.result, compact: true) }
                            Text(evidence.experimentID).font(.caption).foregroundStyle(.teal)
                            Text(evidence.actualResult).lineLimit(2).font(.caption).foregroundStyle(.secondary)
                            Text(evidence.timestamp, style: .time).font(.caption2).foregroundStyle(.secondary)
                        }
                    }
                }
            }
        }.navigationTitle("Structured logs").searchable(text: $query, prompt: "Operation, path or error")
    }
}
