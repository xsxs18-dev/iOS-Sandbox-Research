# Public inter-app communication

## Own URL scheme

The app registers `sandboxresearchlab` in `CFBundleURLTypes`. Manual Lab opens `sandboxresearchlab://probe?nonce=<random>` through `UIApplication.open`. It separately records the system's open completion and an `onOpenURL` callback matching the pending random nonce. Unrelated URLs are ignored and their payloads are not retained. A timeout is `NOT_TESTED`, since suspension or routing can prevent an observation. Custom schemes can collide and do not authenticate a caller.

## Documents and share extensions

**Share lab document** writes a non-sensitive text file and offers it with `UIActivityViewController`. The researcher selects an app, extension or system action. Cancellation is `NOT_TESTED`; errors preserve their exact domain/code. A completed activity does not prove what the destination stored. JSON and Markdown exports use the same public share-sheet mechanism. History imports only an explicitly selected JSON file using the system file importer and a scoped URL; imported paths are never followed.

No receiving share extension is bundled. This keeps the baseline install independent of additional extension identities/provisioning. Invoking a user-selected installed share extension and observing its activity callback is implemented. Receiving data in another owned process would require a separately provisioned component and is not claimed by this app.

## Optional universal links

This app already handles `NSUserActivityTypeBrowsingWeb` and records delivery for an exact hostname listed as `applinks:<host>` in `LabAssociatedDomains`. It stores only the hostname, never the full URL path/query/fragment. To enable:

1. Choose an HTTPS domain you own/control.
2. Enable **Associated Domains** in the app's signing capabilities and add `applinks:<your-host>` to `com.apple.developer.associated-domains` in the entitlements file.
3. Add the same string to the `LabAssociatedDomains` array in `Resources/Info.plist`. This array is a lab declaration, not the entitlement itself.
4. Host the `apple-app-site-association` document on your domain, containing the real application identifier and the paths you intend to associate.
5. Sign with a matching profile and install. Tap the matching link from another app while no lab session is active. If iOS delivers it, a manual session is recorded automatically. If it opens in a browser, manually record that observation; the lab cannot observe external failures it never receives.

The baseline deliberately assumes no owned domain. It cannot validate AASA hosting, Apple CDN propagation, user routing preferences or signed association without that external setup. Wildcard domains and alternate AASA routing are not inferred by the lab's exact-host recording filter. Follow [Apple's associated-domains documentation](https://developer.apple.com/documentation/xcode/supporting-associated-domains) for the server format and deployment requirements.
