# iOS sandbox overview

iOS isolates applications using code signing, entitlement-based capabilities, container boundaries and platform services. This lab uses the identity and permissions of its own signed process. It makes no claim that a collection of successful allowed operations proves the whole sandbox is secure.

The safe suite measures positive baselines: its own directories, its own newly created Keychain item, and optionally an authorized group container. It intentionally does not guess another app's container, inspect system-private directories, enumerate other apps' credentials, or call private services. A denial is a valid observation and may be expected enforcement or a missing prerequisite.

The same source can behave differently with a simulator, changed provisioning, different protection state or a changed OS. Reports retain context rather than assuming a cause. Build configuration is not proof that the running binary was granted an entitlement. Use the signed artifact and the observed public API outcome together.

Read [Apple's app security overview](https://support.apple.com/guide/security/app-security-overview-sec35dd877d0/web) and [Apple Platform Security](https://support.apple.com/guide/security/welcome/web). The app's individual experiment methods document exactly which narrower property was measured.
