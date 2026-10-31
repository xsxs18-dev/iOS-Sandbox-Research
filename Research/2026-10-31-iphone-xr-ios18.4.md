# Research notes: iPhone XR · iOS 18.4 (22E240) · 2026-10-31

The raw data and reports are in [Example-Reports/2026-10-31-iphone-xr-ios18.4](../Example-Reports/2026-10-31-iphone-xr-ios18.4/README.md), including the procedure, timeline and redaction. These notes separate what was **observed** from how it is **interpreted**. None of the results is a vulnerability claim.

## Context that matters for every result

- **Physical device**: iPhone XR (`iPhone11,8`), iOS 18.4 build 22E240, Developer Mode on. `protectedDataAvailable` was `true` in every recorded sample.
- **Build**: SandboxResearchLab 1.0.0. The app sources match tag `v1.0.0`, but the exact binary provenance isn't verified (see the run README).
- **Signing**: the repository ships an *empty* entitlements file. The installed build was re-signed on the device with a development certificate. A host-side query of the installed app (`installation_proxy`) showed what that signer actually granted:
  - 44 entitlement keys, including `get-task-allow = true`, `keychain-access-groups = ["TEAMID.*", "com.apple.token"]`, five `com.apple.security.application-groups` (`group.<signer-id>.1` to `.5`), `com.apple.developer.associated-domains = "*"`, `icloud-services = "*"`, HealthKit, HomeKit, Network Extension and more.
  - `application-identifier` is `TEAMID.app.<signer-generated>`. It does not match the bundle ID `com.xsxs18.sandboxresearchlab`.
  - The configuration experiment correctly reported the build-time team and application identifier as "Not supplied by this build". The signed values above are the manual verification the app asks for.

So the results describe the lab **as signed by this signer**, not as the repository would sign it with a minimal profile.

## Findings

### 1. App container: subdirectories fully usable, container root is not writable

**Observed.** The full lifecycle passed in all three suite runs and in the single runs: create directory, create, read, modify, enumerate, attributes, delete with verified absence, and clean-up. This held in `Documents`, `Library`, `Library/Caches`, `Library/Application Support` and `tmp`. Creating a directory directly in the container root (`NSHomeDirectory()`) was **DENIED** 4 of 4 times with `NSCocoaErrorDomain 513` and underlying `NSPOSIXErrorDomain 1` (EPERM). All later operations for that location are `NOT_TESTED`, because their prerequisite failed. Test files were owned by `mobile:mobile` (UID/GID 501) with mode `0644`.

**Interpretation.** On iOS 18.4, the data-container root is not writable for the app itself, while the standard subdirectories are. This is ordinary platform enforcement and matches Apple's guidance to write into those subdirectories. The `App Home` row in the file-access matrix shows `NOT_TESTED` for READ/WRITE and so on. The actual observation is the single `DENIED` on `DIRECTORY_CREATE`.

### 2. Persistence across launches

**Observed.** The marker written at 12:18:10 CET was read back byte-identical in suite run `02` (13:25, new launch ID). A fresh baseline from `02` was then confirmed in `03` (13:26, another new launch ID). Both relaunches were done by terminating and relaunching the process from the host. There was no reinstall in between.

**Interpretation.** App-owned Application Support data survives process termination, as expected. These runs say nothing about cache purging, reinstallation or backup restore.

### 3. Keychain: lifecycle works, but the item lands in the signer's wildcard group

**Observed.** Create, read, update, read-updated and delete all returned `OSStatus 0`. The post-delete lookup returned `-25300` (`errSecItemNotFound`), as expected. This was consistent in all runs. The access-group attribute of the lab's own item was **`TEAMID.*`**. 8 other apps installed on the same phone carry the identical `keychain-access-groups` entitlement.

**Interpretation.** An item added without an explicit `kSecAttrAccessGroup` goes to the first entitled group, and here that is the signer's wildcard group. Apps signed with the same team and the same wildcard entitlement are therefore *entitled* to that group. This follows from the signing configuration, not from an iOS sandbox weakness: iOS enforced exactly the groups it was given. The lab didn't test cross-app access, and these notes don't claim it happened.

