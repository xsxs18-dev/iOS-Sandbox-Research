# Build verification

Implementation-time verification was performed on Bazzite Linux on 2026-10-31 with Swift 6.4.2 and the installed Darwin/iPhoneOS 27.2 SDK. Deployment target is iOS 17.0. These build tools do not establish which OS is installed on the researcher's phone.

## Executed checks

- Portable Swift package: **23 XCTest tests passed, zero failures** at implementation time (24 after the 2026-10-31 comparison fix). Coverage includes JSON schema/identity/summary validation, errors and notes, report sections and escaping, result aggregation, OSStatus evaluation, log filters, session comparison, storage corruption/isolation, duplicate imports, interrupted sessions, formatting, isolated host file operations and persistence-baseline control flow.
- `xtool dev build --configuration release --ipa`: arm64 iOS application compiled, linked and packaged successfully. Strict concurrency checking is enabled. An initial Objective-C type-name ambiguity was corrected before the successful build.
- `plutil -lint`: app metadata, empty entitlement file, privacy manifest and Xcode project parsed successfully.
- Xcode project regenerated from the exact app source list; the local Core package is shared by both build paths. Xcode merges generated mandatory bundle metadata with the supplied Info.plist.
- Artifact structural validation checks ZIP integrity, root Info.plist, an arm64 Mach-O executable, signature structure presence, privacy manifest, URL scheme and icon. It is not cryptographic trust or device installation validation.
- Source review searched for unfinished implementation markers, force unwraps/casts and private APIs; a second pass corrected URL callback ordering, made artifact I/O actor-isolated, prevented signed-configuration claims from metadata, and classified unexpected post-delete Keychain success as review-worthy.

## Signing result

An Apple-signing attempt used the existing xtool account. xtool required revocation of existing development certificates and cancelled without completing signing. No certificate revocation was authorized. The release IPA is therefore **not Apple-provisioned for device installation**. xtool's local/ad-hoc signature allows packaging but is not a substitute for your Apple profile and identity. Sign through Xcode, xtool with an appropriate account/certificate setup, or your trusted signing workflow before installation. Do not mistake an embedded code-signature structure for device authorization.

## Checks requiring other environments

The repository includes a macOS GitHub Actions job that runs the portable tests, validates the Xcode project and builds the app for a generic iOS Simulator destination without signing. The [initial workflow run](https://github.com/xsxs18-dev/iOS-Sandbox-Research/actions/runs/41195656752) could not start because GitHub reported an account billing/spending-limit restriction. No macOS build steps executed. Xcode runtime/build validation is therefore not claimed; the project passed local property-list validation and the same iOS Swift sources compiled with xtool. The workflow can be rerun once the account restriction is resolved.

No physical iPhone experiments were performed during Linux implementation. The device run below was added afterwards.

## Device verification (2026-10-31)

SandboxResearchLab 1.0.0 was installed with a development signature on an iPhone XR (`iPhone11,8`) running iOS 18.4 (22E240). It was then operated and read out over USB from Bazzite Linux with pymobiledevice3 11.17 ([Device-Automation.md](Device-Automation.md)).

- Install and launch on the device: the app stayed responsive through every step across three process launches (three launch IDs in the data); device crash logs were not inspected. The dashboard, Experiments, Manual Lab, History, session detail, file-access matrix and Compare views were displayed and operated.
- The suite ran 3 times with 15 experiments each, plus 16 single-experiment runs, own-URL round trip, share handoff and lock/unlock observation. That makes 22 sessions, all `completed`, with no `ERROR` or `NEEDS_REVIEW` records.
- Persistence was verified across two host-initiated relaunches without reinstall.
- All pulled sessions passed `SessionJSON.decode`, the same validation as the in-app import.
- Results and interpretation: [Research/2026-10-31-iphone-xr-ios18.4.md](../Research/2026-10-31-iphone-xr-ios18.4.md). Data: [Example-Reports/2026-10-31-iphone-xr-ios18.4](../Example-Reports/2026-10-31-iphone-xr-ios18.4/README.md).
- Found and fixed: session comparison treated identical errors as changed, because the localized description contains a random path. The fix is in `ResearchCore` with a regression test, so there are now 24 portable tests. The installed 1.0.0 binary still contains the old comparison until it is rebuilt.

Still not verified on hardware: access while locked (the foreground app is suspended while locked), before-first-unlock behavior, provisioned App Group file access with `LabAppGroupIdentifier` set, universal links, and the Xcode build path.

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
