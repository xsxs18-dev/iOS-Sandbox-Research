import Foundation

public enum ResultState: String, Codable, CaseIterable, Sendable {
    case pass = "PASS", denied = "DENIED", error = "ERROR"
    case notSupported = "NOT_SUPPORTED", notTested = "NOT_TESTED", needsReview = "NEEDS_REVIEW"

    public static func aggregate(_ states: [ResultState]) -> ResultState {
        guard !states.isEmpty else { return .notTested }
        for state: ResultState in [.needsReview, .error, .denied, .notTested, .pass, .notSupported] {
            if states.contains(state) { return state }
        }
        return .notTested
    }
}

public enum Category: String, Codable, CaseIterable, Sendable {
    case container = "Container", persistence = "Persistence", entitlements = "Entitlements"
    case appGroup = "App Group", keychain = "Keychain", communication = "Communication"
    case protection = "File Protection"
}

public enum Knowledge: String, Codable, CaseIterable, Sendable {
    case observed = "Observed", configured = "Configured", unavailable = "Unavailable"
    case manual = "Requires manual verification"
}

public struct EnvironmentSnapshot: Codable, Equatable, Sendable {
    public var osVersion: String
    public var deviceModel: String
    public var application: String
    public var bundleID: String
    public var appVersion: String
    public var build: String
    public var simulator: Bool
    public var protectedDataAvailable: Bool?
    public var capturedAt: Date
    public var launchID: UUID
    public init(osVersion: String, deviceModel: String, application: String, bundleID: String,
                appVersion: String, build: String, simulator: Bool, protectedDataAvailable: Bool?,
                capturedAt: Date = Date(), launchID: UUID) {
        self.osVersion = osVersion; self.deviceModel = deviceModel; self.application = application
        self.bundleID = bundleID; self.appVersion = appVersion; self.build = build
        self.simulator = simulator; self.protectedDataAvailable = protectedDataAvailable
        self.capturedAt = capturedAt; self.launchID = launchID
    }
}

public struct ResearchError: Codable, Equatable, Sendable {
    public var domain: String
    public var code: Int
    public var description: String
    public var underlying: String?
    public init(domain: String, code: Int, description: String, underlying: String? = nil) {
        self.domain = domain; self.code = code; self.description = description; self.underlying = underlying
    }
    public init(_ error: Error) {
        let value = error as NSError
        self.init(domain: value.domain, code: value.code, description: value.localizedDescription,
                  underlying: (value.userInfo[NSUnderlyingErrorKey] as? NSError)?.description)
    }
}

public struct ExperimentDefinition: Codable, Equatable, Identifiable, Sendable {
    public var id: String
    public var name: String
    public var category: Category
    public var objective: String
    public var method: String
    public var expectedBehavior: String
    public var automatic: Bool
    public init(id: String, name: String, category: Category, objective: String, method: String,
                expectedBehavior: String, automatic: Bool = true) {
        self.id = id; self.name = name; self.category = category; self.objective = objective
        self.method = method; self.expectedBehavior = expectedBehavior; self.automatic = automatic
    }
}

/// Each record is both a structured log entry and exportable evidence. No secret values are stored.
public struct Evidence: Codable, Equatable, Identifiable, Sendable {
    public var id: UUID
    public var timestamp: Date
    public var experimentID: String
    public var category: Category
    public var operation: String
    public var resource: String
    public var expectedResult: String
    public var actualResult: String
    public var result: ResultState
    public var error: ResearchError?
    public var environment: EnvironmentSnapshot
    public var details: [String: String]
    public var researcherNotes: String
    public init(id: UUID = UUID(), timestamp: Date = Date(), experimentID: String, category: Category,
                operation: String, resource: String, expectedResult: String, actualResult: String,
                result: ResultState, error: ResearchError? = nil, environment: EnvironmentSnapshot,
                details: [String: String] = [:], researcherNotes: String = "") {
        self.id = id; self.timestamp = timestamp; self.experimentID = experimentID; self.category = category
        self.operation = operation; self.resource = resource; self.expectedResult = expectedResult
        self.actualResult = actualResult; self.result = result; self.error = error; self.environment = environment
        self.details = details; self.researcherNotes = researcherNotes
    }
}

