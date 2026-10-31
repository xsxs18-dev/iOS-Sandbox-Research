# iOS-Sandbox-Research

**SandboxResearchLab is a defensive, evidence-driven iOS research application.** It measures ordinary access to its own container, its own newly created Keychain item, and an explicitly authorized App Group. It uses SwiftUI, Foundation, UIKit and Security with no third-party runtime dependencies.

This is a research tool, not an exploit framework. It contains no sandbox escapes, private security APIs, cross-app container probes, credential collection, or automatic vulnerability claims. Every observation comes from a recorded operation. Software test fixtures never become research reports.

## Quick start

### Bazzite / Linux with xtool

With Swift and the Darwin SDK installed (`swift sdk list` should include `darwin`):

```sh
git clone https://github.com/xsxs18-dev/iOS-Sandbox-Research.git
cd iOS-Sandbox-Research
swift test --package-path Core
xtool dev build --configuration release --ipa
```

`xtool dev build` compiles and bundles without Apple provisioning unless `--sign` is supplied. An unsigned or ad-hoc signed IPA needs valid Apple signing before installation. Read the release notes for the **actual** signing status of each downloadable artifact.

To install your own development build, connect and trust your iPhone, enable Developer Mode, configure your Apple account with `xtool auth login` if necessary, and run:

```sh
xtool dev
```

To produce an Apple-signed IPA with configured signing and a registered device:

```sh
xtool dev build --configuration release --sign --ipa
```

