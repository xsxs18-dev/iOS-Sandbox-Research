# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: 1EC2D98D-3F68-47A8-92FC-7286D23B5104
- Date: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:49Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): 57A4E4B1-F5EA-4DB7-B893-3F720A4F7679

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: App Home

- ID: files.home
- Category: Container
- Result: **DENIED**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in App Home.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **DENIED** — You don’t have permission to save the file “SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55” in the folder “APP-DATA-CONTAINER”.
- CREATE: **NOT_TESTED** — Prerequisite directory creation failed
- READ: **NOT_TESTED** — Prerequisite directory creation failed
- WRITE: **NOT_TESTED** — Prerequisite directory creation failed
- ENUMERATE: **NOT_TESTED** — Prerequisite directory creation failed
- ATTRIBUTES: **NOT_TESTED** — Prerequisite directory creation failed
- DELETE: **NOT_TESTED** — Prerequisite directory creation failed

### Evidence

#### DIRECTORY\_CREATE · 1C3D1A2D-F6CC-45C6-9A9D-3BA823C29AEF

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55
- Expected: Create isolated test directory
- Actual: You don’t have permission to save the file “SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55” in the folder “APP-DATA-CONTAINER”.
- State: DENIED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- Error domain: NSCocoaErrorDomain
- Error code: 513
- Error description: You don’t have permission to save the file “SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55” in the folder “APP-DATA-CONTAINER”.
- Underlying error: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"

#### CREATE · B4E5E260-858E-43A2-8474-933524632429

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 314661B3-AE15-42E8-A509-FE9EA790A820

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 025502A3-EFB7-492B-B7D8-465EA029B870

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 4F1F05F7-A502-4CC2-938E-BD297EAD4B36

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 9B7DD862-7C42-447E-8C9F-8C1A8E2BB9DA

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · C4A0FFA1-F240-472A-AA9A-79527AED0561

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-3C96DE14-0C16-473F-B709-918C2F92AC55/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

Access was refused. This may be normal enforcement, a protection state, or signing configuration. A denial is not a vulnerability.

### Conclusion

Recorded state: DENIED. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Experiment: Documents

- ID: files.documents
- Category: Container
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in Documents.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **PASS** — Directory created
- CREATE: **PASS** — Created 23 bytes
- READ: **PASS** — Read and verified 23 bytes
- WRITE: **PASS** — Modified and verified 23 bytes
- ENUMERATE: **PASS** — Entries: probe.txt
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674304<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 7C2ED534-50D9-4E06-829E-46C49154B98D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 1297AEE1-D6F0-4C60-9404-9260373686F1

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · C99C670C-1B6A-4444-B087-090F68CE53AF

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · FAB513E4-325A-464A-9C58-84A830C0F94A

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 438EEB28-88D7-4785-96DC-E9FFC5325FBA

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · E1E01FF0-EECB-4167-8241-F56FF50C336E

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674304<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 89D3FDCC-2AF1-4903-9F96-B19BA7B6EBE1

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · C750F7FD-7469-48F9-92C4-7D9FBAEC53E7

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-4915C64D-E6BF-4417-8AAA-17956E6CD79E
- Expected: Remove this run's test directory
- Actual: Test directory removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.

## Experiment: Library

- ID: files.library
- Category: Container
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in Library.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **PASS** — Directory created
- CREATE: **PASS** — Created 23 bytes
- READ: **PASS** — Read and verified 23 bytes
- WRITE: **PASS** — Modified and verified 23 bytes
- ENUMERATE: **PASS** — Entries: probe.txt
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674308<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · D3FFD6FD-DDB6-4511-9012-17384742D7C8

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 4F692A3F-5A1D-4C3B-96DE-F432D03B361B

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 09AE4D4A-D7AE-4CF5-BF35-7564B0F17062

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 088CFAD1-98DD-4B64-92D2-BE4DCAB9A64D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 4340AE1C-A064-4849-9189-C7E1BBD0E500

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 5E7E3216-C142-4E87-ACFC-63665A839B75

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674308<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · CDB8F82C-778D-4EEF-BF7C-223F021E5CFD

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 56A3FBD1-8C31-41E2-865B-CFEC8D247829

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-FB45DF08-5205-4B77-A0DE-81D898633ED7
- Expected: Remove this run's test directory
- Actual: Test directory removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.

