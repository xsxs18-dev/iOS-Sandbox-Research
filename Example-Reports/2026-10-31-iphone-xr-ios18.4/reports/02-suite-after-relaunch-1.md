# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: D71A12ED-9BFE-42F3-B273-B491DBDF0689
- Date: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:31Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): A5FEF06A-B229-4692-8770-592F429E4EF6

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: App Home

- ID: files.home
- Category: Container
- Result: **DENIED**
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Measure ordinary file operations in App Home.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **DENIED** — You don’t have permission to save the file “SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683” in the folder “APP-DATA-CONTAINER”.
- CREATE: **NOT_TESTED** — Prerequisite directory creation failed
- READ: **NOT_TESTED** — Prerequisite directory creation failed
- WRITE: **NOT_TESTED** — Prerequisite directory creation failed
- ENUMERATE: **NOT_TESTED** — Prerequisite directory creation failed
- ATTRIBUTES: **NOT_TESTED** — Prerequisite directory creation failed
- DELETE: **NOT_TESTED** — Prerequisite directory creation failed

### Evidence

#### DIRECTORY\_CREATE · 62D82E81-8667-424B-BF9C-14D4B69241FF

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683
- Expected: Create isolated test directory
- Actual: You don’t have permission to save the file “SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683” in the folder “APP-DATA-CONTAINER”.
- State: DENIED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- Error domain: NSCocoaErrorDomain
- Error code: 513
- Error description: You don’t have permission to save the file “SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683” in the folder “APP-DATA-CONTAINER”.
- Underlying error: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"

#### CREATE · E4C29F6A-563F-4B44-92C2-479A2509C427

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 98002A0E-1DE1-41FC-AE92-64A8E9DAE334

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 0E2292C6-88C5-4B36-AA88-5C9D970CDF8C

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · BE0405EF-84FD-40A6-9777-C858F2D3592C

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 93C9EFE8-B282-4909-9F66-9003C2DE3DFD

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 7ECE1198-6485-4B3A-BBD6-4F65C4A54D69

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-5296CAC4-1F04-46C7-BFF7-4573AB0D6683/probe.txt
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686237<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 352CF310-EBE0-43D4-826F-9670C77B3B83

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 1280A694-747D-4137-B318-532E670E7342

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 3F8D0E81-554C-4103-9220-645611570707

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 6CDAC607-1030-45DB-902E-1672A2024FD9

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 55D24CB6-0FCC-442F-B984-FFA0DE055DD2

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 52B8714D-FDD9-4D4E-8930-5B99D1A78D81

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686237<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · DD62B829-8249-470B-9918-0E4B282A05B3

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 149B3FB5-2632-4162-8636-8427A6CB0DCA

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-77C735EB-7B76-4AA1-A4D1-99CAEF6194EF
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686241<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · C2E11000-D964-4EB6-B1E0-8CFACF7D75B0

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 6AD57DED-A05A-4AFC-A950-B75B18338613

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 93724F7F-FA29-4DDF-A62D-72685AE1097A

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · DBBCC663-DDED-4C63-8D67-BD8BA0F0B7B8

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 73D962AE-01A5-4681-B8BA-3621DE8114E7

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 9874B446-7ADD-4678-A90F-ABF9CBFC1E28

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686241<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · CA36C503-A2C8-4E83-A766-BB14048869EE

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 32489132-A181-4B13-994C-00766562442C

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-3B6AA930-10E1-4539-94AE-5B592A147FE3
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686245<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 720A4C76-0106-4DA1-BC05-88D6930F4938

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · CC061CB0-2448-4F51-8407-D36D39A5CBBA

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 54256F31-CA6B-421E-832F-64FAF5BBAA4A

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · B3C9EE2D-662E-4993-848F-7D42B7E03BA6

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 2CBD5DAD-C611-44CF-A29D-0B48F5C1708D

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · E06E3F4B-65DA-48D5-99FC-86656415FF20

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686245<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · D71291A3-CBB0-4AB4-97BD-4E9085F31EB4

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 7D0C9EA0-4D24-46B0-9C52-93C7096FA156

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-3BDF8849-6A77-401F-907C-27CA95360394
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686249<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 860782A5-A69C-4BF2-BAEC-A300A4A4FC00

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 3771D496-105D-4A6E-83CA-7BB693FAA38E

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 7C8C4A5E-AB1C-4A11-BB9D-9D687462631A

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 23694798-F95F-4285-9356-D8A55406A9D8

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · A68DA172-8690-4013-AF69-7B3529355193

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · E1134D8B-17A3-44FD-A8B9-C24E2C499BA3

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686249<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · DE461316-9611-4264-BB7A-5AA005464FB3

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 0EFCB30C-EC6C-443C-B7E4-270B35078B87

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-5CF07EEF-2497-4547-BF03-61E569C32DFF
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686253<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 356A18BC-23CB-4C66-ABE4-BED743A56ACB

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 69109D2D-859E-4CDD-B4FB-64CBF4C26371

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 147F5903-1BB2-400C-8A9D-01260A8D5838

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 352DA9C1-8F55-49F8-BF5D-98B1217511E2

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · BE1A7695-DC60-4C78-A497-5BB0358175E7

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · D94BE616-8555-488F-BE1C-99D37AE1C32A

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686253<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · D28C23F0-FD4C-4048-9B9D-6A5E4208C057

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 25DBDC9D-F922-45F2-8067-1CBF129890D1

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-79AACB16-DC3D-40AB-9549-9898C8783F71
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
- Result: **PASS**
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Check that an app-owned Application Support file survives a process relaunch.

