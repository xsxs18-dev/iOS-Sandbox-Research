# iOS Sandbox Research Report

## Environment

- iOS Version: iOS 18.4 (Version 18.4 (Build 22E240))
- Device: iPhone11,8
- Runtime: Device
- Application: SandboxResearchLab 1.0.0 (1.0.0)
- Bundle ID: com.xsxs18.sandboxresearchlab
- Research Session: 77B2E78D-92C2-4607-A510-10FCBAFAD464
- Date: 2026-10-31T12:26:05Z
- End: 2026-10-31T12:26:06Z
- Completion: completed
- Protected data available at session start: true
- Launch ID (random, per process): 6154A196-96FC-4C55-822A-0CF00B760458

Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.

## Researcher notes

No researcher notes recorded.

## Experiment: App Home

- ID: files.home
- Category: Container
- Result: **DENIED**
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Measure ordinary file operations in App Home.

### Method

Create a unique lab directory, create/read/modify a known byte sequence, enumerate and inspect it, then delete it and verify absence.

### Expected Behavior

Operations on this application's own test files should succeed while storage and protection conditions permit.

### Observed Behavior

- DIRECTORY\_CREATE: **DENIED** — You don’t have permission to save the file “SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167” in the folder “APP-DATA-CONTAINER”.
- CREATE: **NOT_TESTED** — Prerequisite directory creation failed
- READ: **NOT_TESTED** — Prerequisite directory creation failed
- WRITE: **NOT_TESTED** — Prerequisite directory creation failed
- ENUMERATE: **NOT_TESTED** — Prerequisite directory creation failed
- ATTRIBUTES: **NOT_TESTED** — Prerequisite directory creation failed
- DELETE: **NOT_TESTED** — Prerequisite directory creation failed

### Evidence

#### DIRECTORY\_CREATE · 75ED1EAC-6BC8-4B86-9FE8-0D2AC98EDD0E

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167
- Expected: Create isolated test directory
- Actual: You don’t have permission to save the file “SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167” in the folder “APP-DATA-CONTAINER”.
- State: DENIED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- Error domain: NSCocoaErrorDomain
- Error code: 513
- Error description: You don’t have permission to save the file “SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167” in the folder “APP-DATA-CONTAINER”.
- Underlying error: Error Domain=NSPOSIXErrorDomain Code=1 "Operation not permitted"