## Experiment: Library/Caches

- ID: files.caches
- Category: Container
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in Library/Caches.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **PASS** — Directory created
- CREATE: **PASS** — Created 23 bytes
- READ: **PASS** — Read and verified 23 bytes
- WRITE: **PASS** — Modified and verified 23 bytes
- ENUMERATE: **PASS** — Entries: probe.txt
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674312<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 02CD7380-D823-408B-AAB3-1E4817996F43

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 7183E37C-9A86-4F90-A50E-88F1B5838716

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · E25ADC99-2554-4295-8132-0C462C17CD12

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · EED6B284-DA86-4382-B840-420A7E764231

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · BD9410E9-24D9-4259-AAE6-34E54CDC3F6C

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 58970E7A-8FED-4A12-927B-697EBBBE7D4D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674312<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 516EEF95-B55F-4127-880E-F943D9902A06

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · DA26DBE1-485D-4D70-9798-AB6AC0C368D2

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-1574697A-2371-4C1A-88DE-20ADFCB0E0C3
- Expected: Remove this run's test directory
- Actual: Test directory removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.

## Experiment: Application Support

- ID: files.support
- Category: Container
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in Application Support.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **PASS** — Directory created
- CREATE: **PASS** — Created 23 bytes
- READ: **PASS** — Read and verified 23 bytes
- WRITE: **PASS** — Modified and verified 23 bytes
- ENUMERATE: **PASS** — Entries: probe.txt
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674316<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 8440ECD8-7383-49B2-823D-27E65EFE2EBD

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · E0CD6F8C-2F86-4D77-87D4-812FAA2E659D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 45E64921-4A29-4B25-B78E-09F554BB6FA3

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 57302B9D-32C8-42D8-8845-2B1046AB6463

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 7537F1FC-3BF1-47FA-AE0B-A2A409D16AE1

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 9B3EDF90-C9E3-4B7F-AA67-09A779E89D5E

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674316<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 71F428D8-6191-467C-B214-EE365255400F

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 31CFAD4F-EBDB-4317-BC31-673CD6FCA9F6

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-C292EB03-A126-40E2-8D8D-4177AD432E55
- Expected: Remove this run's test directory
- Actual: Test directory removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.

## Experiment: tmp

- ID: files.temporary
- Category: Container
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure ordinary file operations in tmp.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **PASS** — Directory created
- CREATE: **PASS** — Created 23 bytes
- READ: **PASS** — Read and verified 23 bytes
- WRITE: **PASS** — Modified and verified 23 bytes
- ENUMERATE: **PASS** — Entries: probe.txt
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674320<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · E77E24DC-4195-470D-ABA1-E0EF4D85A6BB

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 80F27CE8-72C5-4800-9FCD-6BCF93EA4252

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · B95ED07E-0A94-40CF-A5D4-154292306E64

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 4E20B37B-49C3-4F01-92E0-B77DD3364701

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · D665F4C6-1CBF-481C-B094-22BFB7266C8A

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · A793D7A7-93ED-4F33-9A32-6E3DC1881135

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:48 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:48 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34674320<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 10A63C5F-E826-4104-A2F6-A815126DEAA1

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 18AED0E7-ABA6-4501-975A-960DE0C01D32

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-94F8B9DA-2270-4F14-91F5-56F5248DDF8A
- Expected: Remove this run's test directory
- Actual: Test directory removed
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Only the unique lab directory was enumerated. This is an allowed-access baseline, not a cross-container or sandbox-escape test.

## Experiment: Persistence between launches

- ID: persistence.launch
- Category: Persistence
- Result: **NOT_TESTED**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Check that an app-owned Application Support file survives a process relaunch.

### Method

