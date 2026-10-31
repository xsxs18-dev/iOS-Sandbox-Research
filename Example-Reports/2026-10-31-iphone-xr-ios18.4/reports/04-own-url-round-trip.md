# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: B7668EB3-C21C-469A-8882-C02820193AF4
- Date: 2026-10-31T12:26:27Z
- End: 2026-10-31T12:26:30Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): 6154A196-96FC-4C55-822A-0CF00B760458

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: Own URL scheme round trip

- ID: manual.url
- Category: Communication
- Result: **PASS**
- Start: 2026-10-31T12:26:27Z
- End: 2026-10-31T12:26:30Z

### Objective

Verify a nonce-bearing URL is delivered back to this app.

### Method

Open sandboxresearchlab://probe with a random nonce; record open completion and validate the incoming nonce.

### Expected Behavior

The operating system opens the registered scheme and this process receives the exact pending nonce. A handler callback alone does not authenticate a sender.

### Observed Behavior

- OPEN: **PASS** — open completion returned true
- RECEIVE: **PASS** — Exact pending nonce received by onOpenURL

### Evidence

#### OPEN · 82775EEF-3BAC-4A66-9678-7098D64171B2

- Timestamp: 2026-10-31T12:26:30Z
- Resource: sandboxresearchlab://probe
- Expected: System accepts own registered URL
- Actual: open completion returned true
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### RECEIVE · E3F22A8B-1CB7-4E51-ABD4-BB7D5C849219

- Timestamp: 2026-10-31T12:26:30Z
- Resource: Own scheme callback (payload omitted)
- Expected: Incoming nonce matches pending probe
- Actual: Exact pending nonce received by onOpenURL
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