#### CREATE · 751EE49E-99DB-4097-BA2F-C9D4C4E1EA32

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · EA556E39-43C2-4049-BA75-40E0A4C3C505

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 1D48B2DC-CA25-48D0-BEA5-870B535D8485

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 874FD19C-6B92-4ADD-8355-DD79B421435E

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · A84ED84A-7437-4168-B254-E2E93B91A695

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
- Expected: Exercise own test file
- Actual: Prerequisite directory creation failed
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · CF0DCB96-49A2-45C9-B8E8-181F9EBE8923

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/SandboxResearchLab-31313851-3606-495F-8C84-D5D638998167/probe.txt
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686356<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 573BCB4E-AE0D-42DE-846A-22360620424A

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · AD55F011-CAC0-41BE-938B-F5EF1157B0C9

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 595B551D-E9AE-4237-BE70-1D66A5D20719

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 7B0C6F5C-146E-489B-A639-E7848245E698

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · A26A56FD-A4D7-40A0-9C46-48D2FFFFD018

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 09FED5FE-FF28-47EF-AC82-1A6E9E78726B

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686356<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · FFCA8B01-6BE4-43AF-8B4E-0B1A3C845CB6

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · EFF1C4B4-3147-44F1-8EC8-B52065454D7C

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Documents/SandboxResearchLab-1D268E0C-6ACF-41F3-9205-92717E928368
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686360<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · C1730EFD-82E8-4574-9834-F6833C239F09

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 04AC3E23-0273-455F-B3BB-7767D3D80610

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · AC742B45-5B01-4F29-BFE1-593D81B08BF4

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 2313D65A-DF57-4338-9309-EBC446378A4E

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 2DD06F84-7D6F-4A7A-82AC-A41150DB8770

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 44E3EC55-9C57-4865-90C4-926210ED36AA

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686360<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 2BEEDFF0-716E-47B8-BB27-3C66006201B3

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 6DA449F8-754C-4311-A388-C73AB3EDF3D6

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/SandboxResearchLab-77D02201-2113-4C6A-A8ED-04F3838F2610
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686364<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · A594E65F-44D2-463C-9531-224369F2FAD1

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 95526F83-0719-4920-B1BA-14F44C2DBDCD

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · B7F7391F-4B74-4701-9DEF-6EB6B9FE8CBA

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 1F00F2C5-74D0-4D82-BBF1-8D60E984B4DD

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · AD27D043-F70F-4DC1-958C-BE4E2B755F87

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 4706A8E5-7C3F-435E-88BD-35385F37653B

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686364<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · EAA0B050-C332-463D-998A-BB071ECFE8B2

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 6105B036-2BF5-4E2B-834F-1E22AEB65CBA

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Caches/SandboxResearchLab-7867E56D-CDDF-4C20-B1BF-451B85138817
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686368<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 9E871B77-DFB1-4D90-98F4-A3B51922CFAC

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 792975EF-CA94-425C-B2FF-66EEE6DA60F1

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · A6842E87-51C9-4FC3-8F06-BF6A4A216209

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · 6F52602E-38DA-4336-8A6A-F88EBA87FFD0

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · B7B28BA5-A148-4283-8C5B-DFF66D357314

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 72EAD97E-3AA1-4EF9-BB6C-7145A6BA9ACB

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686368<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 0F224C00-7F23-441F-A355-6E09B154EC85

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 5B381990-29A4-4618-B5AA-6CCB1744D7A7

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab-E825723B-EE21-461D-9C78-7892E028E94E
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686372<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- DELETE: **PASS** — Deleted; absence verified by directory enumeration
- CLEANUP: **PASS** — Test directory removed

### Evidence

#### DIRECTORY\_CREATE · 04C6100D-B1C6-4410-88C5-6E4BA8C75009

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876
- Expected: Create isolated test directory
- Actual: Directory created
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CREATE · 60AAE887-5C24-47DD-85B8-66DC3019387F

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876/probe.txt
- Expected: Create new file with known bytes
- Actual: Created 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · A73C4E0B-CF1C-475B-B7FC-CD9401C97300

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876/probe.txt
- Expected: Read exact initial bytes
- Actual: Read and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### WRITE · C6C1650A-B5A3-43E6-A096-0B16A9AC2850

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876/probe.txt
- Expected: Modify file and read back exact new bytes
- Actual: Modified and verified 23 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ENUMERATE · 6056F576-34E9-42CE-934A-18D23FF5C0A7

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876
- Expected: Enumeration includes probe.txt
- Actual: Entries: probe.txt
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · DAC5E3F1-A2F5-4D6F-813F-1B8F820929BD

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876/probe.txt
- Expected: Read file attributes
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=23<br>NSFileSystemFileNumber=34686372<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DELETE · 88C63BE3-9142-42F6-9E58-B50D287762F9

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876/probe.txt
- Expected: Delete test file and confirm absence
- Actual: Deleted; absence verified by directory enumeration
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · AF96D602-4896-4542-9B95-F43582E00B0E

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /private/var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/tmp/SandboxResearchLab-724CFBE5-F138-481B-8E8D-910EA026D876
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Check that an app-owned Application Support file survives a process relaunch.

### Method

Keep an independent receipt and marker. Compare the marker bytes on a later launch, then re-arm the baseline.

### Expected Behavior

A marker remains readable and unchanged on a later launch without reinstall or data removal.

### Observed Behavior

- PERSISTENCE: **PASS** — Marker from 2026-10-31T12:25:30Z survived a different process launch; bytes match
- ARM\_BASELINE: **PASS** — Baseline saved for a future launch

### Evidence

