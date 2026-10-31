import Foundation

public struct TestLocation: Identifiable, Sendable {
    public let id: String
    public let name: String
    public let url: URL
    public init(id: String, name: String, url: URL) { self.id = id; self.name = name; self.url = url }
}

/// Call only with app-owned directories or an authorized App Group container.
/// Every run owns a unique child directory; it never modifies existing user files.
public enum FileAccessExperiment {
    public static func definition(for location: TestLocation, category: Category = .container) -> ExperimentDefinition {
        ExperimentDefinition(id: "files.\(location.id)", name: location.name, category: category,
                             objective: "Measure ordinary file operations in \(location.name).",
                             method: "Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.",
                             expectedBehavior: "Operations on this application's own test files should succeed while storage and protection conditions permit.")
    }

    public static func run(location: TestLocation, environment: EnvironmentSnapshot,
                           category: Category = .container) -> ExperimentRun {
        let fm = FileManager.default
        var recorder = EvidenceRecorder(definition(for: location, category: category), environment: environment)
        let root = location.url.appendingPathComponent("SandboxResearchLab-\(UUID().uuidString)", isDirectory: true)
        let file = root.appendingPathComponent("probe.txt")
        let initial = Data("Lab-owned initial bytes".utf8)
        let updated = Data("Lab-owned updated bytes".utf8)
        let prepared = recorder.perform("DIRECTORY_CREATE", resource: root.path, expected: "Create isolated test directory") {
            try fm.createDirectory(at: root, withIntermediateDirectories: true)
            return "Directory created"
        }
        guard prepared else {
            for operation in ["CREATE", "READ", "WRITE", "ENUMERATE", "ATTRIBUTES", "DELETE"] {
                recorder.record(operation, resource: file.path, expected: "Exercise own test file",
                                actual: "Prerequisite directory creation failed", state: .notTested)
            }
            return recorder.finish()
        }
        let created = recorder.perform("CREATE", resource: file.path, expected: "Create new file with known bytes") {
            try initial.write(to: file, options: .withoutOverwriting)
            return "Created \(initial.count) bytes"
        }
        if created {
            recorder.perform("READ", resource: file.path, expected: "Read exact initial bytes") {
                let read = try Data(contentsOf: file)
                guard read == initial else { throw VerificationFailure("Initial bytes differ from written bytes") }
                return "Read and verified \(read.count) bytes"
            }
            recorder.perform("WRITE", resource: file.path, expected: "Modify file and read back exact new bytes") {
                try updated.write(to: file)
                guard try Data(contentsOf: file) == updated else { throw VerificationFailure("Updated bytes differ") }
                return "Modified and verified \(updated.count) bytes"
            }
        } else {
            for operation in ["READ", "WRITE"] {
                recorder.record(operation, resource: file.path, expected: "Use own created file", actual: "File creation failed", state: .notTested)
            }
        }
        recorder.perform("ENUMERATE", resource: root.path, expected: created ? "Enumeration includes probe.txt" : "Enumerate own test directory") {
            let names = try fm.contentsOfDirectory(atPath: root.path).sorted()
            if created && !names.contains("probe.txt") { throw VerificationFailure("Created file missing from enumeration") }
            return "Entries: \(names.joined(separator: ", "))"
        }
        if created {
            recorder.perform("ATTRIBUTES", resource: file.path, expected: "Read file attributes") {
                try AttributeFormatter.describe(fm.attributesOfItem(atPath: file.path))
            }
            recorder.perform("DELETE", resource: file.path, expected: "Delete test file and confirm absence") {
                try fm.removeItem(at: file)
                // An enumeration proves absence without fileExists() swallowing a permissions error.
                guard try !fm.contentsOfDirectory(atPath: root.path).contains("probe.txt") else {
                    throw VerificationFailure("File still present after removal")
                }
                return "Deleted; absence verified by directory enumeration"
            }
        } else {
            for operation in ["ATTRIBUTES", "DELETE"] {
                recorder.record(operation, resource: file.path, expected: "Use own created file", actual: "File creation failed", state: .notTested)
            }
        }
        recorder.perform("CLEANUP", resource: root.path, expected: "Remove this run's test directory") {
            try fm.removeItem(at: root); return "Test directory removed"
        }
        return recorder.finish(notes: "Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.")
    }
}

public enum AttributeFormatter {
    public static func describe(_ attributes: [FileAttributeKey: Any]) -> String {
        attributes.keys.sorted { $0.rawValue < $1.rawValue }.map {
            "\($0.rawValue)=\(String(describing: attributes[$0] ?? "unavailable"))"
        }.joined(separator: "\n")
    }
}
