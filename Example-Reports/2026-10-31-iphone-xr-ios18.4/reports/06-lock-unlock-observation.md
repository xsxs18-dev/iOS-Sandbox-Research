# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: 22423A19-F0A9-4075-B64B-34BDE8C17479
- Date: 2026-10-31T12:28:39Z
- End: 2026-10-31T12:30:07Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): 6154A196-96FC-4C55-822A-0CF00B760458

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: Lock-state observation

- ID: manual.protection
- Category: File Protection
- Result: **PASS**
- Start: 2026-10-31T12:28:39Z
- End: 2026-10-31T12:30:07Z

### Objective

Observe protection reads around notifications delivered to this foreground app.

### Method

Arm files of all four classes; retain one Class B handle. Sample reads when notifications arrive and when explicitly requested. Stop removes the files.

### Expected Behavior

Each sample records its real availability and read result. iOS may suspend the process; missing locked-state samples cannot establish enforcement.

### Observed Behavior

- ARM\_complete: **PASS** — Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686583<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- ARM\_unlessOpen: **PASS** — Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686585<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- ARM\_untilFirstAuthentication: **PASS** — Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686587<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- ARM\_none: **PASS** — Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686588<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- NOTIFICATION: **PASS** — protectedDataWillBecomeUnavailable delivered
- READ\_complete: **PASS** — Closed-file read matched; selected class NSFileProtectionComplete
- READ\_unlessOpen: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- READ\_untilFirstAuthentication: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- READ\_none: **PASS** — Closed-file read matched; selected class NSFileProtectionNone
- READ\_HELD\_UNLESS\_OPEN: **PASS** — Held Class B handle read matched
- NOTIFICATION: **PASS** — protectedDataDidBecomeAvailable delivered
- READ\_complete: **PASS** — Closed-file read matched; selected class NSFileProtectionComplete
- READ\_unlessOpen: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- READ\_untilFirstAuthentication: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- READ\_none: **PASS** — Closed-file read matched; selected class NSFileProtectionNone
- READ\_HELD\_UNLESS\_OPEN: **PASS** — Held Class B handle read matched
- NOTIFICATION: **PASS** — didBecomeActive delivered
- READ\_complete: **PASS** — Closed-file read matched; selected class NSFileProtectionComplete
- READ\_unlessOpen: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- READ\_untilFirstAuthentication: **PASS** — Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- READ\_none: **PASS** — Closed-file read matched; selected class NSFileProtectionNone
- READ\_HELD\_UNLESS\_OPEN: **PASS** — Held Class B handle read matched
- CLOSE\_HANDLE: **PASS** — Handle closed
- CLEANUP: **PASS** — Armed files removed

### Evidence

#### ARM\_complete · B8DD9C93-9642-436D-92AF-4502D830EF53

- Timestamp: 2026-10-31T12:28:39Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/complete
- Expected: Create file with NSFileProtectionComplete
- Actual: Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686583<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ARM\_unlessOpen · BEB17DA1-970A-4A0B-A1FA-571FE1D49D17

- Timestamp: 2026-10-31T12:28:39Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Create file with NSFileProtectionCompleteUnlessOpen
- Actual: Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686585<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ARM\_untilFirstAuthentication · 64EC9920-69B7-474A-BCAE-EA33AA411CE3

- Timestamp: 2026-10-31T12:28:39Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/untilFirstAuthentication
- Expected: Create file with NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686587<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ARM\_none · 65C59C11-EF8D-4173-AC0E-5CD9D9C731FA

- Timestamp: 2026-10-31T12:28:39Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/none
- Expected: Create file with NSFileProtectionNone
- Actual: Created; NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:28:39 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:28:39 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=31<br>NSFileSystemFileNumber=34686588<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### NOTIFICATION · F494B078-9B3E-45FA-9275-C12C13C5A08D

- Timestamp: 2026-10-31T12:29:00Z
- Resource: UIApplication
- Expected: Record only delivered events
- Actual: protectedDataWillBecomeUnavailable delivered
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_complete · A73B0767-B76F-40D3-8933-DC26DF76594E

