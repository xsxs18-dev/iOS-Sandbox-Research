import Foundation

public enum ResearchFormat {
    public static func date(_ date: Date) -> String {
        ISO8601DateFormatter().string(from: date)
    }
    public static func markdown(_ value: String) -> String {
        value.replacingOccurrences(of: "\\", with: "\\\\")
            .replacingOccurrences(of: "|", with: "\\|")
            .replacingOccurrences(of: "`", with: "\\`")
            .replacingOccurrences(of: "<", with: "&lt;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "*", with: "\\*")
            .replacingOccurrences(of: "_", with: "\\_")
            .replacingOccurrences(of: "[", with: "\\[")
            .replacingOccurrences(of: "]", with: "\\]")
            .replacingOccurrences(of: "#", with: "\\#")
            .replacingOccurrences(of: "\r", with: "")
            .replacingOccurrences(of: "\n", with: "<br>")
    }
}

public enum SessionJSON {
    public static func encode(_ session: ResearchSession) throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        encoder.dateEncodingStrategy = .millisecondsSince1970
        return try encoder.encode(session)
    }
    public static func decode(_ data: Data) throws -> ResearchSession {
        guard data.count <= 25 * 1024 * 1024 else { throw SessionDataError.tooLarge }
        let decoder = JSONDecoder(); decoder.dateDecodingStrategy = .millisecondsSince1970
        let session = try decoder.decode(ResearchSession.self, from: data)
        guard session.schemaVersion == 1 else { throw SessionDataError.unsupportedSchema(session.schemaVersion) }
        guard Set(session.experiments.map(\.id)).count == session.experiments.count,
              Set(session.experiments.map { $0.definition.id }).count == session.experiments.count,
              Set(session.logs.map(\.id)).count == session.logs.count,
              session.experiments.allSatisfy({ run in run.operations.allSatisfy {
                  $0.experimentID == run.definition.id && $0.category == run.definition.category
              } }) else { throw SessionDataError.invalidIdentity }
        return session
    }
}

public enum SessionDataError: LocalizedError {
    case unsupportedSchema(Int), tooLarge, invalidIdentity, duplicate, missing
    public var errorDescription: String? {
        switch self {
        case .unsupportedSchema(let version): return "Unsupported session schema \(version). Expected 1."
        case .tooLarge: return "Session exceeds the 25 MiB import limit."
        case .invalidIdentity: return "Session contains duplicated or inconsistent evidence identifiers."
        case .duplicate: return "A session with this identifier already exists. Existing evidence was preserved."
        case .missing: return "The requested session no longer exists."
        }
    }
}
