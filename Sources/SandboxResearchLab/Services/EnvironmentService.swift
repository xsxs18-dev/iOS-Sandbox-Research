import Foundation
import UIKit
import ResearchCore

@MainActor
enum EnvironmentService {
    static let launchID = UUID()
    static func capture() -> EnvironmentSnapshot {
        let bundle = Bundle.main
        #if targetEnvironment(simulator)
        let simulator = true
        #else
        let simulator = false
        #endif
        var system = utsname(); uname(&system)
        let model = withUnsafeBytes(of: &system.machine) { bytes in
            String(decoding: bytes.prefix { $0 != 0 }, as: UTF8.self)
        }
        return EnvironmentSnapshot(osVersion: "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion) (\(ProcessInfo.processInfo.operatingSystemVersionString))",
                                   deviceModel: model, application: "SandboxResearchLab", bundleID: bundle.bundleIdentifier ?? "Unavailable",
                                   appVersion: bundle.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "Unavailable",
                                   build: bundle.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "Unavailable",
                                   simulator: simulator, protectedDataAvailable: UIApplication.shared.isProtectedDataAvailable, launchID: launchID)
    }
}

enum LabPaths {
    static func locations() -> [TestLocation] {
        let fm = FileManager.default
        var result = [TestLocation(id: "home", name: "App Home", url: URL(fileURLWithPath: NSHomeDirectory(), isDirectory: true))]
        for (id, name, directory): (String, String, FileManager.SearchPathDirectory) in [
            ("documents", "Documents", .documentDirectory), ("library", "Library", .libraryDirectory),
            ("caches", "Library/Caches", .cachesDirectory), ("support", "Application Support", .applicationSupportDirectory)
        ] {
            if let url = fm.urls(for: directory, in: .userDomainMask).first { result.append(TestLocation(id: id, name: name, url: url)) }
        }
        result.append(TestLocation(id: "temporary", name: "tmp", url: fm.temporaryDirectory))
        return result
    }
    static var support: URL {
        // NSHomeDirectory is always available; this fallback still stays inside our own container.
        (FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first ??
         URL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Library/Application Support"))
            .appendingPathComponent("SandboxResearchLab", isDirectory: true)
    }
}
