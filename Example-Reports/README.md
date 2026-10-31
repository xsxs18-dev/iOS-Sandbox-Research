# Example reports

Only real device output belongs here. Each run sits in its own folder with the procedure, redaction notes and screenshots.

| Run | Device | iOS | Contents |
| --- | --- | --- | --- |
| [2026-10-31-iphone-xr-ios18.4](2026-10-31-iphone-xr-ios18.4/README.md) | iPhone XR (`iPhone11,8`) | 18.4 (22E240) | 3 suite runs, URL round trip, share handoff, lock/unlock observation, 5 screenshots |

The JSON files are the app's own session format and can be imported in **History → Import session JSON**. The Markdown reports are rendered from that JSON by the app's `MarkdownReport` (`Scripts/reportgen`), not written by hand.

Unit tests contain explicitly synthetic fixtures for testing software behavior. They aren't iOS security results and are never shipped as preloaded app evidence. Add new reports and screenshots only with their true source, device context and appropriate redaction. Any future synthetic illustration must be clearly labeled synthetic throughout.
