import XCTest
@testable import ResearchCore

/// These are synthetic software fixtures, never exported as device research evidence.
final class ResearchCoreTests: XCTestCase {
    func environment(launchID: UUID = UUID()) -> EnvironmentSnapshot {
        EnvironmentSnapshot(osVersion: "Synthetic test OS", deviceModel: "Unit-test fixture", application: "Test",
                            bundleID: "test.fixture", appVersion: "1", build: "1", simulator: true,
                            protectedDataAvailable: nil, capturedAt: Date(timeIntervalSince1970: 1_000), launchID: launchID)
    }
    func session(state: ResultState = .pass, error: ResearchError? = nil) -> ResearchSession {
        let env = environment()
        let definition = ExperimentDefinition(id: "test.synthetic", name: "Synthetic test only", category: .container,
                                             objective: "Test software", method: "Synthetic fixture", expectedBehavior: "Fixture only")
        let log = Evidence(experimentID: definition.id, category: .container, operation: "READ", resource: "/synthetic/path",
                           expectedResult: "Synthetic", actualResult: "Synthetic test observation", result: state, error: error, environment: env)
        return ResearchSession(title: "Synthetic test session", environment: env, completion: .completed,
                               experiments: [ExperimentRun(definition: definition, endTime: Date(), environment: env, operations: [log])])
    }
    func temporaryDirectory() throws -> URL {
        let url = FileManager.default.temporaryDirectory.appendingPathComponent("ResearchCoreTests-\(UUID().uuidString)")
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        addTeardownBlock { try FileManager.default.removeItem(at: url) }
        return url
    }
    func testJSONRoundTripPreservesErrorsNotesAndEnvironment() throws {
        var source = session(state: .denied, error: ResearchError(domain: NSPOSIXErrorDomain, code: 13, description: "Synthetic denial"))
        source.researcherNotes = "Researcher note — ünicode"
        source.experiments[0].operations[0].researcherNotes = "Evidence note"
        let bytes = try SessionJSON.encode(source)
        let decoded = try SessionJSON.decode(bytes)
        XCTAssertEqual(decoded.id, source.id)
        XCTAssertEqual(decoded.logs[0].error, source.logs[0].error)
        XCTAssertEqual(decoded.logs[0].researcherNotes, "Evidence note")
        XCTAssertEqual(decoded.environment, source.environment)
        XCTAssertEqual(decoded.researcherNotes, source.researcherNotes)
        XCTAssertLessThan(abs(decoded.startTime.timeIntervalSince(source.startTime)), 0.001)
    }
    func testJSONRejectsUnknownSchemaMalformedAndOversizedInput() throws {
        var source = session(); source.schemaVersion = 999
        XCTAssertThrowsError(try SessionJSON.decode(SessionJSON.encode(source)))
        XCTAssertThrowsError(try SessionJSON.decode(Data("broken".utf8)))
        XCTAssertThrowsError(try SessionJSON.decode(Data(repeating: 0, count: 25 * 1024 * 1024 + 1)))
    }
    func testJSONRejectsDuplicateAndMismatchedEvidenceIdentity() throws {
        var source = session()
        source.experiments[0].operations.append(source.logs[0])
        XCTAssertThrowsError(try SessionJSON.decode(SessionJSON.encode(source)))
        source = session(); source.experiments[0].operations[0].experimentID = "unrelated"
        XCTAssertThrowsError(try SessionJSON.decode(SessionJSON.encode(source)))
    }
    func testJSONRejectsSummaryContradictingEvidence() throws {
        let data = try SessionJSON.encode(session(state: .denied))
        var object = try XCTUnwrap(JSONSerialization.jsonObject(with: data) as? [String: Any])
        var runs = try XCTUnwrap(object["experiments"] as? [[String: Any]])
        runs[0]["result"] = "PASS"; object["experiments"] = runs
        XCTAssertThrowsError(try SessionJSON.decode(JSONSerialization.data(withJSONObject: object)))
    }
    func testStateAggregationDoesNotHideUnperformedOrUnexpectedOperations() {
        XCTAssertEqual(ResultState.aggregate([]), .notTested)
        XCTAssertEqual(ResultState.aggregate([.pass, .notTested]), .notTested)
        XCTAssertEqual(ResultState.aggregate([.pass, .denied]), .denied)
        XCTAssertEqual(ResultState.aggregate([.error, .needsReview]), .needsReview)
        XCTAssertEqual(ResultState.aggregate([.notSupported]), .notSupported)
    }
    func testOSStatusEvaluationDistinguishesExpectedAbsenceAndUnexpectedSuccess() {
        XCTAssertEqual(OperationEvaluation.osStatus(actual: 0), .pass)
        XCTAssertEqual(OperationEvaluation.osStatus(actual: -25300, expected: -25300), .pass)
        XCTAssertEqual(OperationEvaluation.osStatus(actual: 0, expected: -25300), .needsReview)
        XCTAssertEqual(OperationEvaluation.osStatus(actual: 0, verified: false), .needsReview)
        XCTAssertEqual(OperationEvaluation.osStatus(actual: -34018), .denied)
        XCTAssertEqual(OperationEvaluation.osStatus(actual: -25299), .error)
    }
    func testErrorClassificationDistinguishesDenialFromOperationalError() {
        XCTAssertEqual(ErrorClassifier.state(for: NSError(domain: NSCocoaErrorDomain, code: 257)), .denied)
        XCTAssertEqual(ErrorClassifier.state(for: NSError(domain: NSPOSIXErrorDomain, code: 13)), .denied)
        XCTAssertEqual(ErrorClassifier.state(for: NSError(domain: NSPOSIXErrorDomain, code: 28)), .error)
        XCTAssertEqual(ErrorClassifier.state(for: VerificationFailure("Synthetic mismatch")), .needsReview)
        XCTAssertEqual(ErrorClassifier.state(for: ResearchError(domain: NSOSStatusErrorDomain, code: -34018, description: "Missing entitlement")), .denied)
    }
    func testRecorderPreservesErrorAndFinishesRun() {
        var recorder = EvidenceRecorder(session().experiments[0].definition, environment: environment())
        let succeeded = recorder.perform("READ", resource: "/synthetic", expected: "Fixture read") {
            throw NSError(domain: NSPOSIXErrorDomain, code: 13)
        }
        XCTAssertFalse(succeeded)
        let run = recorder.finish(notes: "Synthetic")
        XCTAssertEqual(run.result, .denied); XCTAssertEqual(run.errors.first?.code, 13)
        XCTAssertNotNil(run.endTime); XCTAssertEqual(run.researchNotes, "Synthetic")
    }
    func testReportContainsRequiredSectionsAndRealRecordedValues() {
        let report = MarkdownReport.generate(session(state: .needsReview))
        for section in ["## Environment", "### Objective", "### Method", "### Expected Behavior", "### Observed Behavior", "### Evidence", "### Security Interpretation", "### Conclusion"] {
            XCTAssertTrue(report.contains(section), section)
        }
        XCTAssertTrue(report.contains("Synthetic test observation"))
        XCTAssertTrue(report.contains("NEEDS_REVIEW"))
        XCTAssertTrue(report.contains("Manually reproduce"))
        XCTAssertFalse(report.contains("vulnerability confirmed"))
    }
    func testReportEscapesUserTextAndRendersExactError() {
        var source = session(state: .error, error: ResearchError(domain: "SyntheticDomain", code: 42, description: "<bad> | failure"))
        source.researcherNotes = "# injected\n<script> [link](x) `code`"
        let report = MarkdownReport.generate(source)
        XCTAssertTrue(report.contains("Error code: 42"))
        XCTAssertTrue(report.contains("&lt;bad&gt; \\| failure"))
        XCTAssertFalse(report.contains("<script>")); XCTAssertFalse(report.contains("\n# injected"))
    }
    func testComparisonIgnoresRandomPathsAndTimestamps() {
        let before = session(); var after = before
        after.id = UUID(); after.experiments[0].operations[0].resource = "/different/random/path"
        after.experiments[0].operations[0].timestamp = Date().addingTimeInterval(42)
        after.experiments[0].operations[0].actualResult = "Different byte-count message"
        XCTAssertTrue(SessionComparison(before: before, after: after).changes.isEmpty)
    }
    func testComparisonIgnoresRandomPathsInsideErrorDescriptions() {
        func denial(_ folder: String, underlyingCode: Int = 1) -> ResearchError {
            ResearchError(domain: NSCocoaErrorDomain, code: 513,
                          description: "Synthetic: no permission to save “SandboxResearchLab-\(folder)”",
                          underlying: "Error Domain=NSPOSIXErrorDomain Code=\(underlyingCode) \"Synthetic\" UserInfo={path=/\(folder)}")
        }
        let before = session(state: .denied, error: denial(UUID().uuidString)); var after = before
        after.id = UUID(); after.experiments[0].operations[0].error = denial(UUID().uuidString)
        XCTAssertTrue(SessionComparison(before: before, after: after).changes.isEmpty)
        after.experiments[0].operations[0].error = denial(UUID().uuidString, underlyingCode: 13)
        let changed = SessionComparison(before: before, after: after)
        XCTAssertEqual(changed.changes.count, 1); XCTAssertTrue(changed.changes[0].errorChanged)
    }
    func testComparisonDetectsNewFailurePermissionAndChangedErrors() {
        let denied = session(state: .denied, error: ResearchError(domain: NSPOSIXErrorDomain, code: 13, description: "Synthetic"))
        var passed = denied; passed.id = UUID(); passed.experiments[0].operations[0].result = .pass; passed.experiments[0].operations[0].error = nil
        let allowed = SessionComparison(before: denied, after: passed)
        XCTAssertEqual(allowed.changes.count, 1)
        XCTAssertTrue(allowed.changes[0].newPermission); XCTAssertTrue(allowed.changes[0].needsReview)
        let failure = SessionComparison(before: passed, after: denied)
        XCTAssertTrue(failure.changes[0].newFailure); XCTAssertTrue(failure.changes[0].errorChanged)
    }
    func testComparisonHandlesAddedRemovedAndRepeatedOperations() {
        let before = session(); var after = before
        var extra = before.logs[0]; extra.id = UUID(); extra.result = .notTested
        after.experiments[0].operations.append(extra)
        let added = SessionComparison(before: before, after: after)
        XCTAssertEqual(added.changes.count, 1); XCTAssertNil(added.changes[0].before)
        XCTAssertEqual(SessionComparison(before: after, after: before).changes.count, 1)
    }
    func testComparisonDetectsComparableMetadataAndContext() {
        let before = session(); var after = before
        after.experiments[0].operations[0].details["compare.configuration"] = "Changed"
        after.environment.osVersion = "Other synthetic OS"
        XCTAssertEqual(SessionComparison(before: before, after: after).changes.count, 1)
        XCTAssertEqual(SessionComparison(before: before, after: after).contextDifferences, ["iOS version differs"])
    }
    func testLogFiltersCombineCategoryResultExperimentAndSearch() {
        let source = session(state: .denied)
        XCTAssertEqual(LogFilter(experimentID: "test.synthetic", category: .container, result: .denied, query: "SYNTHETIC").apply(source.logs).count, 1)
        XCTAssertTrue(LogFilter(category: .keychain).apply(source.logs).isEmpty)
    }
    func testPersistenceSaveLoadDeleteAndCorruptionIsolation() async throws {
        let directory = try temporaryDirectory(); let store = SessionStore(directory: directory)
        let source = session()
        try await store.save(source)
        try Data("invalid JSON".utf8).write(to: directory.appendingPathComponent("broken.json"))
        let loaded = try await store.load()
        XCTAssertEqual(loaded.sessions.map(\.id), [source.id]); XCTAssertEqual(loaded.warnings.count, 1)
        XCTAssertTrue(FileManager.default.fileExists(atPath: directory.appendingPathComponent("broken.json").path))
        try await store.delete(source.id)
        let empty = try await store.load(); XCTAssertTrue(empty.sessions.isEmpty)
    }
    func testPersistenceRejectsDuplicateImportsAndRecoversInterruptedSessions() async throws {
        let directory = try temporaryDirectory(); let store = SessionStore(directory: directory)
        var source = session(); source.completion = .running
        try await store.insert(source)
        do { try await store.insert(source); XCTFail("Duplicate must fail") } catch { XCTAssertTrue(error is SessionDataError) }
        let result = try await store.load(); XCTAssertEqual(result.sessions.first?.completion, .interrupted)
    }
    func testStoreReportsNonDirectoryFailure() async throws {
        let directory = try temporaryDirectory(); let file = directory.appendingPathComponent("file")
        try Data().write(to: file)
        let store = SessionStore(directory: file)
        do { try await store.save(session()); XCTFail("A regular file is not a directory") } catch { XCTAssertFalse(error.localizedDescription.isEmpty) }
    }
    func testHostFileEngineUsesOnlyIsolatedScratchDirectory() throws {
        let directory = try temporaryDirectory(); let sentinel = directory.appendingPathComponent("unrelated.txt")
        try Data("preserve".utf8).write(to: sentinel)
        let run = FileAccessExperiment.run(location: TestLocation(id: "host-fixture", name: "Host scratch directory", url: directory), environment: environment())
        XCTAssertEqual(run.result, .pass)
        XCTAssertEqual(Set(run.operations.map(\.operation)), ["DIRECTORY_CREATE", "CREATE", "READ", "WRITE", "ENUMERATE", "ATTRIBUTES", "DELETE", "CLEANUP"])
        XCTAssertEqual(try String(contentsOf: sentinel, encoding: .utf8), "preserve")
        XCTAssertEqual(try FileManager.default.contentsOfDirectory(atPath: directory.path), ["unrelated.txt"])
    }
    func testFileEnginePrerequisiteFailureProducesNotTestedOperations() throws {
        let directory = try temporaryDirectory(); let file = directory.appendingPathComponent("regular-file")
        try Data().write(to: file)
        let run = FileAccessExperiment.run(location: TestLocation(id: "host-failure", name: "Invalid host fixture", url: file), environment: environment())
        XCTAssertEqual(run.operations.filter { $0.result == .notTested }.count, 6)
        XCTAssertEqual(run.operations.first?.result, .error)
    }
    func testLaunchPersistenceRequiresDifferentLaunchAndDetectsTampering() throws {
        let directory = try temporaryDirectory(); let firstEnvironment = environment()
        let first = PersistenceExperiment.run(directory: directory, environment: firstEnvironment)
        XCTAssertEqual(first.operations.first?.result, .notTested)
        XCTAssertEqual(PersistenceExperiment.run(directory: directory, environment: firstEnvironment).operations.first?.result, .notTested)
        XCTAssertEqual(PersistenceExperiment.run(directory: directory, environment: environment()).operations.first?.result, .pass)
        try Data("modified synthetic marker".utf8).write(to: directory.appendingPathComponent("launch-marker.txt"))
        let changed = PersistenceExperiment.run(directory: directory, environment: environment())
        XCTAssertEqual(changed.result, .needsReview)
        XCTAssertFalse(changed.operations.contains { $0.operation == "ARM_BASELINE" })
    }
    func testMissingPersistentMarkerRequiresReview() throws {
        let directory = try temporaryDirectory()
        _ = PersistenceExperiment.run(directory: directory, environment: environment())
        try FileManager.default.removeItem(at: directory.appendingPathComponent("launch-marker.txt"))
        XCTAssertEqual(PersistenceExperiment.run(directory: directory, environment: environment()).result, .needsReview)
    }
    func testAttributeAndDateFormattingAreStable() {
        XCTAssertEqual(ResearchFormat.date(Date(timeIntervalSince1970: 0)), "1970-01-01T00:00:00Z")
        XCTAssertEqual(AttributeFormatter.describe([.size: 7]), "NSFileSize=7")
    }
}