Keep an independent receipt and marker. Compare the marker bytes on a later launch, then re-arm the baseline.

### Expected Behavior

A marker remains readable and unchanged on a later launch without reinstall or data removal.

### Observed Behavior

- PERSISTENCE: **NOT_TESTED** — Baseline exists from this launch. Terminate, relaunch, then run this experiment again.

### Evidence

#### PERSISTENCE · 82D874AD-9752-4824-9589-92E01395229D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Persistence/launch-marker.txt
- Expected: Verify after a different process launch
- Actual: Baseline exists from this launch. Terminate, relaunch, then run this experiment again.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

Evidence is incomplete or requires manual interaction/a later launch. No success is claimed for the untested operation.

### Conclusion

Recorded state: NOT_TESTED. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Experiment: Entitlements & configuration

- ID: configuration.inspect
- Category: Entitlements
- Result: **NOT_TESTED**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Separate observed values from build configuration and unavailable signing information.

### Method

Read this app's Bundle metadata and resolve the explicitly configured App Group using FileManager.

### Expected Behavior

Only directly observed configuration is reported as observed; signed grants are not inferred from Info.plist.

### Observed Behavior

- Bundle identifier: **PASS** — com.xsxs18.sandboxresearchlab
- Build application identifier: **PASS** — Not supplied by this build
- Build team: **PASS** — Not supplied by this build
- Signed application identifier / team: **NOT_TESTED** — Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- Expected App Group: **PASS** — Not configured
- App Group container: **NOT_SUPPORTED** — Unavailable for the expected identifier
- Keychain Access Groups: **NOT_TESTED** — The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- All signed entitlements: **NOT_SUPPORTED** — No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- URL schemes: **PASS** — sandboxresearchlab
- Associated domains (declared metadata): **PASS** — None declared
- Universal-link association: **NOT_TESTED** — Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- Share/document communication: **PASS** — System share sheet for app-created files; user-selected JSON import. No bundled share extension or implicit shared-container access.

### Evidence

#### Bundle identifier · D33AC454-7836-4376-863C-D4510A86A1BC

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: com.xsxs18.sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: com.xsxs18.sandboxresearchlab
- knowledge: Observed

#### Build application identifier · 9D98C71D-0858-4048-9818-0C75833FB481

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Build team · AC3AFBF0-D058-4A1D-A8CE-F9D242F5BBDD

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Signed application identifier / team · 2F05DA77-2C64-4101-BD4C-DDB8E1301E7E

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- knowledge: Requires manual verification

#### Expected App Group · BDCBF497-6D5C-49E3-83F7-8AE6DABD95EB

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not configured
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not configured
- knowledge: Configured

#### App Group container · C21584B6-2549-4F36-B505-9A603A386270

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Unavailable for the expected identifier
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Unavailable
- knowledge: Unavailable

#### Keychain Access Groups · 80E862BA-FFE9-490B-A262-951EFCFEFDCE

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- knowledge: Requires manual verification

#### All signed entitlements · 14A6C4B2-847D-4A67-BBE9-13606E73F1E0

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- knowledge: Unavailable

#### URL schemes · 5C95FEA9-3519-4C4A-89D5-B19DECC0B04C

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: sandboxresearchlab
- knowledge: Configured

#### Associated domains (declared metadata) · 3F1C7F78-1906-4F04-8717-14597C316B43

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: None declared
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: None declared
- knowledge: Configured

#### Universal-link association · B79E4058-7DAF-4364-9AFF-08D89CE5D33A

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- knowledge: Requires manual verification

#### Share/document communication · 442D126C-4788-44CF-87F2-B19B6996AF3D

- Timestamp: 2026-10-31T11:18:48Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: System share sheet for app-created files; user-selected JSON import. No bundled share extension or implicit shared-container access.
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: System share sheet for app-created files; user-selected JSON import. No bundled share extension or implicit shared-container access.
- knowledge: Configured

### Security Interpretation

Evidence is incomplete or requires manual interaction/a later launch. No success is claimed for the untested operation.

### Conclusion