- Timestamp: 2026-10-31T12:29:00Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/complete
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_unlessOpen · 3983F8E2-23B9-4215-849E-C35AB9395E88

- Timestamp: 2026-10-31T12:29:00Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_untilFirstAuthentication · B689A0CF-3A35-4066-8ED7-A752606BF9CA

- Timestamp: 2026-10-31T12:29:00Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/untilFirstAuthentication
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_none · 3925A5F0-31EA-4D4A-82D1-CB16D5CAC54B

- Timestamp: 2026-10-31T12:29:00Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/none
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_HELD\_UNLESS\_OPEN · 455D13E2-B869-47E9-8BDD-5043F03DE4BC

- Timestamp: 2026-10-31T12:29:00Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Read using the handle retained before locking
- Actual: Held Class B handle read matched
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### NOTIFICATION · 350D9E3D-38D1-4244-87B8-57DA7144353A

- Timestamp: 2026-10-31T12:29:15Z
- Resource: UIApplication
- Expected: Record only delivered events
- Actual: protectedDataDidBecomeAvailable delivered
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_complete · 391B14E1-1EA5-44FA-A491-A56AF2176F7E

- Timestamp: 2026-10-31T12:29:15Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/complete
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_unlessOpen · 0992BA5A-6DC4-4CD1-AB60-04D8DC5225B7

- Timestamp: 2026-10-31T12:29:15Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_untilFirstAuthentication · C679A997-DFEA-44EA-B6AE-B39555E4494B

- Timestamp: 2026-10-31T12:29:15Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/untilFirstAuthentication
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_none · 80CCF8E8-AE97-458E-B373-06D482A0E57E

- Timestamp: 2026-10-31T12:29:15Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/none
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_HELD\_UNLESS\_OPEN · 8E598E14-0766-4EC4-8747-E9B5BBB92FE2

- Timestamp: 2026-10-31T12:29:15Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Read using the handle retained before locking
- Actual: Held Class B handle read matched
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### NOTIFICATION · 3656B56D-47E6-4EB6-A60C-8A96F5D4C2FE

- Timestamp: 2026-10-31T12:29:16Z
- Resource: UIApplication
- Expected: Record only delivered events
- Actual: didBecomeActive delivered
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_complete · 96B669F0-8A8A-4ABC-BFDB-D32BB9C0613A

- Timestamp: 2026-10-31T12:29:16Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/complete
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_unlessOpen · CE5E4CFF-E1F8-4FDD-96AA-BAA55801186C

- Timestamp: 2026-10-31T12:29:16Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_untilFirstAuthentication · 67080437-9E5A-4D34-8ADE-2CFA58DA28A6

- Timestamp: 2026-10-31T12:29:16Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/untilFirstAuthentication
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_none · 1DB9F9C1-00FA-4754-BBAA-B8F07DEAE138

- Timestamp: 2026-10-31T12:29:16Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/none
- Expected: Record actual read outcome; notification timing alone does not prove lock enforcement
- Actual: Closed-file read matched; selected class NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ\_HELD\_UNLESS\_OPEN · CC3D956E-8932-45E7-9BBF-E574F6C66CCD

- Timestamp: 2026-10-31T12:29:16Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF/unlessOpen
- Expected: Read using the handle retained before locking
- Actual: Held Class B handle read matched
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLOSE\_HANDLE · AC549BB4-814E-4F21-B59C-FCC778BDEB7D

- Timestamp: 2026-10-31T12:30:07Z
- Resource: Class B handle
- Expected: Close retained file descriptor
- Actual: Handle closed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 5C7CEB96-26B2-4833-B09F-7FE2C4CABE72

- Timestamp: 2026-10-31T12:30:07Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/ManualProtection-25C080FC-B6B7-4852-A19C-CBB518612DCF
- Expected: Remove armed test files
- Actual: Armed files removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Lock and unlock your phone, then return here and stop to save all delivered samples. No background execution entitlement is requested.

## Limitations

This report is generated from local evidence, not a security attestation. Configuration is not proof of signed entitlement grants. Lock-state, relaunch, signing and external link behavior require the documented manual checks. Imported sessions and researcher notes are not independently authenticated.