### Method

Keep an independent receipt and marker. Compare the marker bytes on a later launch, then re-arm the baseline.

### Expected Behavior

A marker remains readable and unchanged on a later launch without reinstall or data removal.

### Observed Behavior

- PERSISTENCE: **PASS** — Marker from 2026-10-31T11:18:10Z survived a different process launch; bytes match
- ARM\_BASELINE: **PASS** — Baseline saved for a future launch

### Evidence

#### PERSISTENCE · CBCCBA57-3102-47AB-848A-4EE228BB5ADE

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Persistence/launch-marker.txt
- Expected: Previously recorded marker survives relaunch
- Actual: Marker from 2026-10-31T11:18:10Z survived a different process launch; bytes match
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ARM\_BASELINE · 175CA1AF-87FA-4858-8AA0-208BBD93EC41

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Persistence/launch-marker.txt
- Expected: Save matching marker and receipt
- Actual: Baseline saved for a future launch
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

### Security Interpretation

The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security.

### Conclusion

Recorded state: PASS. Interpret the individual evidence and limitations above.

### Research Notes

Reinstall, backup restore, or deliberate lab-data removal invalidates continuity. Cache and tmp retention are not asserted.

## Experiment: Entitlements & configuration

- ID: configuration.inspect
- Category: Entitlements
- Result: **NOT_TESTED**
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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

#### Bundle identifier · C29EF457-9369-4BFA-A80B-081D86D7A91A

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: com.xsxs18.sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: com.xsxs18.sandboxresearchlab
- knowledge: Observed

#### Build application identifier · 159B1097-9935-4365-BB4E-6516E413305F

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Build team · 8D9C6B6E-A158-437A-A281-344FE8093541

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Signed application identifier / team · E0B64964-FACA-4AD5-9E90-1E877BB3F221

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- knowledge: Requires manual verification

#### Expected App Group · 3344C3D4-99AF-46D9-8CE7-5261724B6825

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not configured
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not configured
- knowledge: Configured

#### App Group container · 962CCCA8-BFDE-49FE-B04C-FC5D6794D338

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Unavailable for the expected identifier
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Unavailable
- knowledge: Unavailable

#### Keychain Access Groups · 75F4C30A-505B-4D9C-8B5D-3E2E91E4A70D

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- knowledge: Requires manual verification

