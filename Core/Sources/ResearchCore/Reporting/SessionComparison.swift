import Foundation

public struct ResultChange: Identifiable, Sendable {
    public var id: String { "\(experimentID)/\(operation)" }
    public let experimentID: String
    public let operation: String
    public let before: Evidence?
    public let after: Evidence?
    public var newFailure: Bool {
        before?.result == .pass && after.map { [.denied, .error, .needsReview].contains($0.result) } == true
    }
    public var newPermission: Bool { before?.result == .denied && after?.result == .pass }
    public var needsReview: Bool { before?.result == .needsReview || after?.result == .needsReview || newPermission }
    public var errorChanged: Bool { before?.error != after?.error }
}

public struct SessionComparison: Sendable {
    public let beforeID: UUID
    public let afterID: UUID
    public let changes: [ResultChange]
    public let contextDifferences: [String]
    public init(before: ResearchSession, after: ResearchSession) {
        beforeID = before.id; afterID = after.id
        // Match semantic operation IDs, not random file paths, timestamps or byte-count messages.
        func indexed(_ session: ResearchSession) -> [String: Evidence] {
            var output: [String: Evidence] = [:]; var occurrences: [String: Int] = [:]
            for log in session.logs {
                let base = "\(log.experimentID)/\(log.operation)"
                let index = occurrences[base, default: 0]; occurrences[base] = index + 1
                output["\(base)/\(index)"] = log
            }
            return output
        }
        let left = indexed(before); let right = indexed(after)
        changes = Set(left.keys).union(right.keys).sorted().compactMap { key in
            let a = left[key]; let b = right[key]
            let comparableA = a?.details.filter { $0.key.hasPrefix("compare.") }
            let comparableB = b?.details.filter { $0.key.hasPrefix("compare.") }
            guard a?.result != b?.result || a?.error != b?.error || comparableA != comparableB else { return nil }
            return ResultChange(experimentID: b?.experimentID ?? a?.experimentID ?? key,
                                operation: key.components(separatedBy: "/").dropFirst().joined(separator: "/"), before: a, after: b)
        }
        var context: [String] = []
        if before.environment.osVersion != after.environment.osVersion { context.append("iOS version differs") }
        if before.environment.deviceModel != after.environment.deviceModel { context.append("Device model differs") }
        if before.environment.bundleID != after.environment.bundleID { context.append("Bundle identifier differs") }
        if before.environment.appVersion != after.environment.appVersion || before.environment.build != after.environment.build { context.append("App version/build differs") }
        if before.environment.simulator != after.environment.simulator { context.append("Simulator/device differs") }
        if before.environment.protectedDataAvailable != after.environment.protectedDataAvailable { context.append("Protected-data availability differs") }
        if before.completion != .completed || after.completion != .completed { context.append("At least one session is incomplete") }
        contextDifferences = context
    }
}
