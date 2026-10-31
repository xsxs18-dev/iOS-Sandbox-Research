import Foundation
import Security
import ResearchCore

enum KeychainExperiment {
    static let definition = ExperimentDefinition(id: "keychain.own-item", name: "Keychain lifecycle", category: .keychain,
        objective: "Measure create, retrieve, update and delete for a single item owned by this run.",
        method: "Use a unique generic-password service/account, non-synchronizing ThisDeviceOnly accessibility, and exact-match queries. Verify byte equality without exporting the bytes.",
        expectedBehavior: "An app can manage its own item when protected data is accessible; deletion is verified by errSecItemNotFound.")

    static func run(environment: EnvironmentSnapshot) -> ExperimentRun {
        var recorder = EvidenceRecorder(definition, environment: environment)
        let resource = "lab.keychain.\(UUID().uuidString)"
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                    kSecAttrService as String: resource, kSecAttrAccount as String: "lab-owned-probe",
                                    kSecAttrSynchronizable as String: false]
        let initial = Data(UUID().uuidString.utf8); let updated = Data(UUID().uuidString.utf8)
        func record(_ operation: String, status: OSStatus, expected: OSStatus = errSecSuccess, verified: Bool = true, details: [String: String] = [:]) {
            let explanation = SecCopyErrorMessageString(status, nil) as String? ?? "No OSStatus explanation available"
            let error = status == expected ? nil : ResearchError(domain: NSOSStatusErrorDomain, code: Int(status), description: explanation)
            let state = OperationEvaluation.osStatus(actual: Int(status), expected: Int(expected), verified: verified)
            recorder.record(operation, resource: resource, expected: "OSStatus \(expected); returned values match when applicable",
                            actual: "OSStatus \(status): \(explanation). Verification: \(verified ? "matched / not applicable" : "mismatch")",
                            state: state, error: error, details: details.merging(["OSStatus": String(status), "expectedOSStatus": String(expected)]) { _, new in new })
        }
        var add = query
        add[kSecValueData as String] = initial
        add[kSecAttrAccessible as String] = kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        let added = SecItemAdd(add as CFDictionary, nil)
        record("CREATE", status: added)
        guard added == errSecSuccess else {
            for operation in ["READ", "UPDATE", "READ_UPDATED", "DELETE", "VERIFY_DELETED"] {
                recorder.record(operation, resource: resource, expected: "Operate on this run's item", actual: "Creation failed; no existing items queried or removed", state: .notTested)
            }
            return recorder.finish()
        }
        var read = query
        read[kSecReturnData as String] = true
        read[kSecReturnAttributes as String] = true
        read[kSecMatchLimit as String] = kSecMatchLimitOne
        var output: CFTypeRef?
        let readStatus = SecItemCopyMatching(read as CFDictionary, &output)
        let attributes = output as? [String: Any]
        record("READ", status: readStatus, verified: readStatus != errSecSuccess || attributes?[kSecValueData as String] as? Data == initial,
               details: ["compare.observedAccessGroup": attributes?[kSecAttrAccessGroup as String] as? String ?? "Unavailable",
                         "knowledge": "Observed attribute of this run's own item; not a list of all entitled groups"])
        record("UPDATE", status: SecItemUpdate(query as CFDictionary, [kSecValueData as String: updated] as CFDictionary))
        output = nil
        let updatedStatus = SecItemCopyMatching(read as CFDictionary, &output)
        record("READ_UPDATED", status: updatedStatus, verified: updatedStatus != errSecSuccess || (output as? [String: Any])?[kSecValueData as String] as? Data == updated)
        record("DELETE", status: SecItemDelete(query as CFDictionary))
        output = nil
        record("VERIFY_DELETED", status: SecItemCopyMatching(read as CFDictionary, &output), expected: errSecItemNotFound)
        return recorder.finish(notes: "No Keychain secret is logged. If deletion fails, the exact unique service is retained in evidence for manual cleanup; no broad Keychain deletion is performed.")
    }
}