**Practical consequence.** Keychain data in sideloaded apps signed this way should not be considered private to one app. For research builds, record the signed `keychain-access-groups`, and prefer an explicit App ID with a restricted group.

### 4. File protection: classes apply, but no locked-state measurement was possible

**Observed.** In all suite runs, all four classes were set on app-created files and read back successfully in the foreground: Complete, CompleteUnlessOpen, CompleteUntilFirstUserAuthentication and None. In the lock/unlock observation (`06`):

| Time (CET) | Event | Reads (A, B, C, D, held B handle) |
| --- | --- | --- |
| 13:28:39 | armed while unlocked, 4 files created | — |
| 13:29:00.581 | `protectedDataWillBecomeUnavailable` delivered | all PASS, 1–5 ms after the notification |
| — | phone locked for about 15 s | **no sample**: the process wasn't running |
| 13:29:15.777 | `protectedDataDidBecomeAvailable` delivered | all PASS |
| 13:29:16.246 | `didBecomeActive` delivered | all PASS |
| 13:30:07 | stopped, handle closed, files removed | — |

**Interpretation.** iOS delivered both protected-data notifications around the lock. The reads right after "will become unavailable" succeed because class keys are discarded only after a short grace period. During the locked interval the app received no execution time, so **there is no evidence about access while locked**. The data neither supports nor contradicts Class A enforcement. Measuring that would need a process that keeps running while locked (for example a background task), which this foreground lab doesn't have.

### 5. Communication

**Observed.**
- *Own URL scheme*: `UIApplication.open` reported `true`, and the exact random nonce arrived at `onOpenURL` about 80 ms later.
- *Share sheet*: the lab document was handed to the system share sheet, and **Copy** (`com.apple.UIKit.activity.CopyToPasteboard`) reported completion.
- *Universal links*: `NOT_TESTED`, because no owned domain or AASA file was configured.
- *Share extension*: `NOT_SUPPORTED`, because none is bundled.

**Interpretation.** Round-trip delivery of the app's own scheme works on iOS 18.4. Completion of the share activity only confirms the system callback, not what the destination stored.

### 6. App Groups: entitled but not configured

**Observed.** The App Group experiment reported `NOT_SUPPORTED`, because the build's `LabAppGroupIdentifier` is empty. The signed build nevertheless carries five application-group entitlements from the signer.

**Interpretation.** This is correct behavior: the lab only tests a group it was explicitly configured for and doesn't probe groups it happens to be entitled to. Testing one of the signer's groups would need a rebuild with `LabAppGroupIdentifier` set to that group.

### 7. Tool finding: the session comparison flagged identical errors as changed (fixed)

**Observed.** Comparing any two suite runs listed `files.home / DIRECTORY_CREATE` as "error changed". The domain (`NSCocoaErrorDomain`), code (513) and underlying error (POSIX 1) were identical. Only the localized description differed, because it contains the run's random lab directory name.

**Fix.** `SessionComparison` now compares errors by domain, code and the underlying error's domain and code (`ResearchError.comparisonKey`), not by the localized description. The regression test `testComparisonIgnoresRandomPathsInsideErrorDescriptions` covers it. With the fix, run `02` → `03` shows 0 changes. Version 1.0.0 on the phone still has the old behavior until it's rebuilt.

## Repeatability

- Suite `02` → `03`: **identical**, with 0 changed operations and no context differences.
- Suite `01` → `02`: only the persistence check changed, from baseline to verified, which is expected.
- 15 of 16 single-experiment runs matched suite `01` exactly. The persistence single run differs only because it created the baseline.

## Not covered by this run

Access before the first unlock after a reboot. Data access while the device is locked (see 4). Cross-app Keychain or App Group exchange. Universal links. Simulator comparisons. Any other iOS version. A run with a minimally entitled build, which would be the most useful next step for comparing the Keychain and App Group results.