public struct ExperimentRun: Codable, Equatable, Identifiable, Sendable {
    public var id: UUID
    public var definition: ExperimentDefinition
    public var startTime: Date
    public var endTime: Date?
    public var environment: EnvironmentSnapshot
    public var operations: [Evidence]
    public var researchNotes: String
    public var result: ResultState { ResultState.aggregate(operations.map(\.result)) }
    public var errors: [ResearchError] { operations.compactMap(\.error) }
    public init(id: UUID = UUID(), definition: ExperimentDefinition, startTime: Date = Date(),
                endTime: Date? = nil, environment: EnvironmentSnapshot, operations: [Evidence] = [], researchNotes: String = "") {
        self.id = id; self.definition = definition; self.startTime = startTime; self.endTime = endTime
        self.environment = environment; self.operations = operations; self.researchNotes = researchNotes
    }
    private enum CodingKeys: String, CodingKey {
        case id, definition, startTime, endTime, environment, operations, researchNotes, result, errors
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(definition, forKey: .definition)
        try container.encode(startTime, forKey: .startTime)
        try container.encodeIfPresent(endTime, forKey: .endTime)
        try container.encode(environment, forKey: .environment)
        try container.encode(operations, forKey: .operations)
        try container.encode(researchNotes, forKey: .researchNotes)
        try container.encode(result, forKey: .result)
        try container.encode(errors, forKey: .errors)
    }
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        definition = try container.decode(ExperimentDefinition.self, forKey: .definition)
        startTime = try container.decode(Date.self, forKey: .startTime)
        endTime = try container.decodeIfPresent(Date.self, forKey: .endTime)
        environment = try container.decode(EnvironmentSnapshot.self, forKey: .environment)
        operations = try container.decode([Evidence].self, forKey: .operations)
        researchNotes = try container.decode(String.self, forKey: .researchNotes)
        if let declared = try container.decodeIfPresent(ResultState.self, forKey: .result), declared != result {
            throw DecodingError.dataCorruptedError(forKey: .result, in: container, debugDescription: "Declared result disagrees with operation evidence")
        }
        if let declared = try container.decodeIfPresent([ResearchError].self, forKey: .errors), declared != errors {
            throw DecodingError.dataCorruptedError(forKey: .errors, in: container, debugDescription: "Declared errors disagree with operation evidence")
        }
    }
}

public enum SessionCompletion: String, Codable, Sendable { case running, completed, interrupted }

public struct ResearchSession: Codable, Equatable, Identifiable, Sendable {
    public var schemaVersion: Int = 1
    public var id: UUID
    public var title: String
    public var startTime: Date
    public var endTime: Date?
    public var environment: EnvironmentSnapshot
    public var completion: SessionCompletion
    public var experiments: [ExperimentRun]
    public var researcherNotes: String
    public var logs: [Evidence] { experiments.flatMap(\.operations) }
    public init(id: UUID = UUID(), title: String, environment: EnvironmentSnapshot,
                startTime: Date = Date(), endTime: Date? = nil, completion: SessionCompletion = .running,
                experiments: [ExperimentRun] = [], researcherNotes: String = "") {
        self.id = id; self.title = title; self.environment = environment; self.startTime = startTime
        self.endTime = endTime; self.completion = completion; self.experiments = experiments
        self.researcherNotes = researcherNotes
    }
}

public struct ConfigurationFact: Identifiable, Sendable {
    public var id: String { name }
    public let name: String
    public let value: String
    public let knowledge: Knowledge
    public init(_ name: String, _ value: String, _ knowledge: Knowledge) {
        self.name = name; self.value = value; self.knowledge = knowledge
    }
}