Recorded state: NOT_TESTED. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Experiment: Optional App Group

- ID: files.app-group
- Category: App Group
- Result: **NOT_SUPPORTED**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Test only an App Group container authorized for this application.

### Method

Resolve the configured group identifier and run the isolated file lifecycle if available.

### Expected Behavior

Configured, provisioned groups resolve; missing configuration is NOT\_SUPPORTED.

### Observed Behavior

- RESOLVE\_GROUP: **NOT_SUPPORTED** — No authorized container resolved. Enable App Groups in Signing & Capabilities, select your group, and set LabAppGroupIdentifier to the same identifier. Rebuild with a matching provisioning profile.

### Evidence

#### RESOLVE\_GROUP · 43C6A054-8B00-4746-9916-70AEE507C5E6

- Timestamp: 2026-10-31T11:18:48Z
- Resource: No group configured
- Expected: Resolve an entitled App Group container
- Actual: No authorized container resolved. Enable App Groups in Signing & Capabilities, select your group, and set LabAppGroupIdentifier to the same identifier. Rebuild with a matching provisioning profile.
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The capability or configuration was unavailable. No enforcement conclusion can be drawn.

### Conclusion

Recorded state: NOT_SUPPORTED. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Experiment: Keychain lifecycle

- ID: keychain.own-item
- Category: Keychain
- Result: **PASS**
- Start: 2026-10-31T11:18:48Z
- End: 2026-10-31T11:18:48Z

### Objective

Measure create, retrieve, update and delete for a single item owned by this run.

### Method

Use a unique generic-password service/account, non-synchronizing ThisDeviceOnly accessibility, and exact-match queries. Verify byte equality without exporting the bytes.

### Expected Behavior

An app can manage its own item when protected data is accessible; deletion is verified by errSecItemNotFound.

### Observed Behavior

- CREATE: **PASS** — OSStatus 0: No error.. Verification: matched / not applicable
- READ: **PASS** — OSStatus 0: No error.. Verification: matched / not applicable
- UPDATE: **PASS** — OSStatus 0: No error.. Verification: matched / not applicable
- READ\_UPDATED: **PASS** — OSStatus 0: No error.. Verification: matched / not applicable
- DELETE: **PASS** — OSStatus 0: No error.. Verification: matched / not applicable
- VERIFY\_DELETED: **PASS** — OSStatus -25300: The specified item could not be found in the keychain.. Verification: matched / not applicable

### Evidence

#### CREATE · E512C095-76AE-4759-99FA-CC2A700C8AF9

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ · CB0F7BF2-E85A-4D62-BEE4-2636FE89B6AA

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- compare.observedAccessGroup: TEAMID.\*
- expectedOSStatus: 0
- knowledge: Observed attribute of this run's own item; not a list of all entitled groups

#### UPDATE · 3FAB7272-7192-4995-932B-566BD15D51C8

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ\_UPDATED · 547A0FAB-6FAB-473C-A8FB-A534833A4760

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### DELETE · 87348825-CDE8-43F1-A20A-930D5AC76815

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### VERIFY\_DELETED · 5CA2F5C1-F176-4A77-A2C2-1CBEBCAB1026

- Timestamp: 2026-10-31T11:18:48Z
- Resource: lab.keychain.58153EEE-8CF9-48B9-BAEF-21B450851C23
- Expected: OSStatus -25300; returned values match when applicable
- Actual: OSStatus -25300: The specified item could not be found in the keychain.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: -25300
- expectedOSStatus: -25300

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

No Keychain secret is logged. If deletion fails, the exact unique service is retained in evidence for manual cleanup; no broad Keychain deletion is performed.

## Experiment: Communication configuration

- ID: communication.configuration
- Category: Communication
- Result: **NOT_TESTED**
- Start: 2026-10-31T11:18:49Z
- End: 2026-10-31T11:18:49Z

### Objective

Inspect the app's declared URL and document mechanisms.

### Method

Read this app's URL scheme and associated-domain metadata. Separate external interactions from automatic inspection.

### Expected Behavior