The checked-in `xtool.yml` supplies metadata, an icon, the privacy manifest and empty default entitlements. Optional App Groups need developer-account provisioning; see [App Groups](Documentation/App-Groups.md). For toolchain installation and device pairing, use the [official xtool instructions](https://xtool.sh/documentation/xtool/installation-linux/) and [device tutorial](https://xtool.sh/tutorials/xtool/first-app/).

### Xcode / macOS

1. Open **SandboxResearchLab.xcodeproj**, not the top-level package as a macOS app.
2. Select the **SandboxResearchLab** scheme and your iPhone (iOS 17 or later).
3. Under the app target's **Signing & Capabilities**, select your Apple Developer Team. Change the bundle identifier if your account requires a unique identifier.
4. Keep automatic signing enabled. The default build needs no App Groups or Keychain Sharing capability.
5. Connect/trust the device, enable Developer Mode when prompted, and press **Run**.

Use a current Xcode release supporting Swift tools 6.0 and your device OS (Xcode 16 or newer). The local `Core` package resolves without downloading dependencies. On macOS, `swift test --package-path Core` runs the portable tests; the app scheme builds the iOS application.

## Run real research

On **Dashboard**, press **Run Safe Research Suite**. The app runs 15 automatic experiments sequentially, displays `Experiment N/15`, and checkpoints the session after each experiment. Keep the app in the foreground. A terminated session is shown as interrupted next launch; it is never silently treated as completed.

Open the latest session for the file-access matrix, objectives, methods, expected and actual behavior, errors, evidence IDs, and notes. **Logs** filters evidence by experiment, category, state and text. **History** supports viewing, importing, comparing, exporting and deleting sessions.

The first persistence test creates a baseline and reports `NOT_TESTED` for cross-launch survival. Terminate and relaunch the app, then run it again without reinstalling. Use **Manual Lab** for lock-state observations, a selected file-protection class, an own-scheme URL round trip, or sharing a non-sensitive lab document.

## Experiments

| Category | Implemented behavior | Qualification |
| --- | --- | --- |
| Own container | Home, Documents, Library, Caches, tmp, Application Support; create directory/file, read, modify/read back, enumerate, attributes, delete/verify, cleanup | Only unique lab children are touched |
| Persistence | Marker and independent receipt across process launches | First launch and same-launch repeats are not persistence proof |
| Entitlements | Bundle and build metadata, provenance, group resolution, own Keychain item's observed group | No unsupported general entitlement dump |
| App Group | Full file lifecycle in the explicitly resolved group | Optional; missing configuration is `NOT_SUPPORTED` |
| Keychain | Add, retrieve/verify, update, retrieve/verify, delete, verify not found | Unique service/account, no broad queries |
| Communication | Scheme/configuration inspection; manual own-URL callback and document sharing; incoming configured universal-link activities | No private service calls or unrequested app probing |
| File protection | Create/set/inspect/read/delete for all four documented classes | Attribute checks alone do not prove lock enforcement |
| Manual lock observation | Closed-file reads plus a retained Class B handle around delivered notifications | iOS suspension and event timing limit observations |

There is no bundled receiving share extension. Public share-sheet interaction can exercise installed extensions chosen by the researcher. This lab's App Group access establishes this process's access, not proof of cross-process exchange. Universal links are optional because a researcher-owned web domain and AASA deployment are required; see [Communication](Documentation/Communication.md).

## Results and interpretation

| State | Meaning |
| --- | --- |
| `PASS` | The operation met its stated expectation |
| `DENIED` | Access was refused; normal enforcement is a possible explanation |
| `ERROR` | An operational error prevented a clean result |
| `NOT_SUPPORTED` | The capability/configuration was unavailable |
| `NOT_TESTED` | Not performed, prerequisite missing, or interaction/later launch required |
| `NEEDS_REVIEW` | Recorded behavior contradicted an expectation; manually investigate |

An experiment's summary is conservative: review > error > denied > not tested > pass > not supported. Read individual operations, especially when a configuration experiment combines observations with manual verification requirements. **No state means “vulnerability confirmed.”**

## Exports and iOS-version comparisons

Choose **Export JSON & Markdown** in a session. Both files are offered through the system share sheet. JSON schema version 1 preserves environment snapshots, timestamps, operations, results, error domain/code/description, evidence identifiers and researcher notes. Dates are milliseconds since Unix epoch in JSON and ISO 8601 in Markdown. Exports contain real app paths and signing-related configuration; review before sharing.

For comparisons, retain a baseline export before updating iOS. Run the same procedure after updating; import the older JSON via **History → Import session JSON** if needed. Choose **Compare two sessions**, with A as baseline and B as follow-up. The UI highlights changed states/configuration/errors, new failures, newly allowed operations and review candidates. It matches experiment/operation identifiers rather than random test paths. Error descriptions are preserved verbatim, so path-specific error messages can also appear as error changes. Hardware, signing, app build and protection-state differences are shown as confounders. Imported evidence is explicitly unauthenticated; duplicate session IDs are rejected.

## Architecture and repository

```text
SandboxResearchLab.xcodeproj/      Ready-to-open iOS project and shared scheme
Package.swift, xtool.yml           Linux iOS build path
Sources/SandboxResearchLab/
  UI/                             Dashboard, matrix, logs, manual lab, history, comparison
  Services/                       Main-actor UI state, environment, configuration, artifacts
  Experiments/                    iOS runner, Keychain, file-protection/notification probes
Core/
  Sources/ResearchCore/
    Models/                       Codable sessions, experiments, evidence, errors
    Experiments/                  Reusable file-access and persistence engines
    Logging/                      Recorder, classification and filters
    Persistence/                  Actor-isolated atomic session storage
    Reporting/                    Markdown generation and semantic comparisons
    Utilities/                    JSON validation and formatting
  Tests/ResearchCoreTests/         Portable unit and isolated host-filesystem tests
Resources/                        Info.plist, entitlements, icon, privacy manifest
Documentation/                    Security model and reproducible procedures
Research/                         Handling real findings and private evidence
Example-Reports/                   Policy: no fabricated device observations
Scripts/                          Reproducible project generation and artifact validation
```

UI state is main-actor isolated. Filesystem/Keychain experiments and session persistence execute through worker actors. Sessions are checkpointed between experiments; a process kill during an individual experiment can leave its latest uncheckpointed operations and uniquely named test files unrecorded. The app never sweeps arbitrary directories to hide that limitation.

## Screenshots

Device screenshots have not been manufactured. Capture these after running on your own iPhone: dashboard, file-access matrix, filtered evidence, comparison, and manual protection observations. Remove container identifiers or personal notes before publishing them. UI supports Dynamic Type, semantic system colors, dark appearance, VoiceOver labels and scrollable matrix columns; visual/device accessibility review still requires running the app.

## Validation

Run `swift test --package-path Core`. Tests cover report generation, JSON validation/round trips, state aggregation, exact errors, filtering, comparisons, atomic storage, malformed files, duplicate import rejection and isolated host-filesystem orchestration. Synthetic fixtures are clearly identified in test source. They do **not** validate iOS sandbox enforcement, Keychain behavior, locked-device protection or physical persistence. See [Build verification](Documentation/Build-Verification.md) for the actual implementation-time checks and their limits.

## Limits and ethics

No network collection or telemetry runs in the app. No device name, serial number, advertising/vendor identifier, contact, photo or user credential is collected. The hardware model, OS/build, random per-process launch ID, app configuration and relevant lab paths are recorded. Notes and explicit exports are controlled by you. Sessions live in Application Support and may be included in normal device backups.

This measures allowed operations and normal API enforcement, not the completeness of the sandbox. Simulator behavior is labeled. Lock testing cannot force background execution or test pre-first-unlock access after reboot. Cached and temporary files can be purged. App deletion/reinstallation can invalidate continuity; Keychain lifetime can differ from container lifetime. Disk-full, protection and signing errors are not automatically security findings.

Use only apps, devices, groups and domains you own or are authorized to test. Preserve unexpected evidence and follow [SECURITY.md](SECURITY.md) and [Responsible Disclosure](Documentation/Responsible-Disclosure.md) before making any security claim.
