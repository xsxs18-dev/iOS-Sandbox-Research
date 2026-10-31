import Foundation
import ResearchCore

enum ProtectionClass: String, CaseIterable, Identifiable, Sendable {
    case complete, unlessOpen, untilFirstAuthentication, none
    var id: String { rawValue }
    var value: FileProtectionType {
        switch self {
        case .complete: return .complete
        case .unlessOpen: return .completeUnlessOpen
        case .untilFirstAuthentication: return .completeUntilFirstUserAuthentication
        case .none: return .none
        }
    }
    var title: String {
        switch self {
        case .complete: return "Complete"
        case .unlessOpen: return "Complete unless open"
        case .untilFirstAuthentication: return "Until first authentication"
        case .none: return "No file protection"
        }
    }
    var explanation: String {
        switch self {
        case .complete: return "Access becomes unavailable shortly after locking. Timing and process suspension matter."
        case .unlessOpen: return "An already-open file can remain accessible after locking. Opening existing closed files is restricted."
        case .untilFirstAuthentication: return "Unavailable until the first unlock after boot; remains accessible through subsequent locks."
        case .none: return "No lock-dependent file protection. This does not mean raw storage lacks hardware encryption."
        }
    }
    var definition: ExperimentDefinition {
        ExperimentDefinition(id: "protection.\(rawValue)", name: "Protection: \(title)", category: .protection,
            objective: "Apply and inspect \(value.rawValue) on an app-owned file.",
            method: "Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.",
            expectedBehavior: "The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.")
    }
}

enum ProtectionExperiment {
    static func run(_ protection: ProtectionClass, environment: EnvironmentSnapshot) -> ExperimentRun {
        var recorder = EvidenceRecorder(protection.definition, environment: environment)
        let directory = LabPaths.support.appendingPathComponent("Protection-\(UUID().uuidString)")
        let file = directory.appendingPathComponent("probe.bin")
        let bytes = Data("Non-sensitive lab protection probe".utf8)
        let fm = FileManager.default
        let created = recorder.perform("CREATE", resource: file.path, expected: "Create own protection test file") {
            try fm.createDirectory(at: directory, withIntermediateDirectories: true)
            try bytes.write(to: file, options: .withoutOverwriting); return "Created \(bytes.count) bytes"
        }
        if created {
            recorder.perform("SET_PROTECTION", resource: file.path, expected: protection.value.rawValue) {
                try fm.setAttributes([.protectionKey: protection.value], ofItemAtPath: file.path)
                return "Set \(protection.value.rawValue)"
            }
            recorder.perform("ATTRIBUTES", resource: file.path, expected: "Returned protection equals \(protection.value.rawValue)") {
                let attributes = try fm.attributesOfItem(atPath: file.path)
                let observed = (attributes[.protectionKey] as? FileProtectionType)?.rawValue ?? attributes[.protectionKey] as? String
                guard observed == protection.value.rawValue else { throw VerificationFailure("Requested \(protection.value.rawValue); observed \(observed ?? "unavailable")") }
                return AttributeFormatter.describe(attributes)
            }
            recorder.perform("READ", resource: file.path, expected: "Read exact test bytes in current protection state") {
                guard try Data(contentsOf: file) == bytes else { throw VerificationFailure("Read content differs") }
                return "Readback matched; this alone does not validate locked-device enforcement"
            }
        } else {
            for operation in ["SET_PROTECTION", "ATTRIBUTES", "READ"] {
                recorder.record(operation, resource: file.path, expected: "Use created file", actual: "Creation failed", state: .notTested)
            }
        }
        if fm.fileExists(atPath: directory.path) {
            recorder.perform("CLEANUP", resource: directory.path, expected: "Remove this run's files") {
                try fm.removeItem(at: directory); return "Removed test directory"
            }
        }
        return recorder.finish(notes: protection.explanation)
    }
}