Configuration is visible. Actual handoff and incoming links require explicit user interaction.

### Observed Behavior

- URL\_SCHEMES: **PASS** — sandboxresearchlab
- URL\_ROUND\_TRIP: **NOT_TESTED** — Use Manual Lab → Open own URL scheme.
- DOCUMENT\_HANDOFF: **NOT_TESTED** — Use Manual Lab → Share lab document. JSON/Markdown exports also use system sharing.
- UNIVERSAL\_LINK: **NOT_TESTED** — No owned web domain is assumed. Configure Associated Domains and AASA as documented, then tap a link from outside the app.
- SHARE\_EXTENSION: **NOT_SUPPORTED** — No extension is bundled. The system share sheet can invoke installed, user-selected extensions. App Group file access does not prove a second process exchanged data.

### Evidence

#### URL\_SCHEMES · 97AF373E-5CBB-47D4-8638-FF3617141D1A

- Timestamp: 2026-10-31T11:18:49Z
- Resource: CFBundleURLTypes
- Expected: Read own declared schemes
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.schemes: sandboxresearchlab
- knowledge: Configured

#### URL\_ROUND\_TRIP · 6567E909-373D-4ED7-9DFD-8CFB07EA486B

- Timestamp: 2026-10-31T11:18:49Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Open own URL scheme.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DOCUMENT\_HANDOFF · 33645A4E-7EB3-4031-A04E-FE7257074BE6

- Timestamp: 2026-10-31T11:18:49Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Share lab document. JSON/Markdown exports also use system sharing.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### UNIVERSAL\_LINK · 56660988-1504-4BF5-BC5E-2CCBE8D8B2CC

- Timestamp: 2026-10-31T11:18:49Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: No owned web domain is assumed. Configure Associated Domains and AASA as documented, then tap a link from outside the app.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SHARE\_EXTENSION · 91DEC98F-0319-437B-9A66-F13468DC298F

- Timestamp: 2026-10-31T11:18:49Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: No extension is bundled. The system share sheet can invoke installed, user-selected extensions. App Group file access does not prove a second process exchanged data.
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

Evidence is incomplete or requires manual interaction/a later launch. No success is claimed for the untested operation.

### Conclusion

Recorded state: NOT_TESTED. Interpret the individual evidence and limitations above.

### Research Notes

No additional notes.

## Experiment: Protection: Complete

- ID: protection.complete
- Category: File Protection
- Result: **PASS**
- Start: 2026-10-31T11:18:49Z
- End: 2026-10-31T11:18:49Z

### Objective

Apply and inspect NSFileProtectionComplete on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionComplete
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674334<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 2BF42FE7-85E8-4F34-AD42-9AE824E6C950

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FA75EEB7-1FC4-487A-A311-7312C8D003A4/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 2066E18C-00A7-4D58-88D9-21AD243692B4

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FA75EEB7-1FC4-487A-A311-7312C8D003A4/probe.bin
- Expected: NSFileProtectionComplete
- Actual: Set NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 8578739B-90DA-494C-8729-B1058A0097BE

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FA75EEB7-1FC4-487A-A311-7312C8D003A4/probe.bin
- Expected: Returned protection equals NSFileProtectionComplete
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674334<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · A0D6B2A7-12CD-4AF8-8D65-737B0D2FBDF3

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FA75EEB7-1FC4-487A-A311-7312C8D003A4/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · F49F50B6-C59B-48A0-9B46-56DAA30D2214

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FA75EEB7-1FC4-487A-A311-7312C8D003A4
- Expected: Remove this run's files
- Actual: Removed test directory
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Access becomes unavailable shortly after locking. Timing and process suspension matter.

## Experiment: Protection: Complete unless open

- ID: protection.unlessOpen
- Category: File Protection
- Result: **PASS**
- Start: 2026-10-31T11:18:49Z
- End: 2026-10-31T11:18:49Z

### Objective

