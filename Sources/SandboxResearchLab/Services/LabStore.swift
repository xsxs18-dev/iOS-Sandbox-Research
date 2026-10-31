import Foundation
import SwiftUI
import UIKit
import UniformTypeIdentifiers
import ResearchCore

struct ShareArtifact: Identifiable {
    let id = UUID()
    let urls: [URL]
    var isExperiment = false
}

@MainActor
final class LabStore: ObservableObject {
    @Published var sessions: [ResearchSession] = []
    @Published var current: ResearchSession?
    @Published var isRunning = false
    @Published var isMonitoring = false
    @Published var progress = 0
    @Published var total = 0
    @Published var activity = "Ready for a safe research session"
    @Published var errorMessage: String?
    @Published var warnings: [String] = []
    @Published var shareArtifact: ShareArtifact?
    private let persistence = SessionStore(directory: LabPaths.support.appendingPathComponent("Sessions"))
    private let runner = ExperimentRunner()
    private let artifacts = ArtifactService()
    private let monitor = ProtectionMonitor()
    private var pendingNonce: String?
    private var urlTimeout: Task<Void, Never>?
    private var urlSessionID: UUID?
    private var urlOpenCompleted = false
    private var urlReceived = false
    var busy: Bool { isRunning || isMonitoring }

    func load() async {
        do {
            let result = try await persistence.load()
            sessions = result.sessions; warnings = result.warnings
        } catch { errorMessage = "Cannot load history: \(error.localizedDescription)" }
    }
    @discardableResult
    private func checkpoint() async -> Bool {
        guard let session = current else { return false }
        do {
            try await persistence.save(session)
            sessions.removeAll { $0.id == session.id }; sessions.insert(session, at: 0)
            return true
        } catch {
            errorMessage = "Evidence remains in memory, but saving failed: \(error.localizedDescription). Export before closing the app."
            return false
        }
    }
    func runSuite() async { await run(ExperimentCatalog.automatic, title: "Safe Research Suite") }
    func runOne(_ definition: ExperimentDefinition) async { await run([definition], title: definition.name) }
    private func run(_ definitions: [ExperimentDefinition], title: String) async {
        guard !busy else { return }
        isRunning = true; progress = 0; total = definitions.count
        defer { isRunning = false }
        current = ResearchSession(title: title, environment: EnvironmentService.capture())
        guard await checkpoint() else { current?.completion = .interrupted; return }
        for (index, definition) in definitions.enumerated() {
            activity = "Experiment \(index + 1)/\(definitions.count) · \(definition.name)"
            let result = await runner.run(definition, environment: EnvironmentService.capture())
            current?.experiments.append(result); progress = index + 1
            guard await checkpoint() else { current?.completion = .interrupted; return }
        }
        current?.completion = .completed; current?.endTime = Date()
        let saved = await checkpoint()
        activity = saved ? "Session complete · \(definitions.count) experiments recorded" : "Session complete · export unsaved evidence"
    }
    func saveNotes(sessionID: UUID, notes: String, evidenceID: UUID? = nil) async {
        guard !busy, var session = sessions.first(where: { $0.id == sessionID }) else { return }
        if let evidenceID {
            for r in session.experiments.indices {
                if let index = session.experiments[r].operations.firstIndex(where: { $0.id == evidenceID }) {
                    session.experiments[r].operations[index].researcherNotes = notes
                }
            }
        } else { session.researcherNotes = notes }
        do {
            try await persistence.save(session)
            if let index = sessions.firstIndex(where: { $0.id == sessionID }) { sessions[index] = session }
            if current?.id == sessionID { current = session }
        } catch { errorMessage = "Notes could not be saved: \(error.localizedDescription)" }
    }
    func delete(_ session: ResearchSession) async {
        guard !busy else { return }
        do {
            try await persistence.delete(session.id); sessions.removeAll { $0.id == session.id }
            if current?.id == session.id { current = nil }
        } catch { errorMessage = "Could not delete session: \(error.localizedDescription)" }
    }
    func export(_ session: ResearchSession) async {
        guard !busy else { return }
        do { shareArtifact = ShareArtifact(urls: try await artifacts.export(session)) }
        catch { errorMessage = "Export failed: \(error.localizedDescription)" }
    }
    func importSession(_ url: URL) async {
        guard !busy else { return }
        let access = url.startAccessingSecurityScopedResource()
        defer { if access { url.stopAccessingSecurityScopedResource() } }
        do {
            var session = try await artifacts.readImport(url)
            session.researcherNotes += "\nImported from a user-selected JSON file on \(ResearchFormat.date(Date())). Source is not authenticated."
            if session.completion == .running { session.completion = .interrupted }
            try await persistence.insert(session)
            await load()
        } catch { errorMessage = "Import failed: \(error.localizedDescription)" }
    }
    func armMonitor() async {
        guard !busy else { return }
        isMonitoring = true
        current = ResearchSession(title: "Manual lock-state observation", environment: EnvironmentService.capture())
        current?.experiments = [await monitor.arm(environment: EnvironmentService.capture())]
        activity = "Lock observation armed · lock, unlock, then stop and save"
        await checkpoint()
    }
    func sampleMonitor(_ trigger: String) async {
        guard isMonitoring else { return }
        let sample = await monitor.probe(environment: EnvironmentService.capture(), trigger: trigger)
        guard isMonitoring else { return }
        appendManual(sample); await checkpoint()
    }
    private func appendManual(_ sample: ExperimentRun) {
        guard let index = current?.experiments.firstIndex(where: { $0.definition.id == sample.definition.id }) else { return }
        current?.experiments[index].operations += sample.operations
        current?.experiments[index].endTime = sample.endTime
    }
    func stopMonitor() async {
        guard isMonitoring else { return }
        isMonitoring = false; isRunning = true
        let sample = await monitor.stop(environment: EnvironmentService.capture())
        appendManual(sample)
        current?.endTime = Date(); current?.completion = .completed
        await checkpoint(); isRunning = false; activity = "Manual protection evidence saved"
    }
    func openOwnURL() async {
        guard !busy else { return }
        isRunning = true
        let nonce = UUID().uuidString
        pendingNonce = nonce
        urlOpenCompleted = false; urlReceived = false
        current = ResearchSession(title: "Own URL scheme round trip", environment: EnvironmentService.capture())
        urlSessionID = current?.id
        current?.experiments = [ExperimentRun(definition: ExperimentCatalog.url, environment: EnvironmentService.capture())]
        guard await checkpoint() else { isRunning = false; pendingNonce = nil; return }
        guard let url = URL(string: "sandboxresearchlab://probe?nonce=\(nonce)") else { isRunning = false; return }
        urlTimeout = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 15_000_000_000)
            guard !Task.isCancelled, let self, self.pendingNonce != nil else { return }
            await self.finishURLTimeout()
        }
        let opened = await UIApplication.shared.open(url, options: [:])
        guard current?.id == urlSessionID else { return }
        urlOpenCompleted = true
        appendEvidence(operation: "OPEN", resource: "sandboxresearchlab://probe", expected: "System accepts own registered URL",
                       actual: opened ? "open completion returned true" : "open completion returned false", state: opened ? .pass : .needsReview)
        await checkpoint()
        // Receiving the URL is a separate observation and can precede open's completion.
        if urlReceived { await finishManual() }
    }
    func receive(_ url: URL) async {
        guard url.scheme == "sandboxresearchlab", url.host == "probe",
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let nonce = components.queryItems?.first(where: { $0.name == "nonce" })?.value,
              nonce == pendingNonce else { return }
        pendingNonce = nil; urlReceived = true; urlTimeout?.cancel()
        appendEvidence(operation: "RECEIVE", resource: "Own scheme callback (payload omitted)", expected: "Incoming nonce matches pending probe",
                       actual: "Exact pending nonce received by onOpenURL", state: .pass)
        if urlOpenCompleted { await finishManual() }
    }
    private func finishURLTimeout() async {
        pendingNonce = nil
        appendEvidence(operation: "RECEIVE", resource: "Own scheme callback", expected: "Receive matching pending nonce",
                       actual: "No matching callback observed within 15 seconds. Process suspension may affect timing.", state: .notTested)
        await finishManual()
    }
    func observeUniversalLink(_ activity: NSUserActivity) async {
        guard !busy, let url = activity.webpageURL, url.scheme == "https", let host = url.host else { return }
        let declared = Bundle.main.object(forInfoDictionaryKey: "LabAssociatedDomains") as? [String] ?? []
        guard declared.contains("applinks:\(host)") else { return }
        isRunning = true
        let definition = ExperimentDefinition(id: "manual.universal-link", name: "Incoming universal link", category: .communication,
            objective: "Record delivery of an HTTPS user activity for a configured owned domain.", method: "Observe NSUserActivityTypeBrowsingWeb; omit URL path, query and fragment.",
            expectedBehavior: "System delivers a browsing activity. Delivery does not authenticate a sender or prove every URL association.", automatic: false)
        current = ResearchSession(title: definition.name, environment: EnvironmentService.capture())
        current?.experiments = [ExperimentRun(definition: definition, environment: EnvironmentService.capture())]
        appendEvidence(operation: "RECEIVE", resource: host, expected: "Receive browsing activity for declared domain", actual: "Delivered via onContinueUserActivity", state: .pass)
        await finishManual()
    }
    func shareDocument() async {
        guard !busy else { return }
        isRunning = true
        current = ResearchSession(title: ExperimentCatalog.document.name, environment: EnvironmentService.capture())
        current?.experiments = [ExperimentRun(definition: ExperimentCatalog.document, environment: EnvironmentService.capture())]
        do {
            let url = try await artifacts.labDocument()
            appendEvidence(operation: "CREATE", resource: url.path, expected: "Create non-sensitive document", actual: "Lab text document written", state: .pass)
            guard await checkpoint() else { isRunning = false; return }
            shareArtifact = ShareArtifact(urls: [url], isExperiment: true)
        } catch {
            appendEvidence(operation: "CREATE", resource: "Lab document", expected: "Write document", actual: error.localizedDescription,
                           state: ErrorClassifier.state(for: error), error: ResearchError(error))
            await finishManual()
        }
    }
    func shareCompleted(activity: String?, completed: Bool, error: Error?) async {
        guard current?.experiments.first?.definition.id == ExperimentCatalog.document.id, isRunning else { return }
        appendEvidence(operation: "SHARE", resource: activity ?? "System share sheet", expected: "User-selected activity reports completion",
                       actual: error?.localizedDescription ?? (completed ? "Activity reported completion; destination storage is not verified" : "User cancelled or activity did not complete"),
                       state: error.map(ErrorClassifier.state(for:)) ?? (completed ? .pass : .notTested), error: error.map(ResearchError.init))
        await finishManual()
    }
    private func appendEvidence(operation: String, resource: String, expected: String, actual: String, state: ResultState, error: ResearchError? = nil) {
        guard let definition = current?.experiments.first?.definition else { return }
        current?.experiments[0].operations.append(Evidence(experimentID: definition.id, category: definition.category,
            operation: operation, resource: resource, expectedResult: expected, actualResult: actual, result: state,
            error: error, environment: EnvironmentService.capture()))
    }
    private func finishManual() async {
        guard isRunning, current?.completion == .running else { return }
        current?.experiments[0].endTime = Date(); current?.endTime = Date(); current?.completion = .completed
        await checkpoint(); isRunning = false; activity = "Manual experiment recorded"
        urlSessionID = nil
    }
}