#### All signed entitlements · 56E5F5A0-2121-406D-94C6-6158791D9F43

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- knowledge: Unavailable

#### URL schemes · 027BB15D-425D-4A80-B423-BCE6DF97295B

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: sandboxresearchlab
- knowledge: Configured

#### Associated domains (declared metadata) · 6AE1433D-2B3F-4D14-8911-64D11D845DC2

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: None declared
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: None declared
- knowledge: Configured

#### Universal-link association · D7B1538E-29FD-49FF-A565-DE0A8AD40373

- Timestamp: 2026-10-31T12:25:30Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- knowledge: Requires manual verification

#### Share/document communication · 7127585C-38F9-4A8D-95E3-D149230E38B1

- Timestamp: 2026-10-31T12:25:30Z
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Test only an App Group container authorized for this application.

### Method

Resolve the configured group identifier and run the isolated file lifecycle if available.

### Expected Behavior

Configured, provisioned groups resolve; missing configuration is NOT\_SUPPORTED.

### Observed Behavior

- RESOLVE\_GROUP: **NOT_SUPPORTED** — No authorized container resolved. Enable App Groups in Signing & Capabilities, select your group, and set LabAppGroupIdentifier to the same identifier. Rebuild with a matching provisioning profile.

### Evidence

#### RESOLVE\_GROUP · 8798CCAD-CCC3-4280-87C5-84F49A667A55

- Timestamp: 2026-10-31T12:25:30Z
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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

#### CREATE · DDDF6903-BAEB-4C0D-8BC6-FBD5DAE860C7

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ · 705BD938-7372-49C4-AE2D-F9777506C615

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- compare.observedAccessGroup: TEAMID.\*
- expectedOSStatus: 0
- knowledge: Observed attribute of this run's own item; not a list of all entitled groups

#### UPDATE · 2CEE11C0-D08B-466A-B369-B4E1A37518A8

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ\_UPDATED · 38C6FD00-01FC-4BDC-9B32-5B57DD98AF35

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### DELETE · 2AB7D82E-3C06-4EA3-AF42-E05500235A15

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### VERIFY\_DELETED · 0EF4E92B-E099-40E7-A4D0-B9EA969258A3

- Timestamp: 2026-10-31T12:25:30Z
- Resource: lab.keychain.2FA3D468-33C3-424C-90D1-942FE5196FD2
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

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

#### URL\_SCHEMES · 6F24A709-A266-473E-8311-F08B588445FA

- Timestamp: 2026-10-31T12:25:30Z
- Resource: CFBundleURLTypes
- Expected: Read own declared schemes
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.schemes: sandboxresearchlab
- knowledge: Configured

#### URL\_ROUND\_TRIP · 5FC389F5-7408-49FD-BFBA-0AF9E492541D

- Timestamp: 2026-10-31T12:25:30Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Open own URL scheme.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DOCUMENT\_HANDOFF · 2663B00F-201A-46D7-9DF3-BC7FCF9ACAA0

- Timestamp: 2026-10-31T12:25:30Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Share lab document. JSON/Markdown exports also use system sharing.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### UNIVERSAL\_LINK · 92200CF3-14EA-4447-924D-75255B9BE088

- Timestamp: 2026-10-31T12:25:30Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: No owned web domain is assumed. Configure Associated Domains and AASA as documented, then tap a link from outside the app.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SHARE\_EXTENSION · CCDE10B9-591C-44CF-8D53-279458AEB415

