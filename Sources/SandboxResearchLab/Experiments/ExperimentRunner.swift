import Foundation
import ResearchCore

enum ExperimentCatalog {
    static let communication = ExperimentDefinition(id: "communication.configuration", name: "Communication configuration", category: .communication,
        objective: "Inspect the app's declared URL and document mechanisms.", method: "Read this app's URL scheme and associated-domain metadata. Separate external interactions from automatic inspection.",
        expectedBehavior: "Configuration is visible. Actual handoff and incoming links require explicit user interaction.")
    static let group = ExperimentDefinition(id: "files.app-group", name: "Optional App Group", category: .appGroup,
        objective: "Test only an App Group container authorized for this application.", method: "Resolve the configured group identifier and run the isolated file lifecycle if available.",
        expectedBehavior: "Configured, provisioned groups resolve; missing configuration is NOT_SUPPORTED.")
    static var automatic: [ExperimentDefinition] {
        LabPaths.locations().map { FileAccessExperiment.definition(for: $0) } +
        [PersistenceExperiment.definition, ConfigurationService.definition, group, KeychainExperiment.definition, communication] +
        ProtectionClass.allCases.map(\.definition)
    }
    static let url = ExperimentDefinition(id: "manual.url", name: "Own URL scheme round trip", category: .communication,
        objective: "Verify a nonce-bearing URL is delivered back to this app.", method: "Open sandboxresearchlab://probe with a random nonce; record open completion and validate the incoming nonce.",
        expectedBehavior: "The operating system opens the registered scheme and this process receives the exact pending nonce. A handler callback alone does not authenticate a sender.", automatic: false)
    static let document = ExperimentDefinition(id: "manual.document", name: "Document / share handoff", category: .communication,
        objective: "Offer a non-sensitive app-created document through the system share sheet.", method: "Write a lab-owned text document and use UIActivityViewController; record the activity completion callback.",
        expectedBehavior: "The user controls the destination. Completion confirms the system activity callback, not what another app stored.", automatic: false)
}

actor ExperimentRunner {
    func run(_ definition: ExperimentDefinition, environment: EnvironmentSnapshot) -> ExperimentRun {
        if let location = LabPaths.locations().first(where: { definition.id == "files.\($0.id)" }) {
            return FileAccessExperiment.run(location: location, environment: environment)
        }
        if definition.id == PersistenceExperiment.definition.id {
            return PersistenceExperiment.run(directory: LabPaths.support.appendingPathComponent("Persistence"), environment: environment)
        }
        if definition.id == ConfigurationService.definition.id { return ConfigurationService.run(environment: environment) }
        if definition.id == KeychainExperiment.definition.id { return KeychainExperiment.run(environment: environment) }
        if let type = ProtectionClass.allCases.first(where: { $0.definition.id == definition.id }) {
            return ProtectionExperiment.run(type, environment: environment)
        }
        var recorder = EvidenceRecorder(definition, environment: environment)
        if definition.id == ExperimentCatalog.group.id {
            if let url = ConfigurationService.groupURL {
                return FileAccessExperiment.run(location: TestLocation(id: "app-group", name: "Optional App Group", url: url), environment: environment, category: .appGroup)
            }
            recorder.record("RESOLVE_GROUP", resource: ConfigurationService.expectedGroup.nonempty(or: "No group configured"), expected: "Resolve an entitled App Group container",
                            actual: "No authorized container resolved. Enable App Groups in Signing & Capabilities, select your group, and set LabAppGroupIdentifier to the same identifier. Rebuild with a matching provisioning profile.", state: .notSupported)
        } else if definition.id == ExperimentCatalog.communication.id {
            recorder.record("URL_SCHEMES", resource: "CFBundleURLTypes", expected: "Read own declared schemes",
                            actual: ConfigurationService.schemes.joined(separator: ", "), state: .pass,
                            details: ["knowledge": Knowledge.configured.rawValue, "compare.schemes": ConfigurationService.schemes.joined(separator: ",")])
            for (operation, message) in [
                ("URL_ROUND_TRIP", "Use Manual Lab → Open own URL scheme."),
                ("DOCUMENT_HANDOFF", "Use Manual Lab → Share lab document. JSON/Markdown exports also use system sharing."),
                ("UNIVERSAL_LINK", "No owned web domain is assumed. Configure Associated Domains and AASA as documented, then tap a link from outside the app."),
                ("SHARE_EXTENSION", "No extension is bundled. The system share sheet can invoke installed, user-selected extensions. App Group file access does not prove a second process exchanged data.")
            ] {
                recorder.record(operation, resource: "User-mediated communication", expected: "Observe only actual handoffs", actual: message,
                                state: operation == "SHARE_EXTENSION" ? .notSupported : .notTested)
            }
        } else {
            recorder.record("DISPATCH", resource: definition.id, expected: "Known experiment", actual: "Unknown experiment identifier", state: .notSupported)
        }
        return recorder.finish()
    }
}
