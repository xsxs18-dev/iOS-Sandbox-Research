# File protection research

The automatic suite creates a non-sensitive file for each documented `FileProtectionType`, applies the class using `setAttributes`, checks the returned `.protectionKey`, reads back known bytes, and removes the file. Manual Lab also lets you choose one class directly.

| Class | Intended protection behavior |
| --- | --- |
| `.complete` | File data becomes inaccessible shortly after the device locks; timing includes platform behavior and a grace interval |
| `.completeUnlessOpen` | Existing files opened before lock can remain usable through that handle; closed existing files have different access constraints; new-file behavior has additional Class B semantics not exhaustively tested here |
| `.completeUntilFirstUserAuthentication` | Data is unavailable until first unlock after boot, then remains available through subsequent locks |
| `.none` | No lock-dependent file protection; this does not imply absence of hardware/storage encryption |

Apple's [Data Protection classes](https://support.apple.com/guide/security/data-protection-classes-secb010e978a/web) describe the key lifecycle. Use [FileProtectionType](https://developer.apple.com/documentation/foundation/fileprotectiontype) for the public API.

## Manual lock-state protocol

1. Unlock the phone, open Manual Lab, and press **Arm lock-state observation**. Four app-owned files are created, and one Class B read handle is retained.
2. Lock the device, wait briefly, unlock, and return to the app.
3. Press **Sample now** if needed, then **Stop & save observation**. The retained handle is closed and the files are removed with recorded outcomes.
4. Inspect each sample's timestamp, triggering event, protected-data availability and read result. Export the session and attach your manual timing notes.

Notification callbacks are opportunities to observe, not precise cryptographic state transitions. `protectedDataWillBecomeUnavailable` may arrive before keys become unavailable. The app may be suspended immediately; it requests no artificial background privileges. A successful read near a transition is not automatically anomalous. A denied read is recorded as denial, not automatically a vulnerability or a complete enforcement proof.

The app cannot run before first unlock after reboot to establish Class C behavior using this foreground workflow. An already-open handle and a newly opened file are distinct tests. The suite does not fabricate results for unexecuted lock intervals. Force quitting while armed closes process handles but may leave uniquely named test files; no broad automatic cleanup is attempted.
