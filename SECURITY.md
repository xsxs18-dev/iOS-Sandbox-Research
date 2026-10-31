# Security policy

SandboxResearchLab is limited to app-owned data and expressly authorized public capabilities. It does not implement exploits, sandbox escapes, private entitlement inspection, cross-app private-data reads, broad Keychain queries, private service communication, or security-control bypasses.

## Unexpected results

A byte mismatch, a contradictory verified outcome, or another implemented expectation violation is `NEEDS_REVIEW`. A permission error is `DENIED`, not automatically a vulnerability. Operational failures are `ERROR`. The comparison screen also flags transitions from denied to allowed for human review; a change in entitlement, lock state, device or provisioning may explain them.

1. Export the original session and retain an unchanged copy. Record the app commit, build, iOS version, device model, signing configuration and reproduction steps.
2. Reproduce on a physical, unmodified device with the same controlled inputs. Repeat after a clean process launch while preserving the baseline where the procedure requires it.
3. Exclude disk-full, stale data, backup restore, cache purging, debugger/simulator behavior, device protection timing, provisioning changes and measurement bugs.
4. Reduce the case to public API operations on data you own. Stop if further work would require unauthorized access.
5. If evidence still indicates an Apple security issue, report privately through [Apple Security Research](https://security.apple.com/). Share a minimal reproducer, exact expected/observed behavior and relevant redacted evidence. Coordinate publication with Apple.
6. Do not publish private data, signing credentials, provisioning profiles, exploit claims or unvalidated findings in this repository.

## Reporting a defect in this tool

For ordinary app bugs, use the repository's issue tracker with redacted error details. Issues are public, so omit sensitive evidence. For a security-sensitive defect, use GitHub's private vulnerability reporting when enabled; otherwise contact the repository owner privately before sending sensitive material. No response time or bounty is promised.

Current release sources are the supported baseline. Researchers should review any code modifications that expand resource scope. Filesystem paths in imported sessions are inert text: import, reporting and comparison never execute or probe those paths.
