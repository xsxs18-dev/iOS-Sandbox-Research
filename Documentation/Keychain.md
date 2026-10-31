# Keychain sandbox lab

Each run generates a unique service name and a fixed account scoped by that service. All add/read/update/delete queries include the exact class, service, account and non-synchronizing setting. The item uses `kSecAttrAccessibleWhenUnlockedThisDeviceOnly`; it is a non-sensitive random probe, not a real credential.

The sequence is `SecItemAdd`, `SecItemCopyMatching` with data and attributes, byte comparison, `SecItemUpdate`, a second read/verification, `SecItemDelete`, and a final query expecting `errSecItemNotFound`. A failed creation prevents later operations; no duplicate or unrelated item is removed. Cleanup errors remain visible. Evidence stores the service name needed to identify a rare cleanup failure, the OSStatus integer and its `SecCopyErrorMessageString` explanation. Secret bytes are never logged. The returned access-group attribute, when available, is observed only for this new item.

Common statuses include `errSecSuccess` (0), `errSecItemNotFound` (-25300), `errSecDuplicateItem` (-25299), `errSecAuthFailed` (-25293), `errSecInteractionNotAllowed` (-25308), and `errSecMissingEntitlement` (-34018). Meaning depends on the operation: not-found is expected after deletion, but not after a successful add/read sequence. Protection or entitlement refusal is `DENIED`; mismatched verified values require review.

Keychain storage can outlive app-container removal and has its own data-protection behavior. Reinstalling does not reliably prove deletion of prior items. This project does not use Keychain Sharing, synchronizable items, biometric prompts or broad Keychain enumeration in its baseline. Public APIs execute on the experiment actor, away from the main UI actor.

References: [SecItemCopyMatching](https://developer.apple.com/documentation/security/secitemcopymatching(_:_:)), [Keychain data protection](https://support.apple.com/guide/security/keychain-data-protection-secb0694df1a/web).
