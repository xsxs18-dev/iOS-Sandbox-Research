import Foundation
import ResearchCore

enum ConfigurationService {
    static var expectedGroup: String {
        Bundle.main.object(forInfoDictionaryKey: "LabAppGroupIdentifier") as? String ?? ""
    }
    static var groupURL: URL? {
        guard !expectedGroup.isEmpty, expectedGroup.hasPrefix("group."), !expectedGroup.contains("$(") else { return nil }
        return FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: expectedGroup)
    }
    static var schemes: [String] {
        (Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [[String: Any]] ?? [])
            .flatMap { $0["CFBundleURLSchemes"] as? [String] ?? [] }
    }
    static var facts: [ConfigurationFact] {
        let info = Bundle.main.infoDictionary ?? [:]
        func configured(_ key: String) -> String {
            guard let value = info[key] as? String, !value.isEmpty, !value.contains("$(") else { return "Not supplied by this build" }
            return value
        }
        return [
            ConfigurationFact("Bundle identifier", Bundle.main.bundleIdentifier ?? "Unavailable", .observed),
            ConfigurationFact("Build application identifier", configured("LabApplicationIdentifier"), .configured),
            ConfigurationFact("Build team", configured("LabSigningTeam"), .configured),
            ConfigurationFact("Signed application identifier / team", "Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.", .manual),
            ConfigurationFact("Expected App Group", expectedGroup.isEmpty ? "Not configured" : expectedGroup, .configured),
            ConfigurationFact("App Group container", groupURL?.path ?? "Unavailable for the expected identifier", groupURL == nil ? .unavailable : .observed),
            ConfigurationFact("Keychain Access Groups", "The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.", .manual),
            ConfigurationFact("All signed entitlements", "No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.", .unavailable),
            ConfigurationFact("URL schemes", schemes.joined(separator: ", "), .configured),
            ConfigurationFact("Associated domains (declared metadata)", (info["LabAssociatedDomains"] as? [String] ?? []).joined(separator: ", ").nonempty(or: "None declared"), .configured),
            ConfigurationFact("Universal-link association", "Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.", .manual),
            ConfigurationFact("Share/document communication", "System share sheet for app-created files; user-selected JSON import. No bundled share extension or implicit shared-container access.", .configured)
        ]
    }
    static let definition = ExperimentDefinition(id: "configuration.inspect", name: "Entitlements & configuration", category: .entitlements,
        objective: "Separate observed values from build configuration and unavailable signing information.",
        method: "Read this app's Bundle metadata and resolve the explicitly configured App Group using FileManager.",
        expectedBehavior: "Only directly observed configuration is reported as observed; signed grants are not inferred from Info.plist.")
    static func run(environment: EnvironmentSnapshot) -> ExperimentRun {
        var recorder = EvidenceRecorder(definition, environment: environment)
        for fact in facts {
            let state: ResultState = fact.knowledge == .unavailable ? .notSupported : fact.knowledge == .manual ? .notTested : .pass
            recorder.record(fact.name, resource: "This application's configuration", expected: "Report provenance accurately",
                            actual: fact.value, state: state, details: ["knowledge": fact.knowledge.rawValue,
                                "compare.configuration": fact.name == "App Group container" ? (fact.knowledge == .observed ? "Resolved" : "Unavailable") : fact.value])
        }
        return recorder.finish()
    }
}

extension String {
    func nonempty(or fallback: String) -> String { isEmpty ? fallback : self }
}
