import Foundation

public enum MarkdownReport {
    public static func generate(_ session: ResearchSession) -> String {
        let e = session.environment
        let escape = ResearchFormat.markdown
        var lines = ["# iOS Sandbox Research Report", "", "## Environment", "",
                     "- iOS Version: \(escape(e.osVersion))",
                     "- Device: \(escape(e.deviceModel))",
                     "- Runtime: \(e.simulator ? "Simulator — not device sandbox evidence" : "Device")",
                     "- Application: \(escape(e.application)) \(escape(e.appVersion)) (\(escape(e.build)))",
                     "- Bundle ID: \(escape(e.bundleID))", "- Research Session: \(session.id)",
                     "- Date: \(ResearchFormat.date(session.startTime))",
                     "- End: \(session.endTime.map(ResearchFormat.date) ?? "Not recorded")",
                     "- Completion: \(session.completion.rawValue)",
                     "- Protected data available at session start: \(e.protectedDataAvailable.map(String.init) ?? "Unavailable")",
                     "- Launch ID (random, per process): \(e.launchID)", "",
                     "Results describe only the recorded operations. DENIED is not a vulnerability. PASS means the stated expectation was verified. No cross-app private data was tested.", "",
                     "## Researcher notes", "", escape(session.researcherNotes.isEmpty ? "No researcher notes recorded." : session.researcherNotes), ""]
        for run in session.experiments {
            lines += ["## Experiment: \(escape(run.definition.name))", "",
                      "- ID: \(escape(run.definition.id))", "- Category: \(run.definition.category.rawValue)",
                      "- Result: **\(run.result.rawValue)**", "- Start: \(ResearchFormat.date(run.startTime))",
                      "- End: \(run.endTime.map(ResearchFormat.date) ?? "Not recorded")", "",
                      "### Objective", "", escape(run.definition.objective), "",
                      "### Method", "", escape(run.definition.method), "",
                      "### Expected Behavior", "", escape(run.definition.expectedBehavior), "",
                      "### Observed Behavior", ""]
            if run.operations.isEmpty { lines += ["No operations were recorded.", ""] }
            for evidence in run.operations {
                lines += ["- \(escape(evidence.operation)): **\(evidence.result.rawValue)** — \(escape(evidence.actualResult))"]
            }
            lines += ["", "### Evidence", ""]
            for evidence in run.operations {
                lines += ["#### \(escape(evidence.operation)) · \(evidence.id)", "",
                          "- Timestamp: \(ResearchFormat.date(evidence.timestamp))",
                          "- Resource: \(escape(evidence.resource))",
                          "- Expected: \(escape(evidence.expectedResult))",
                          "- Actual: \(escape(evidence.actualResult))",
                          "- State: \(evidence.result.rawValue)",
                          "- Environment: \(escape(evidence.environment.osVersion)); \(escape(evidence.environment.deviceModel)); protected data: \(evidence.environment.protectedDataAvailable.map(String.init) ?? "Unavailable")"]
                if let error = evidence.error {
                    lines += ["- Error domain: \(escape(error.domain))", "- Error code: \(error.code)",
                              "- Error description: \(escape(error.description))"]
                    if let underlying = error.underlying { lines.append("- Underlying error: \(escape(underlying))") }
                }
                for key in evidence.details.keys.sorted() { lines.append("- \(escape(key)): \(escape(evidence.details[key] ?? ""))") }
                if !evidence.researcherNotes.isEmpty { lines.append("- Researcher note: \(escape(evidence.researcherNotes))") }
                lines.append("")
            }
            lines += ["### Security Interpretation", "", interpretation(run.result), "",
                      "### Conclusion", "", conclusion(run.result), "",
                      "### Research Notes", "", escape(run.researchNotes.isEmpty ? "No additional notes." : run.researchNotes), ""]
        }
        lines += ["## Limitations", "",
                  "This report is generated from local evidence, not a security attestation. Configuration is not proof of signed entitlement grants. Lock-state, relaunch, signing and external link behavior require the documented manual checks. Imported sessions and researcher notes are not independently authenticated.", ""]
        return lines.joined(separator: "\n")
    }
    public static func interpretation(_ state: ResultState) -> String {
        switch state {
        case .pass: return "The recorded operation met its stated expectation within the tested environment. This does not prove broader sandbox security."
        case .denied: return "Access was refused. This may be normal enforcement, a protection state, or signing configuration. A denial is not a vulnerability."
        case .error: return "An operational error prevented a clean result. Inspect the exact error and prerequisites before drawing a security conclusion."
        case .notSupported: return "The capability or configuration was unavailable. No enforcement conclusion can be drawn."
        case .notTested: return "Evidence is incomplete or requires manual interaction/a later launch. No success is claimed for the untested operation."
        case .needsReview: return "Observed behavior differed from the stated expectation. Manually reproduce and validate it; this tool does not label vulnerabilities."
        }
    }
    private static func conclusion(_ state: ResultState) -> String {
        state == .needsReview ? "NEEDS_REVIEW: preserve evidence, repeat on hardware, rule out configuration and lifecycle effects, then consider responsible disclosure." : "Recorded state: \(state.rawValue). Interpret the individual evidence and limitations above."
    }
}
