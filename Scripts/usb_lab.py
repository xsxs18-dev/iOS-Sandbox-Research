"""Drive SandboxResearchLab on a USB-connected, paired iPhone from Linux (iOS 17+, no root).

Requires pymobiledevice3 (11.x), Developer Mode, a mounted developer disk image
(`pymobiledevice3 mounter auto-mount`) and a development-signed lab build (get-task-allow),
because accessibility activation only works on such processes. Every invocation opens its own
userspace RSD tunnel. See Documentation/Device-Automation.md.

Usage: python3 Scripts/usb_lab.py CMD [CMD ...]
  launch            launch the lab (kills an existing instance, so this is a new process launch)
  kill              terminate the lab
  shot=PATH         save a PNG screenshot
  items             print the accessibility captions of the focusable elements on screen
  focus=TEXT        move the inspector focus to the first caption containing TEXT (scrolls to it)
  press=TEXT        activate the first element whose caption contains TEXT
  pressx=TEXT       activate the first element whose caption equals TEXT
  wait=SECONDS      sleep

Elements of out-of-process system UI (share sheet, context menus) are listed but cannot be
activated; those steps still need a person at the device.
"""
import asyncio
import sys

from pymobiledevice3.remote.rsd_tunnel import PreferredRsdTunnel
from pymobiledevice3.services.accessibilityaudit import AccessibilityAudit
from pymobiledevice3.services.dvt.instruments.dvt_provider import DvtProvider
from pymobiledevice3.services.dvt.instruments.process_control import ProcessControl
from pymobiledevice3.services.dvt.instruments.screenshot import Screenshot

BID = "com.xsxs18.sandboxresearchlab"


async def elements(rsd):
    found = []
    async with AccessibilityAudit(rsd) as ax:
        try:
            async for el in ax.iter_elements():
                found.append(el)
        except TimeoutError:
            pass
    return found


ACTIVATE = {
    "ObjectType": "AXAuditElementAttribute_v1",
    "Value": {"ObjectType": "passthrough", "Value": {
        "AttributeNameValue_v1": {"ObjectType": "passthrough", "Value": "AXAction-2010"},
        "DisplayAsTree_v1": {"ObjectType": "passthrough", "Value": 0},
        "HumanReadableNameValue_v1": {"ObjectType": "passthrough", "Value": "Activate"},
        "IsInternal_v1": {"ObjectType": "passthrough", "Value": 0},
        "PerformsActionValue_v1": {"ObjectType": "passthrough", "Value": 1},
        "SettableValue_v1": {"ObjectType": "passthrough", "Value": 0},
        "ValueTypeValue_v1": {"ObjectType": "passthrough", "Value": 1},
    }},
}


async def activate(ax, identifier):
    # pymobiledevice3's perform_press nests the element bytes beside, not inside,
    # PlatformElementValue_v1; this mirrors the format the daemon emits in focus events.
    element = {"ObjectType": "AXAuditElement_v1", "Value": {"ObjectType": "passthrough", "Value": {
        "PlatformElementValue_v1": {"ObjectType": "passthrough", "Value": identifier}}}}
    await ax._invoke("deviceElement:performAction:withValue:", element, ACTIVATE, 0, expects_reply=False)


async def press(rsd, text, exact):
    async with AccessibilityAudit(rsd) as ax:
        seen = []
        try:
            async for el in ax.iter_elements():
                caption = el.caption or ""
                seen.append(caption)
                if (caption == text) if exact else (text.lower() in caption.lower()):
                    await activate(ax, el.element.identifier)
                    await asyncio.sleep(1.0)
                    print(f"pressed: {caption!r}")
                    return
        except TimeoutError:
            pass
    raise SystemExit(f"not found: {text!r}; on screen: {seen}")


async def main(cmds):
    async with PreferredRsdTunnel() as rsd:
        for cmd in cmds:
            op, _, arg = cmd.partition("=")
            if op == "launch":
                async with DvtProvider(rsd) as dvt, ProcessControl(dvt) as pc:
                    print("pid", await pc.launch(bundle_id=BID, kill_existing=True))
            elif op == "kill":
                async with DvtProvider(rsd) as dvt, ProcessControl(dvt) as pc:
                    pid = await pc.process_identifier_for_bundle_identifier(BID)
                    if pid:
                        await pc.kill(pid)
                    print("killed", pid)
            elif op == "shot":
                async with DvtProvider(rsd) as dvt, Screenshot(dvt) as s:
                    data = await s.get_screenshot()
                with open(arg, "wb") as f:
                    f.write(data)
                print("screenshot", arg, len(data))
            elif op == "items":
                for el in await elements(rsd):
                    print(repr(el.caption))
            elif op == "focus":
                async with AccessibilityAudit(rsd) as ax:
                    try:
                        async for el in ax.iter_elements():
                            if arg.lower() in (el.caption or "").lower():
                                print("focused", repr(el.caption)); break
                    except TimeoutError:
                        print("focus target not found")
                await asyncio.sleep(0.8)
            elif op in ("press", "pressx"):
                await press(rsd, arg, op == "pressx")
            elif op == "wait":
                await asyncio.sleep(float(arg))
            else:
                raise SystemExit(f"unknown command {cmd}")


if __name__ == "__main__":
    asyncio.run(main(sys.argv[1:]))