/// This actor serializes probes and owns the one open handle used for Class B observations.
actor ProtectionMonitor {
    private var directory: URL?
    private var heldHandle: FileHandle?
    private let bytes = Data("Non-sensitive manual lock probe".utf8)
    static let definition = ExperimentDefinition(id: "manual.protection", name: "Lock-state observation", category: .protection,
        objective: "Observe protection reads around notifications delivered to this foreground app.",
        method: "Arm files of all four classes; retain one Class B handle. Sample reads when notifications arrive and when explicitly requested. Stop removes the files.",
        expectedBehavior: "Each sample records its real availability and read result. iOS may suspend the process; missing locked-state samples cannot establish enforcement.", automatic: false)

    func arm(environment: EnvironmentSnapshot) -> ExperimentRun {
        var recorder = EvidenceRecorder(Self.definition, environment: environment)
        guard directory == nil else { return probe(environment: environment, trigger: "Already armed") }
        let root = LabPaths.support.appendingPathComponent("ManualProtection-\(UUID().uuidString)")
        directory = root
        for type in ProtectionClass.allCases {
            let file = root.appendingPathComponent(type.rawValue)
            recorder.perform("ARM_\(type.rawValue)", resource: file.path, expected: "Create file with \(type.value.rawValue)") {
                try FileManager.default.createDirectory(at: root, withIntermediateDirectories: true)
                try bytes.write(to: file, options: .withoutOverwriting)
                try FileManager.default.setAttributes([.protectionKey: type.value], ofItemAtPath: file.path)
                if type == .unlessOpen { heldHandle = try FileHandle(forReadingFrom: file) }
                return "Created; \(try AttributeFormatter.describe(FileManager.default.attributesOfItem(atPath: file.path)))"
            }
        }
        return recorder.finish(notes: "Lock and unlock your phone, then return here and stop to save all delivered samples. No background execution entitlement is requested.")
    }
    func probe(environment: EnvironmentSnapshot, trigger: String) -> ExperimentRun {
        var recorder = EvidenceRecorder(Self.definition, environment: environment)
        guard let root = directory else {
            recorder.record("SAMPLE", resource: "Manual protection lab", expected: "Arm files first", actual: "Monitor not armed", state: .notTested)
            return recorder.finish()
        }
        recorder.record("NOTIFICATION", resource: "UIApplication", expected: "Record only delivered events", actual: trigger, state: .pass)
        for type in ProtectionClass.allCases {
            let file = root.appendingPathComponent(type.rawValue)
            recorder.perform("READ_\(type.rawValue)", resource: file.path, expected: "Record actual read outcome; notification timing alone does not prove lock enforcement") {
                guard try Data(contentsOf: file) == bytes else { throw VerificationFailure("Probe bytes changed") }
                return "Closed-file read matched; selected class \(type.value.rawValue)"
            }
        }
        if let handle = heldHandle {
            recorder.perform("READ_HELD_UNLESS_OPEN", resource: root.appendingPathComponent(ProtectionClass.unlessOpen.rawValue).path,
                             expected: "Read using the handle retained before locking") {
                try handle.seek(toOffset: 0)
                guard try handle.readToEnd() == bytes else { throw VerificationFailure("Held-handle bytes differ") }
                return "Held Class B handle read matched"
            }
        }
        return recorder.finish()
    }
    func stop(environment: EnvironmentSnapshot) -> ExperimentRun {
        var recorder = EvidenceRecorder(Self.definition, environment: environment)
        if let handle = heldHandle {
            recorder.perform("CLOSE_HANDLE", resource: "Class B handle", expected: "Close retained file descriptor") {
                try handle.close(); return "Handle closed"
            }
            heldHandle = nil
        }
        if let root = directory {
            let removed = recorder.perform("CLEANUP", resource: root.path, expected: "Remove armed test files") {
                try FileManager.default.removeItem(at: root); return "Armed files removed"
            }
            if removed { directory = nil }
        }
        return recorder.finish()
    }
}
