# Build verification

Implementation-time verification was performed on Bazzite Linux on 2026-10-31 with Swift 6.4.2 and the installed Darwin/iPhoneOS 27.2 SDK. Deployment target is iOS 17.0. These build tools do not establish which OS is installed on the researcher's phone.

## Executed checks

- Portable Swift package: **23 XCTest tests passed, zero failures**. Coverage includes JSON schema/identity/summary validation, errors and notes, report sections and escaping, result aggregation, OSStatus evaluation, log filters, session comparison, storage corruption/isolation, duplicate imports, interrupted sessions, formatting, isolated host file operations and persistence-baseline control flow.
- `xtool dev build --configuration release --ipa`: arm64 iOS application compiled, linked and packaged successfully. Strict concurrency checking is enabled. An initial Objective-C type-name ambiguity was corrected before the successful build.
- `plutil -lint`: app metadata, empty entitlement file, privacy manifest and Xcode project parsed successfully.
- Xcode project regenerated from the exact app source list; the local Core package is shared by both build paths. Xcode merges generated mandatory bundle metadata with the supplied Info.plist.
- Artifact structural validation checks ZIP integrity, root Info.plist, an arm64 Mach-O executable, signature structure presence, privacy manifest, URL scheme and icon. It is not cryptographic trust or device installation validation.
- Source review searched for unfinished implementation markers, force unwraps/casts and private APIs; a second pass corrected URL callback ordering, made artifact I/O actor-isolated, prevented signed-configuration claims from metadata, and classified unexpected post-delete Keychain success as review-worthy.

## Signing result

An Apple-signing attempt used the existing xtool account. xtool required revocation of existing development certificates and cancelled without completing signing. No certificate revocation was authorized. The release IPA is therefore **not Apple-provisioned for device installation**. xtool's local/ad-hoc signature allows packaging but is not a substitute for your Apple profile and identity. Sign through Xcode, xtool with an appropriate account/certificate setup, or your trusted signing workflow before installation. Do not mistake an embedded code-signature structure for device authorization.

## Checks requiring other environments

The repository includes a macOS GitHub Actions job that runs the portable tests, validates the Xcode project and builds the app for a generic iOS Simulator destination without signing. Consult the actual workflow run for its outcome; this document does not assume a queued workflow passed.

No physical iPhone experiments, protected-data transitions, Keychain outcomes, provisioned App Group accesses, universal-link associations, visual/accessibility checks or installation tests were performed during Linux implementation. There are no device-generated example results in the repository. Those observations must come from running the app on your device.

## Reproduce

```sh
swift test --package-path Core
xtool dev build --configuration release --ipa
python3 Scripts/validate_ipa.py xtool/SandboxResearchLab.ipa
```

On a Mac:

```sh
xcodebuild -project SandboxResearchLab.xcodeproj -scheme SandboxResearchLab \
  -configuration Release -destination 'generic/platform=iOS Simulator' \
  CODE_SIGNING_ALLOWED=NO build
```
