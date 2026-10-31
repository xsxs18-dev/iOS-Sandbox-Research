# Responsible disclosure

Unexpected measurements are research leads. Do not name a vulnerability, assign severity, promise an exploit or claim a sandbox bypass from a single result. A normal permission denial is not a finding.

Preserve the original exported session, hash it if you need an evidence chain, and record exact reproduction steps, physical-device details, app build and signing setup. Repeat with minimal owned-data inputs. Distinguish defects in the lab from platform behavior. Check documented semantics and eliminate protection timing, suspension, reinstall/restore, storage pressure and provisioning differences.

If validated evidence plausibly indicates an Apple security issue, report privately at [security.apple.com](https://security.apple.com/). Include a minimal reproducer, versions affected, expected versus actual behavior, and only the redacted evidence needed to investigate. Coordinate disclosure; do not publish sensitive data or an unvalidated exploit narrative. Follow Apple's current reporting guidance rather than assuming eligibility, bounty amounts or response timelines.

For a problem in this repository, follow [SECURITY.md](../SECURITY.md). Never send signing secrets, other people's private content or unrelated credentials. The software does not submit reports or contact anyone automatically.
