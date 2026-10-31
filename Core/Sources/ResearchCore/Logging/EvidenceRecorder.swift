import Foundation

public enum OperationEvaluation {
    public static func osStatus(actual: Int, expected: Int = 0, verified: Bool = true) -> ResultState {
        if actual == expected { return verified ? .pass : .needsReview }
        // An unexpectedly successful query after deletion is a contradiction, not a generic error.
        if actual == 0 { return .needsReview }
        return ErrorClassifier.state(for: ResearchError(domain: NSOSStatusErrorDomain, code: actual, description: "OSStatus \(actual)"))
    }
}

public struct VerificationFailure: LocalizedError {
    public let message: String
    public var errorDescription: String? { message }
    public init(_ message: String) { self.message = message }
}

public enum ErrorClassifier {
    public static func state(for error: Error) -> ResultState {
        if error is VerificationFailure { return .needsReview }
        return state(for: ResearchError(error))
    }
    public static func state(for error: ResearchError) -> ResultState {
        if error.domain == NSCocoaErrorDomain && [257, 513].contains(error.code) { return .denied }
        if error.domain == NSPOSIXErrorDomain && [1, 13].contains(error.code) { return .denied }
        if error.domain == NSOSStatusErrorDomain && [-25293, -25308, -34018].contains(error.code) { return .denied }
        return .error
    }
}

public struct EvidenceRecorder {
    public private(set) var run: ExperimentRun
    public init(_ definition: ExperimentDefinition, environment: EnvironmentSnapshot) {
        run = ExperimentRun(definition: definition, environment: environment)
    }
    public mutating func record(_ operation: String, resource: String, expected: String,
                                actual: String, state: ResultState, error: ResearchError? = nil,
                                details: [String: String] = [:]) {
        run.operations.append(Evidence(experimentID: run.definition.id, category: run.definition.category,
                                       operation: operation, resource: resource, expectedResult: expected,
                                       actualResult: actual, result: state, error: error,
                                       environment: run.environment, details: details))
    }
    @discardableResult
    public mutating func perform(_ operation: String, resource: String, expected: String,
                                 body: () throws -> String) -> Bool {
        do {
            let actual = try body()
            record(operation, resource: resource, expected: expected, actual: actual, state: .pass)
            return true
        } catch {
            record(operation, resource: resource, expected: expected, actual: error.localizedDescription,
                   state: ErrorClassifier.state(for: error), error: ResearchError(error))
            return false
        }
    }
    public mutating func finish(notes: String = "") -> ExperimentRun {
        run.endTime = Date(); run.researchNotes = notes
        return run
    }
}

public struct LogFilter {
    public var experimentID: String?
    public var category: Category?
    public var result: ResultState?
    public var query: String
    public init(experimentID: String? = nil, category: Category? = nil, result: ResultState? = nil, query: String = "") {
        self.experimentID = experimentID; self.category = category; self.result = result; self.query = query
    }
    public func apply(_ logs: [Evidence]) -> [Evidence] {
        logs.filter {
            (experimentID == nil || $0.experimentID == experimentID) &&
            (category == nil || $0.category == category) && (result == nil || $0.result == result) &&
            (query.isEmpty || "\($0.operation) \($0.resource) \($0.actualResult) \($0.error?.description ?? "")".localizedCaseInsensitiveContains(query))
        }
    }
}