#### PERSISTENCE · AA1D0FFB-EB51-4132-A7FC-4E85BB96ED68

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Persistence/launch-marker.txt
- Expected: Previously recorded marker survives relaunch
- Actual: Marker from 2026-10-31T12:25:30Z survived a different process launch; bytes match
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ARM\_BASELINE · D98081A6-C4B2-4817-93E4-ADC39DE5DA70

- Timestamp: 2026-10-31T12:26:06Z
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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

#### Bundle identifier · DB1697E5-F1AE-4665-9EFE-51E6D3D0381B

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: com.xsxs18.sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: com.xsxs18.sandboxresearchlab
- knowledge: Observed

#### Build application identifier · BBFE1061-0DF1-4475-A0E4-AF243B7C1C7C

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Build team · A68101E9-AA6A-47E0-BC7C-AE2F0DE1F127

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not supplied by this build
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not supplied by this build
- knowledge: Configured

#### Signed application identifier / team · 062784AA-1D56-4D4D-B7BD-0D234C503AA4

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Inspect the installed build's signature and provisioning in Xcode/codesign. Build metadata is not signed-entitlement introspection.
- knowledge: Requires manual verification

#### Expected App Group · 521193C6-B46D-4AB9-A2A5-8845E0CA9C54

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Not configured
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Not configured
- knowledge: Configured

#### App Group container · 99C5FC05-7E5C-430F-A026-DF76A8F971A0

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Unavailable for the expected identifier
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Unavailable
- knowledge: Unavailable

#### Keychain Access Groups · 8C4C1694-1879-4EDB-8287-41B751428F6A

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: The Keychain experiment observes the returned access-group attribute of its own newly created item. It does not enumerate entitled groups.
- knowledge: Requires manual verification

#### All signed entitlements · 95B3B814-31D6-4BBA-BADD-FB227A2B1679

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- State: NOT_SUPPORTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: No supported general iOS entitlement-dump API is used. No private SecTask APIs or provisioning-profile scraping.
- knowledge: Unavailable

#### URL schemes · 0253069A-8B35-4793-9F11-0CB6F1825F2A

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: sandboxresearchlab
- knowledge: Configured

#### Associated domains (declared metadata) · 00AE6F69-E62B-41CD-ACAD-7867FF648929

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: None declared
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: None declared
- knowledge: Configured

#### Universal-link association · 175BB321-2945-48FF-BD0D-CC6A22505B8D

- Timestamp: 2026-10-31T12:26:06Z
- Resource: This application's configuration
- Expected: Report provenance accurately
- Actual: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.configuration: Requires signed Associated Domains entitlement, an owned HTTPS domain with AASA, and an external tap on device.
- knowledge: Requires manual verification

#### Share/document communication · 148AF27E-DF02-4CF6-8BA0-AF1058B00936

- Timestamp: 2026-10-31T12:26:06Z
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Test only an App Group container authorized for this application.

### Method

Resolve the configured group identifier and run the isolated file lifecycle if available.

### Expected Behavior

Configured, provisioned groups resolve; missing configuration is NOT\_SUPPORTED.

### Observed Behavior

- RESOLVE\_GROUP: **NOT_SUPPORTED** — No authorized container resolved. Enable App Groups in Signing & Capabilities, select your group, and set LabAppGroupIdentifier to the same identifier. Rebuild with a matching provisioning profile.

### Evidence

#### RESOLVE\_GROUP · A74730FF-4790-413D-9C53-5C5086505422

- Timestamp: 2026-10-31T12:26:06Z
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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

#### CREATE · 1E1A732B-759F-4B24-916C-80008FB24360

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ · 0BCFB0AA-7513-4E40-ADD2-EC81C0DEA11C

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- compare.observedAccessGroup: TEAMID.\*
- expectedOSStatus: 0
- knowledge: Observed attribute of this run's own item; not a list of all entitled groups

