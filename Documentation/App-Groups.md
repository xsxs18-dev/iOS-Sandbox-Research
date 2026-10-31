# Optional App Group lab

The default build has no App Group entitlement and an empty `LabAppGroupIdentifier`. The experiment reports `NOT_SUPPORTED` with setup instructions. This is a supported baseline, not an app error.

## Xcode setup

1. Select your Apple Developer Team for the app target.
2. Add the public **App Groups** capability and register/select a group owned by your team, for example a unique `group.<your-domain>.sandboxlab` identifier.
3. Set `LabAppGroupIdentifier` in `Resources/Info.plist` to that exact identifier. This metadata names the expected group; it cannot grant access.
4. Ensure `Resources/SandboxResearchLab.entitlements` contains the group in `com.apple.security.application-groups` and that the signing profile grants it. Xcode's capability editor normally updates the entitlement file.
5. Rebuild/sign/install and run **Optional App Group** or the full suite.

## Linux / xtool setup

Use the same Info.plist metadata and entitlement file; `xtool.yml` already references `entitlementsPath: Resources/SandboxResearchLab.entitlements`. Register the group and application membership in your Apple Developer account. Use a provisioning/signing configuration that actually grants this entitlement. App Group support depends on account/capability availability; a free personal team may not grant it. Do not add an arbitrary identifier and assume signing authorizes it.

The optional entitlement structure is:

```xml
<key>com.apple.security.application-groups</key>
<array><string>group.YOUR_OWN_REGISTERED_IDENTIFIER</string></array>
```

Replace the illustrative identifier with your registered group. No restricted Apple entitlement is involved.

The app calls `FileManager.containerURL(forSecurityApplicationGroupIdentifier:)` only for the explicit configured identifier. If resolution succeeds, a unique child receives the same create/read/modify/delete/attributes/enumeration lifecycle as container tests. If resolution returns nil, no group files are accessed. Signing and device execution are required to prove it works.

This records this app's group-container access. It does not claim another app or extension read the data. A second process must be separately owned, signed into the same group and explicitly tested for that claim. See [Apple's container API](https://developer.apple.com/documentation/foundation/filemanager/containerurl(forsecurityapplicationgroupidentifier:)).
