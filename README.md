# iOS Sandbox Research

A hands-on lab for exploring what an ordinary iPhone app can do inside its own sandbox.

SandboxResearchLab lets you create files, try different protection settings, work with a disposable Keychain item, and keep a record of what happened. You can run the same experiments before and after an iOS update, compare the results, and export them for a closer look.

The app uses public Apple APIs and works with data it creates itself. It doesn't read another app's private files, bypass security controls, or turn an unexpected result into a vulnerability claim.

**[Download the IPA](https://github.com/xsxs18-dev/iOS-Sandbox-Research/releases/latest)** · **[Research methodology](Documentation/Research-Methodology.md)** · **[Build verification](Documentation/Build-Verification.md)**

> The v1.0.0 IPA is built, but still needs Apple signing and provisioning for your device. The code has been compiled for iOS and the portable tests have passed. Real iPhone observations and screenshots still need to come from running the app.

## What you can try

The dashboard has a **Run Safe Research Suite** button. It runs 15 automatic experiments and saves their results as a research session.

| Area | What the lab does |
| --- | --- |
| App container | Creates, reads, modifies and deletes test files in Home, Documents, Library, Caches, tmp and Application Support. Also checks directory creation, enumeration and file attributes. |
| Persistence | Leaves a small marker and checks whether it survives a later app launch. |
| Keychain | Creates a disposable item, reads it back, updates it, deletes it and checks that it is gone. |
| File protection | Applies and inspects all four documented protection classes on app-created files. |
| Entitlements | Shows app configuration and separates directly observed information from values that still need signing verification. |
| App Groups | Runs file operations in your configured, authorized group container. Without a group, it explains the setup. |
| Communication | Inspects the app's URL configuration. Manual tests cover an own-scheme callback and sharing a lab document through the system share sheet. |

**Manual Lab** contains the tests that need your involvement: locking and unlocking the phone, checking persistence after a relaunch, opening the app's URL scheme, and choosing a share destination. Universal-link delivery can also be recorded after you configure a domain you own. There is no bundled receiving share extension; the share sheet uses the apps and extensions you choose.

## Build and install

The app targets **iOS 17 or later**. It uses SwiftUI, Foundation, UIKit and Security, with no third-party runtime dependencies.

### On Linux / Bazzite

You'll need Swift, [xtool](https://xtool.sh/documentation/xtool/installation-linux/) and its Darwin SDK. `swift sdk list` should include `darwin`.

```sh
git clone https://github.com/xsxs18-dev/iOS-Sandbox-Research.git
cd iOS-Sandbox-Research
swift test --package-path Core
xtool dev build --configuration release --ipa
```

That builds the IPA without Apple device provisioning. To install a development build, set up your Apple signing account, connect and trust your iPhone, enable Developer Mode, then run:

```sh
xtool dev
```

If you haven't configured an account yet, use `xtool auth login`. With a working signing setup, you can also produce a signed IPA:

```sh
xtool dev build --configuration release --sign --ipa
```

See xtool's [device setup guide](https://xtool.sh/tutorials/xtool/first-app/) for pairing and installation. Read any certificate-management prompts carefully; replacing existing certificates can affect other development apps.

### In Xcode

1. Open `SandboxResearchLab.xcodeproj`.
2. Select the **SandboxResearchLab** scheme and your iPhone.
3. In **Signing & Capabilities**, choose your Apple Developer Team. Change the bundle identifier if needed for your account.
4. Leave automatic signing enabled and press **Run**.

Use Xcode 16 or newer, with support for your phone's iOS version. The default setup doesn't need App Groups or Keychain Sharing. Optional group setup is covered in [App-Groups.md](Documentation/App-Groups.md).

## Your first session

Open the app and press **Run Safe Research Suite** on the dashboard. Keep it in the foreground while the progress counter runs.

Open the completed session to see the file-access matrix and individual observations. Each record includes the operation, resource, expected result, actual result, timestamp, environment and any error. You can attach notes to a session or a specific piece of evidence. **Logs** lets you filter by experiment, category, result or text.

For the persistence test, the first run only establishes a baseline. Close the app from the app switcher, launch it again, and repeat the test without reinstalling. Only then can it check whether the marker survived.

For lock-state testing, use **Manual Lab → Arm lock-state observation**, lock and unlock the phone, then return and choose **Stop & save observation**. iOS may suspend the app while locked, so a missing sample tells you nothing about whether access would have succeeded.

## Reading the results

| Result | Meaning |
| --- | --- |
| `PASS` | This operation behaved as expected. |
| `DENIED` | iOS refused access. That may be normal enforcement. |
| `ERROR` | Something prevented a clean measurement; inspect the error. |
| `NOT_SUPPORTED` | The capability or required configuration wasn't available. |
| `NOT_TESTED` | The operation wasn't performed, or needs another action or launch. |
| `NEEDS_REVIEW` | An observation contradicted the expectation and deserves a closer look. |

Read the individual operations as well as the summary. A successful file read confirms that particular read; it doesn't prove the sandbox is secure. A denied operation doesn't establish a vulnerability either.

## Save, export and compare

Sessions are stored locally and appear in **History**, where you can view, compare, export or delete them. **Export JSON & Markdown** gives you both the complete structured data and a readable report through the system share sheet. Reports are generated from recorded operations, not prewritten example findings.

To compare iOS versions, export a baseline before updating, repeat the same procedure afterward, and choose **History → Compare two sessions**. You can import an older session's JSON if it is on another device. Choose the baseline as A and the follow-up as B.

The comparison highlights changed results and errors, new failures, newly allowed operations and records needing review. Keep the app build, signing setup, device and protection state as similar as possible. A difference isn't necessarily caused by the OS update. Imported sessions are marked as unauthenticated source data.

Exports contain relevant container paths, app configuration and any notes you add. Check them before sharing. The app has no telemetry or automatic report uploads.

## Finding your way around the code

```text
Sources/SandboxResearchLab/
  UI/                         Dashboard, experiments, manual lab, history and logs
  Services/                   App state, environment, configuration and exports
  Experiments/                iOS-specific Keychain and protection experiments
Core/
  Sources/ResearchCore/
    Models/                   Sessions, experiments, evidence and errors
    Experiments/              File-access and persistence engines
    Logging/                  Recording, filters and error classification
    Persistence/              Local session storage
    Reporting/                Markdown reports and session comparisons
    Utilities/                JSON validation and formatting
  Tests/ResearchCoreTests/    Portable tests
Resources/                    App metadata, icon, privacy manifest and entitlements
Documentation/                Setup guides and research procedures
Research/                     Guidance for handling real findings
Example-Reports/              No fabricated device reports
Scripts/                      Xcode project generation and IPA validation
SandboxResearchLab.xcodeproj/ Xcode project
Package.swift, xtool.yml      Linux/xtool build configuration
```

The UI runs on the main actor. File and Keychain work, exports and session storage use worker actors. The same Core package is used by both build paths. See [CONTRIBUTING.md](CONTRIBUTING.md) if you'd like to change or add an experiment.

## Tests and current limits

Run `swift test --package-path Core` to check the portable logic. The 23 tests cover JSON, reports, comparisons, state handling, errors, storage and file operations in isolated host directories. These are software tests, not evidence of iPhone sandbox behavior. The actual checks performed are recorded in [Build-Verification.md](Documentation/Build-Verification.md).

A few limits matter when interpreting a session:

- Simulator observations are labeled and shouldn't be treated as physical-device results.
- File-protection attributes alone don't prove locked-device enforcement. This foreground app cannot measure access before the first unlock after reboot.
- Caches and temporary files can be purged. Reinstallation or restoring a backup can invalidate a persistence baseline.
- Sessions are saved between experiments. Terminating the app during an experiment can lose its latest observations and leave its uniquely named test files behind.
- App Group access in this process doesn't prove that a second app exchanged data with it. Universal links need your own domain, association file and signing configuration.

## Screenshots

No device screenshots yet. Useful captures would be the dashboard after a real run, the file-access matrix and a session comparison. Review paths and notes before publishing a screenshot.

## Research responsibly

Use devices, apps, groups and domains you own or have permission to test. If something looks wrong, preserve the session, repeat the experiment on hardware, and rule out configuration, timing and measurement errors first.

See [SECURITY.md](SECURITY.md) and the [responsible-disclosure guide](Documentation/Responsible-Disclosure.md) for the next steps. Unexpected behavior stays a research question until the evidence supports a conclusion.
