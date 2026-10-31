import Foundation

public enum PersistenceExperiment {
    private struct Marker: Codable {
        let launchID: UUID
        let token: String
        let createdAt: Date
    }
    public static let definition = ExperimentDefinition(
        id: "persistence.launch", name: "Persistence between launches", category: .persistence,
        objective: "Check that an app-owned Application Support file survives a process relaunch.",
        method: "Keep an independent receipt and marker. Compare the marker bytes on a later launch, then re-arm the baseline.",
        expectedBehavior: "A marker remains readable and unchanged on a later launch without reinstall or data removal.")

    public static func run(directory: URL, environment: EnvironmentSnapshot) -> ExperimentRun {
        let fm = FileManager.default
        let markerURL = directory.appendingPathComponent("launch-marker.txt")
        let receiptURL = directory.appendingPathComponent("launch-receipt.json")
        var recorder = EvidenceRecorder(definition, environment: environment)
        do {
            try fm.createDirectory(at: directory, withIntermediateDirectories: true)
            let names = try fm.contentsOfDirectory(atPath: directory.path)
            if names.contains(receiptURL.lastPathComponent) {
                let previous = try JSONDecoder().decode(Marker.self, from: Data(contentsOf: receiptURL))
                if previous.launchID == environment.launchID {
                    recorder.record("PERSISTENCE", resource: markerURL.path, expected: "Verify after a different process launch",
                                    actual: "Baseline exists from this launch. Terminate, relaunch, then run this experiment again.", state: .notTested)
                    return recorder.finish()
                }
                recorder.perform("PERSISTENCE", resource: markerURL.path, expected: "Previously recorded marker survives relaunch") {
                    guard names.contains(markerURL.lastPathComponent) else {
                        throw VerificationFailure("Receipt survived but marker is absent. Check data removal, restore, and storage conditions.")
                    }
                    let bytes = try Data(contentsOf: markerURL)
                    guard bytes == Data(previous.token.utf8) else { throw VerificationFailure("Marker differs from receipt") }
                    return "Marker from \(ResearchFormat.date(previous.createdAt)) survived a different process launch; bytes match"
                }
            } else {
                recorder.record("PERSISTENCE", resource: markerURL.path, expected: "Verify a previous launch baseline",
                                actual: "No receipt exists. This run establishes a baseline; no persistence claim yet.", state: .notTested)
            }
            // Never overwrite evidence of an unexpected marker or failed read.
            if recorder.run.operations.contains(where: { [.error, .denied, .needsReview].contains($0.result) }) {
                return recorder.finish(notes: "Baseline preserved for review; no automatic reset.")
            }
            recorder.perform("ARM_BASELINE", resource: markerURL.path, expected: "Save matching marker and receipt") {
                let marker = Marker(launchID: environment.launchID, token: UUID().uuidString, createdAt: Date())
                try Data(marker.token.utf8).write(to: markerURL, options: .atomic)
                try JSONEncoder().encode(marker).write(to: receiptURL, options: .atomic)
                return "Baseline saved for a future launch"
            }
        } catch {
            recorder.record("PERSISTENCE", resource: directory.path, expected: "Read or initialize baseline",
                            actual: error.localizedDescription, state: ErrorClassifier.state(for: error), error: ResearchError(error))
        }
        return recorder.finish(notes: "Reinstall, backup restore, or deliberate lab-data removal invalidates continuity. Cache and tmp retention are not asserted.")
    }
}