- Timestamp: 2026-10-31T12:25:30Z
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Apply and inspect NSFileProtectionComplete on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionComplete
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686271<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · E3E7A027-3DB7-4C5E-8055-644E6030C776

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-B2B93E67-4AFD-4A7B-9BAE-D732BDF089B0/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 8F09F8EA-95B7-47C5-B406-E8AD542AAFEA

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-B2B93E67-4AFD-4A7B-9BAE-D732BDF089B0/probe.bin
- Expected: NSFileProtectionComplete
- Actual: Set NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · F5E64BB8-4861-4D33-87BE-A85EC3860642

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-B2B93E67-4AFD-4A7B-9BAE-D732BDF089B0/probe.bin
- Expected: Returned protection equals NSFileProtectionComplete
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686271<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 2B222421-494A-42AF-9241-68EBFECDA80C

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-B2B93E67-4AFD-4A7B-9BAE-D732BDF089B0/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · D7503BE6-4AAB-4677-B77C-3F1165166E7B

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-B2B93E67-4AFD-4A7B-9BAE-D732BDF089B0
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Apply and inspect NSFileProtectionCompleteUnlessOpen on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUnlessOpen
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686276<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 7B17F4B0-078B-428B-BFB6-B41E3BB89B54

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-ED7AC75C-83AC-455D-9AE7-FCC64056786F/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 2AD657BE-A1F8-4A89-B9A5-D46881823745

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-ED7AC75C-83AC-455D-9AE7-FCC64056786F/probe.bin
- Expected: NSFileProtectionCompleteUnlessOpen
- Actual: Set NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 17967E8F-48D2-4D23-B275-7602AD092FDA

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-ED7AC75C-83AC-455D-9AE7-FCC64056786F/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUnlessOpen
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686276<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 578784D6-C19C-4155-8E87-972045116215

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-ED7AC75C-83AC-455D-9AE7-FCC64056786F/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 0997F6A1-9DDE-454F-8DDE-2EF182933759

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-ED7AC75C-83AC-455D-9AE7-FCC64056786F
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
- Start: 2026-10-31T12:25:30Z
- End: 2026-10-31T12:25:30Z

### Objective

Apply and inspect NSFileProtectionCompleteUntilFirstUserAuthentication on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUntilFirstUserAuthentication
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686281<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 2345E795-7003-4F79-99C8-A6C32EE904C5

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FD4E371C-BC2F-44B0-82C2-AE458167DC2A/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · F0E43F91-5DF9-4F00-823A-80315853144F

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FD4E371C-BC2F-44B0-82C2-AE458167DC2A/probe.bin
- Expected: NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: Set NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · CCCECD03-7AB1-422A-A010-40C475C22C5C

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FD4E371C-BC2F-44B0-82C2-AE458167DC2A/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:30 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:30 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686281<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 91CABEDD-3657-4015-A1FA-3562104B0B27

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FD4E371C-BC2F-44B0-82C2-AE458167DC2A/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · B692EAE9-8111-4418-A499-E3DCCABB8403

- Timestamp: 2026-10-31T12:25:30Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-FD4E371C-BC2F-44B0-82C2-AE458167DC2A
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
- Start: 2026-10-31T12:25:31Z
- End: 2026-10-31T12:25:31Z

### Objective

Apply and inspect NSFileProtectionNone on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionNone
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:31 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:31 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686285<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 650C774B-1BBE-49BF-ABCE-182390A49C69

- Timestamp: 2026-10-31T12:25:31Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-2D6D0C96-FD09-45F5-AA34-255A563B4BCA/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 029C82DB-1903-456D-8F70-FD5EEC798935

- Timestamp: 2026-10-31T12:25:31Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-2D6D0C96-FD09-45F5-AA34-255A563B4BCA/probe.bin
- Expected: NSFileProtectionNone
- Actual: Set NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 204EE236-C092-46FC-AD36-8D1D928675D4

- Timestamp: 2026-10-31T12:25:31Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-2D6D0C96-FD09-45F5-AA34-255A563B4BCA/probe.bin
- Expected: Returned protection equals NSFileProtectionNone
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:25:31 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:25:31 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686285<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 80CEF5B8-D106-47A9-AE28-5A7EB37780C6

- Timestamp: 2026-10-31T12:25:31Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-2D6D0C96-FD09-45F5-AA34-255A563B4BCA/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 5D50D889-26BD-4765-AA5B-4BD10203612A

- Timestamp: 2026-10-31T12:25:31Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-2D6D0C96-FD09-45F5-AA34-255A563B4BCA
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
