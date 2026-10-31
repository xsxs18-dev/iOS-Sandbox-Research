import Foundation

public struct SessionLoadResult: Sendable {
    public let sessions: [ResearchSession]
    public let warnings: [String]
}

/// Serializes reads/writes. Atomic replacement prevents half-written JSON; malformed files are retained.
public actor SessionStore {
    private let directory: URL
    public init(directory: URL) { self.directory = directory }
    private func prepare() throws { try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true) }
    private func url(_ id: UUID) -> URL { directory.appendingPathComponent(id.uuidString).appendingPathExtension("json") }
    public func save(_ session: ResearchSession) throws {
        try prepare()
        try SessionJSON.encode(session).write(to: url(session.id), options: .atomic)
    }
    public func insert(_ session: ResearchSession) throws {
        try prepare()
        guard !FileManager.default.fileExists(atPath: url(session.id).path) else { throw SessionDataError.duplicate }
        try SessionJSON.encode(session).write(to: url(session.id), options: .withoutOverwriting)
    }
    public func load() throws -> SessionLoadResult {
        try prepare()
        var sessions: [ResearchSession] = []; var warnings: [String] = []
        for file in try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            .filter({ $0.pathExtension == "json" }) {
            do {
                var session = try SessionJSON.decode(Data(contentsOf: file))
                guard file.deletingPathExtension().lastPathComponent == session.id.uuidString else { throw SessionDataError.invalidIdentity }
                if session.completion == .running { session.completion = .interrupted }
                sessions.append(session)
            } catch { warnings.append("\(file.lastPathComponent): \(error.localizedDescription)") }
        }
        return SessionLoadResult(sessions: sessions.sorted { $0.startTime > $1.startTime }, warnings: warnings)
    }
    public func delete(_ id: UUID) throws { try FileManager.default.removeItem(at: url(id)) }
}
