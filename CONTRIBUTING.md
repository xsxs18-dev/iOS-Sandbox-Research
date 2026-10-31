# Contributing

Contributions must preserve the project's defensive scope. Use public APIs, owned data and narrowly scoped resources. Do not add private APIs, restricted entitlements, exploit code, automatic vulnerability labels or broad cleanup/query operations.

## Development

- Build with the committed Xcode project or `xtool dev build --configuration release --ipa`.
- Run `swift test --package-path Core` on Linux or macOS.
- Keep reusable models, comparisons, formatting and storage independent of UIKit in `Core`.
- Keep blocking security/file work outside the main actor. Do not detach unsynchronized mutable UI state.
- Add an experiment definition with a stable semantic ID, objective, method, expected behavior, automatic/manual flag, and evidence for every relevant operation and cleanup failure.
- Verify bytes/attributes or callback values where possible. Do not translate “no exception” into a broader security claim.
- Prerequisite failures must leave dependent operations untested. Preserve original errors and avoid force unwraps.
- Use unique app-owned test directories and exact Keychain service/account queries. Never recursively clean a caller-supplied or imported path.
- If files are added under the app target, run `python3 Scripts/generate_xcode_project.py` and commit the updated Xcode project. Python's standard library is sufficient.

## Review and tests

Test logic with explicitly synthetic fixtures and temporary host directories. Never label host tests as physical sandbox validation. Include regression tests for result evaluation, schema or comparison changes. Do not commit actual private evidence, certificates, credentials or provisioning profiles. The ignored `Research/Private/` directory is a convenience, not a security boundary.

Before proposing a change, review all touched source and documentation for unfinished implementations, unsafe APIs, concurrency and error handling. Describe the concrete behavior and actual validation performed, distinguishing compile-time, host-runtime and device-runtime checks. Preserve schema compatibility or introduce an explicit schema migration/version decision.
