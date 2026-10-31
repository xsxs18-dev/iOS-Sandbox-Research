# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: 8D6315E1-E70B-41E9-B26E-ABB0B7F3E4DF
- Date: 2026-10-31T12:26:50Z
- End: 2026-10-31T12:27:53Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): 6154A196-96FC-4C55-822A-0CF00B760458

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: Document / share handoff

- ID: manual.document
- Category: Communication
- Result: **PASS**
- Start: 2026-10-31T12:26:50Z
- End: 2026-10-31T12:27:53Z

### Objective

Offer a non-sensitive app-created document through the system share sheet.

### Method

Write a lab-owned text document and use UIActivityViewController; record the activity completion callback.

### Expected Behavior

The user controls the destination. Completion confirms the system activity callback, not what another app stored.

### Observed Behavior

- CREATE: **PASS** — Lab text document written
- SHARE: **PASS** — Activity reported completion; destination storage is not verified

### Evidence

#### CREATE · DC22372F-B7CC-4426-AB08-717D6E02E7A0

- Timestamp: 2026-10-31T12:26:50Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/LabExports-DDE32152-D4B6-42A0-826D-E2129BC6CFE4/SandboxResearchLab-Document.txt
- Expected: Create non-sensitive document
- Actual: Lab text document written
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SHARE · 957C7618-FA8F-4BE3-AF06-85AD66B8E9C0

- Timestamp: 2026-10-31T12:27:53Z
- Resource: com.apple.UIKit.activity.CopyToPasteboard
- Expected: User-selected activity reports completion
- Actual: Activity reported completion; destination storage is not verified
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Limitations

This report is generated from local evidence, not a security attestation. Configuration is not proof of signed entitlement grants. Lock-state, relaunch, signing and external link behavior require the documented manual checks. Imported sessions and researcher notes are not independently authenticated.