#### UPDATE · 1646D3FC-9645-4353-B11E-6EEE5A5E015F

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### READ\_UPDATED · 8D25A7DA-6C6B-4E4D-B2AA-5D886D1E7D03

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### DELETE · E2BEF827-6EE7-4C3F-919D-D363F58525AE

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
- Expected: OSStatus 0; returned values match when applicable
- Actual: OSStatus 0: No error.. Verification: matched / not applicable
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- OSStatus: 0
- expectedOSStatus: 0

#### VERIFY\_DELETED · 2AB6EE62-6032-45A8-A55C-B08B057868D9

- Timestamp: 2026-10-31T12:26:06Z
- Resource: lab.keychain.CBBDA43F-E7CB-48B1-A077-3823415FCC0F
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

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

#### URL\_SCHEMES · 9FE337F1-7D6A-4F21-8B15-49DF738E6104

- Timestamp: 2026-10-31T12:26:06Z
- Resource: CFBundleURLTypes
- Expected: Read own declared schemes
- Actual: sandboxresearchlab
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true
- compare.schemes: sandboxresearchlab
- knowledge: Configured

#### URL\_ROUND\_TRIP · 9FC28A40-4777-451D-A4DD-59AABAA53025

- Timestamp: 2026-10-31T12:26:06Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Open own URL scheme.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### DOCUMENT\_HANDOFF · 5AE5F42A-51C7-4DDD-8747-37FD545503EB

- Timestamp: 2026-10-31T12:26:06Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: Use Manual Lab → Share lab document. JSON/Markdown exports also use system sharing.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### UNIVERSAL\_LINK · D9015EDE-E790-4B85-8902-57450FEBB685

- Timestamp: 2026-10-31T12:26:06Z
- Resource: User-mediated communication
- Expected: Observe only actual handoffs
- Actual: No owned web domain is assumed. Configure Associated Domains and AASA as documented, then tap a link from outside the app.
- State: NOT_TESTED
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SHARE\_EXTENSION · 7179B8B5-52A8-4AF3-853F-DB454BD26966

- Timestamp: 2026-10-31T12:26:06Z
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Apply and inspect NSFileProtectionComplete on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionComplete
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686390<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 19EF33FD-2BA3-4D18-BA62-6353666671CE

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-791FA05D-45C6-4533-A95A-82656C3FEF74/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · A14DBA03-7CD6-4C89-BB77-A394C0E87654

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-791FA05D-45C6-4533-A95A-82656C3FEF74/probe.bin
- Expected: NSFileProtectionComplete
- Actual: Set NSFileProtectionComplete
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · C937F5A6-0EB4-4EE1-856A-ECA33B613060

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-791FA05D-45C6-4533-A95A-82656C3FEF74/probe.bin
- Expected: Returned protection equals NSFileProtectionComplete
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionComplete<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686390<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 7119B427-D049-41B2-9386-1E6CE68F755A

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-791FA05D-45C6-4533-A95A-82656C3FEF74/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · FAE8A71B-1552-4C3B-9553-F8C1CE321E35

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-791FA05D-45C6-4533-A95A-82656C3FEF74
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Apply and inspect NSFileProtectionCompleteUnlessOpen on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUnlessOpen
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686395<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 313EDB23-D135-4D64-9C3D-43824A546C87

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-721643AA-C668-491B-9865-503204795C3F/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · BF871EB0-7A12-4437-97FA-D4CEEFF1C842

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-721643AA-C668-491B-9865-503204795C3F/probe.bin
- Expected: NSFileProtectionCompleteUnlessOpen
- Actual: Set NSFileProtectionCompleteUnlessOpen
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 14922B6D-6A10-42B1-A857-11E7F5CC4CA7

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-721643AA-C668-491B-9865-503204795C3F/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUnlessOpen
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUnlessOpen<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686395<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 8FE20984-6FD2-45AC-828D-EFD074F93CDE

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-721643AA-C668-491B-9865-503204795C3F/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 5F0A2245-EDF8-4303-9A3C-643A32BD4335

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-721643AA-C668-491B-9865-503204795C3F
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Apply and inspect NSFileProtectionCompleteUntilFirstUserAuthentication on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionCompleteUntilFirstUserAuthentication
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686400<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 75F61268-5CBA-41B8-B5C8-3A332EC8EF5A

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-84F8571D-2020-4672-B4FC-1954D67DF638/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · B86101FB-614A-46AC-93B2-6ED0A8040424

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-84F8571D-2020-4672-B4FC-1954D67DF638/probe.bin
- Expected: NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: Set NSFileProtectionCompleteUntilFirstUserAuthentication
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 751AAE0C-E48F-46CE-A428-A9F44E08A849

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-84F8571D-2020-4672-B4FC-1954D67DF638/probe.bin
- Expected: Returned protection equals NSFileProtectionCompleteUntilFirstUserAuthentication
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionCompleteUntilFirstUserAuthentication<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686400<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · EA98D8D2-9955-411A-989F-60723726E0C9

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-84F8571D-2020-4672-B4FC-1954D67DF638/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 06696E51-EFB7-4CED-96DB-6D65F36193DA

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-84F8571D-2020-4672-B4FC-1954D67DF638
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
- Start: 2026-10-31T12:26:06Z
- End: 2026-10-31T12:26:06Z