actor ArtifactService {
    func export(_ session: ResearchSession) throws -> [URL] {
        let root = try exportDirectory()
        let json = root.appendingPathComponent("Research-\(session.id).json")
        let markdown = root.appendingPathComponent("Research-\(session.id).md")
        try SessionJSON.encode(session).write(to: json, options: .atomic)
        try Data(MarkdownReport.generate(session).utf8).write(to: markdown, options: .atomic)
        return [json, markdown]
    }
    func labDocument() throws -> URL {
        let url = try exportDirectory().appendingPathComponent("SandboxResearchLab-Document.txt")
        try Data("SandboxResearchLab\nNon-sensitive app-created document for a user-mediated share experiment.\nCreated: \(ResearchFormat.date(Date()))\n".utf8).write(to: url, options: .atomic)
        return url
    }
    private func exportDirectory() throws -> URL {
        let root = FileManager.default.temporaryDirectory.appendingPathComponent("LabExports-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
        return root
    }
    func readImport(_ url: URL) throws -> ResearchSession {
        let size = try url.resourceValues(forKeys: [.fileSizeKey]).fileSize ?? 0
        guard size <= 25 * 1024 * 1024 else { throw SessionDataError.tooLarge }
        return try SessionJSON.decode(Data(contentsOf: url, options: .mappedIfSafe))
    }
}
