# Running the lab on a device from Linux

This is how the 2026-10-31 iPhone XR run was recorded without Xcode and without root. Use it only with your own, paired device.

## Requirements

- [pymobiledevice3](https://github.com/doronz88/pymobiledevice3) 11.x. On Linux it opens a no-root *userspace* RSD tunnel for iOS 17+ by itself.
- A paired, trusted iPhone with **Developer Mode** on.
- The lab installed with a **development** signature (`get-task-allow = true`). That is what allows container access and accessibility activation. App Store or distribution-signed builds won't work.

## 1. Mount the developer disk image

```sh
pymobiledevice3 mounter auto-mount     # personalized image, needs network access to Apple's TSS
```

## 2. Drive the app

`Scripts/usb_lab.py` launches or terminates the app, takes screenshots, and activates buttons through the accessibility inspector:

```sh
python3 Scripts/usb_lab.py launch wait=3 "pressx=Run Safe Research Suite, Button" wait=5 shot=suite.png
python3 Scripts/usb_lab.py kill wait=2 launch       # a new process launch for the persistence check
python3 Scripts/usb_lab.py "pressx=Manual Lab, Button, Tab" items
```

`items` prints the captions to use with `press=` (substring) or `pressx=` (exact match).

- `launch` kills an existing instance first, so each `launch` counts as a new launch ID for the persistence experiment.
- pymobiledevice3's `AccessibilityAudit.perform_press` in 11.17 nests the element bytes *next to* `PlatformElementValue_v1` instead of inside it, and the device ignores that. The script sends the element in the format the daemon itself emits.
- **Limits:** system UI that runs in another process can be listed but not activated. That includes the share sheet and SwiftUI picker menus such as *Compare → Choose session*. Locking and unlocking also needs a person. The lock observation can still be timed from the host:

```sh
pymobiledevice3 notification observe com.apple.springboard.lockstate com.apple.springboard.lockcomplete
```

## 3. Read the sessions

The lab stores each session at `Library/Application Support/SandboxResearchLab/Sessions/<UUID>.json` in its own data container. For a development-signed build, `house_arrest` gives the host read access:

```sh
echo "ls '/Library/Application Support/SandboxResearchLab/Sessions'" | \
  pymobiledevice3 apps afc com.xsxs18.sandboxresearchlab
pymobiledevice3 apps pull com.xsxs18.sandboxresearchlab \
  "/Library/Application Support/SandboxResearchLab/Sessions/<UUID>.json" raw/<UUID>.json
```

To see what the installed build was actually signed with, use `pymobiledevice3 apps query <bundle id>` and look at its `Entitlements`.

## 4. Render reports and comparisons

`Scripts/reportgen` uses the app's own `ResearchCore`. It validates a session the same way the app's JSON import does, then writes the Markdown report the app would export:

```sh
swift run --package-path Scripts/reportgen reportgen report raw/<UUID>.json report.md
swift run --package-path Scripts/reportgen reportgen compare a.json b.json
```

Keep the raw files outside Git (for example in `Research/Private/`) and publish only reviewed copies. See [Research/README.md](../Research/README.md).

Host access to a development-signed app's container is a debugging feature of a trusted, paired computer. It is not a sandbox bypass and doesn't apply to other apps.