### Objective

Apply and inspect NSFileProtectionNone on an app-owned file.

### Method

Create a file, set protection, inspect the returned protection attribute, read exact bytes, then remove the file.

### Expected Behavior

The requested class is returned by file attributes and the file is readable in the current protection state. Lock enforcement is a separate manual observation.

### Observed Behavior

- CREATE: **PASS** — Created 34 bytes
- SET\_PROTECTION: **PASS** — Set NSFileProtectionNone
- ATTRIBUTES: **PASS** — NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686404<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- READ: **PASS** — Readback matched; this alone does not validate locked-device enforcement
- CLEANUP: **PASS** — Removed test directory

### Evidence

#### CREATE · 309FDE41-CF33-4720-8556-6D3610CAF813

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-A109C17A-D876-456C-ABBF-27ABF0143673/probe.bin
- Expected: Create own protection test file
- Actual: Created 34 bytes
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### SET\_PROTECTION · 3C33211D-DE90-4D46-98A5-0B1B7976DD19

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-A109C17A-D876-456C-ABBF-27ABF0143673/probe.bin
- Expected: NSFileProtectionNone
- Actual: Set NSFileProtectionNone
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### ATTRIBUTES · 8D45C910-6138-450C-9C69-080890998BE2

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-A109C17A-D876-456C-ABBF-27ABF0143673/probe.bin
- Expected: Returned protection equals NSFileProtectionNone
- Actual: NSFileAppendOnly=0<br>NSFileCreationDate=2026-10-31 12:26:06 +0000<br>NSFileExtensionHidden=0<br>NSFileGroupOwnerAccountID=501<br>NSFileGroupOwnerAccountName=mobile<br>NSFileImmutable=0<br>NSFileModificationDate=2026-10-31 12:26:06 +0000<br>NSFileOwnerAccountID=501<br>NSFileOwnerAccountName=mobile<br>NSFilePosixPermissions=420<br>NSFileProtectionKey=NSFileProtectionNone<br>NSFileReferenceCount=1<br>NSFileSize=34<br>NSFileSystemFileNumber=34686404<br>NSFileSystemNumber=16777225<br>NSFileType=NSFileTypeRegular
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### READ · 7DD5681D-0879-44CD-8FD0-3E15D4325586

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-A109C17A-D876-456C-ABBF-27ABF0143673/probe.bin
- Expected: Read exact test bytes in current protection state
- Actual: Readback matched; this alone does not validate locked-device enforcement
- State: PASS
- Environment: iOS 18.4 (Version 18.4 (Build 22E240)); iPhone11,8; protected data: true

#### CLEANUP · 8A4146B0-A5F5-4E2B-9393-BCA70CC794DD

- Timestamp: 2026-10-31T12:26:06Z
- Resource: /var/mobile/Containers/Data/Application/APP-DATA-CONTAINER/Library/Application Support/SandboxResearchLab/Protection-A109C17A-D876-456C-ABBF-27ABF0143673
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
