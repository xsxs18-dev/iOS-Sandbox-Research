import Foundation
import ResearchCore

// reportgen report IN.json OUT.md   – validate a device session and render it with the app's MarkdownReport
// reportgen compare A.json B.json   – print the app's SessionComparison of two sessions as Markdown
let args = CommandLine.arguments
func load(_ path: String) throws -> ResearchSession {
    try SessionJSON.decode(Data(contentsOf: URL(fileURLWithPath: path)))
}
switch args.count > 1 ? args[1] : "" {
case "report" where args.count == 4:
    let session = try load(args[2])
    try Data(MarkdownReport.generate(session).utf8).write(to: URL(fileURLWithPath: args[3]))
case "compare" where args.count == 4:
    let a = try load(args[2]), b = try load(args[3])
    let c = SessionComparison(before: a, after: b)
    print("- A: \(a.id) · \(ResearchFormat.date(a.startTime))")
    print("- B: \(b.id) · \(ResearchFormat.date(b.startTime))")
    print("- Context differences: \(c.contextDifferences.isEmpty ? "none" : c.contextDifferences.joined(separator: "; "))")
    print("- Changed operations: \(c.changes.count)")
    for change in c.changes {
        let before = change.before?.result.rawValue ?? "absent", after = change.after?.result.rawValue ?? "absent"
        var flags: [String] = []
        if change.newFailure { flags.append("new failure") }
        if change.newPermission { flags.append("newly allowed") }
        if change.needsReview { flags.append("needs review") }
        if change.errorChanged { flags.append("error changed") }
        print("  - `\(change.experimentID)` / `\(change.operation)`: \(before) → \(after)\(flags.isEmpty ? "" : " (\(flags.joined(separator: ", ")))")")
    }
default:
    FileHandle.standardError.write(Data("usage: reportgen report IN OUT | compare A B\n".utf8)); exit(2)
}