Apply and inspect NSFileProtectionCompleteUnlessOpen on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUnlessOpen
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674339<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 78A15DE7-3794-44EE-B8D9-ECBAD9D442FC

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-4A973FAC-9AB4-4F65-B19E-D3D91376C0A5/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · F39505B8-3D74-4C92-AF49-CA06C6F40D58

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-4A973FAC-9AB4-4F65-B19E-D3D91376C0A5/probe.bin
- Expected: NSFileProtectionCompleteUnlessOpen
- Actual: Set NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 4D989C19-63BF-44B6-BD62-C3CF386EF379

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-4A973FAC-9AB4-4F65-B19E-D3D91376C0A5/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUnlessOpen
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674339<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 9A28BECD-1048-4C91-A016-A0621BA38748

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-4A973FAC-9AB4-4F65-B19E-D3D91376C0A5/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · B708BB01-2C16-4560-8C23-044122F688F9

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-4A973FAC-9AB4-4F65-B19E-D3D91376C0A5
- Expected: Remove this run's files
- Actual: Removed test directory
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

An already-open file can remain accessible after locking. Opening existing closed files is restricted.

## Experiment: Protection: Until first authentication

- ID: protection.untilFirstAuthentication
- Category: File Protection
- Result: **PASS**
- Start: 2026-10-31T11:18:49Z
- End: 2026-10-31T11:18:49Z

### Objective

Apply and inspect NSFileProtectionCompleteUntilFirstUserAuthentication on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUntilFirstUserAuthentication
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674344<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 2905959F-DD21-4CBF-8401-80EB9A450BBB

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-AC1A600E-51D2-40D7-BAEC-9514C5411A3D/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 379BB62C-8D88-4C14-B86E-BD7561387F12

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-AC1A600E-51D2-40D7-BAEC-9514C5411A3D/probe.bin
- Expected: NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: Set NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 3FE1712E-4BAB-423F-A553-7C451C15DADF

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-AC1A600E-51D2-40D7-BAEC-9514C5411A3D/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674344<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 7A54BF93-B2A1-445E-818F-2194921348B0

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-AC1A600E-51D2-40D7-BAEC-9514C5411A3D/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · D13D5129-B878-494B-85D5-10F18823B8AA

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-AC1A600E-51D2-40D7-BAEC-9514C5411A3D
- Expected: Remove this run's files
- Actual: Removed test directory
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Unavailable until the first unlock after boot; remains accessible through subsequent locks.

## Experiment: Protection: No file protection

- ID: protection.none
- Category: File Protection
- Result: **PASS**
- Start: 2026-10-31T11:18:49Z
- End: 2026-10-31T11:18:49Z

### Objective

Apply and inspect NSFileProtectionNone on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionNone
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674348<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 9BD7F285-E050-48DF-B754-5AA990769BC9

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-1C06C0EB-D769-4F4F-8987-28A0F227FA1D/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · D0727C23-FEE2-4C1C-9BBF-F6F7CFA155F6

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-1C06C0EB-D769-4F4F-8987-28A0F227FA1D/probe.bin
- Expected: NSFileProtectionNone
- Actual: Set NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 7F97902B-9AEF-4F0C-8B00-B69DE8CBD92A

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-1C06C0EB-D769-4F4F-8987-28A0F227FA1D/probe.bin
- Expected: Returned protection equals NSFileProtectionNone
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 11:18:49 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 11:18:49 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34674348<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · F5CD3C9B-022A-4417-AD20-2CE953C88F04

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-1C06C0EB-D769-4F4F-8987-28A0F227FA1D/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 89A90F2E-E06C-4095-84B7-7168051E52A2

- Timestamp: 2026-10-31T11:18:49Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-1C06C0EB-D769-4F4F-8987-28A0F227FA1D
- Expected: Remove this run's files
- Actual: Removed test directory
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

No lock-dependent file protection. This does not mean raw storage lacks hardware encryption.

## Limitations

This report is generated from local evidence, not a security attestation. Configuration is not proof of signed entitlement grants. Lock-state, relaunch, signing and external link behavior require the documented manual checks. Imported sessions and researcher notes are not independently authenticated.
