# Entitlements and provenance

The configuration screen uses four explicit labels:

| Label | Interpretation |
| --- | --- |
| Observed | Returned directly by a public API for this running app |
| Configured | Declared in Bundle/build metadata; not proof of authorization |
| Unavailable | Not provided by the supported implementation or current setup |
| Requires manual verification | Needs signature/provisioning inspection or external interaction |

Bundle identifier and resolved App Group container are observations. Build team/application identifier fields are configured Xcode substitutions. xtool may leave them unresolved; the app reports “Not supplied by this build.” They are never represented as authoritative signed grants. The Keychain experiment records the returned access-group attribute of **its own new item**, if the API supplies it. This is not enumeration of all entitled groups or other items.

There is no supported general-purpose signed-entitlements dump used here. The app does not call private `SecTask` APIs or scrape `embedded.mobileprovision`. Default entitlements are empty, and no restricted entitlement is requested. Ordinary private Keychain storage does not require enabling Keychain Sharing.

On a Mac, inspect your own built artifact with `codesign -d --entitlements :- /path/to/SandboxResearchLab.app` and compare with Xcode Signing & Capabilities and the provisioning profile. Do not commit profiles or certificates. On Linux, inspect the artifact with your trusted signing tools and retain any manual conclusion as researcher notes. Changing the bundle ID, team, group memberships or signing method changes the experiment context.

See [Apple: adding capabilities](https://developer.apple.com/documentation/xcode/adding-capabilities-to-your-app) and [Keychain access groups](https://developer.apple.com/documentation/security/sharing-access-to-keychain-items-among-a-collection-of-apps).
