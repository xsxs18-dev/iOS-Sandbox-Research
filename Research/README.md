# Research notes

| Notes | Device / iOS | Data |
| --- | --- | --- |
| [2026-10-31 · iPhone XR · iOS 18.4](2026-10-31-iphone-xr-ios18.4.md) | iPhone11,8 · 18.4 (22E240) | [Example-Reports/2026-10-31-iphone-xr-ios18.4](../Example-Reports/2026-10-31-iphone-xr-ios18.4/README.md) |

## Handling real artifacts

Generate sessions on a device you own, export or pull the JSON (see [Device-Automation.md](../Documentation/Device-Automation.md)), and preserve the raw evidence before annotating a working copy.

Use the ignored `Private/` child for unredacted originals. Git ignore is not encryption, so use appropriate local storage and access controls. Review exports for container identifiers, signing metadata and researcher notes before committing or sharing them. Do not commit credentials, provisioning profiles or personal data.

Record the app commit, device/OS/build, signing setup (the *signed* entitlements, not only the repository's entitlements file), exact procedure, manual lock timing, repeatability and interpretation. Separate observations from hypotheses. Unexpected behavior remains `NEEDS_REVIEW` until independently reproduced and validated.
