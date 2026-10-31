# App containers and file access

The app discovers `NSHomeDirectory()`, Foundation's Documents, Library, Caches and Application Support URLs, and `FileManager.temporaryDirectory`. Paths are displayed and exported because they are direct research evidence. Container UUIDs are unstable across installations; never hardcode them.

Each location gets a new `SandboxResearchLab-<UUID>` child directory. The engine creates a known file, reads and compares bytes, modifies and reads back, enumerates only that child, retrieves file attributes, deletes the file, verifies absence by directory enumeration, then removes the child. It does not enumerate unrelated Documents files or remove pre-existing content. Cleanup is a separately recorded operation. A preparation failure produces `NOT_TESTED` records for the dependent operations.

Read, write, create, delete, enumerate and attributes appear in a horizontally scrollable matrix. Open experiment evidence for directory creation and cleanup. No negative cross-container probe is included: the matrix documents this app's allowed-access baseline.

## Persistence procedure

Run once to save an Application Support marker and a separate receipt containing its expected bytes, original launch ID and creation date. A repeat in the same process is `NOT_TESTED` for relaunch persistence. Terminate from the app switcher, relaunch without reinstalling, and run again. The random per-process launch ID distinguishes those cases.

The next launch verifies the marker before re-arming it. A surviving receipt with missing/changed marker needs review; failed reads retain their original error and the baseline is preserved. First installation, or loss of both files, cannot establish a previous baseline. A crash between writing the marker and receipt can produce a mismatch; investigate lifecycle before interpreting it as a security issue. A mismatched baseline is not automatically reset. Preserve the evidence first; reinstalling the app resets its container but also deletes local history.

Caches and tmp are purgeable. The app does not claim those locations persist. Sessions and the marker are stored in `Library/Application Support/SandboxResearchLab`. A process kill during an experiment may leave unique test children; their names identify them, but the app deliberately does not sweep arbitrary files. See [Apple's file-system guide](https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html).
