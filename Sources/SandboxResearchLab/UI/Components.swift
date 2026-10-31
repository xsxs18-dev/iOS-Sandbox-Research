import SwiftUI
import UIKit
import ResearchCore

extension ResultState {
    var tint: Color {
        switch self {
        case .pass: return .green
        case .denied: return .orange
        case .error: return .red
        case .needsReview: return .purple
        case .notSupported, .notTested: return .secondary
        }
    }
    var symbol: String {
        switch self {
        case .pass: return "checkmark.circle.fill"
        case .denied: return "lock.circle.fill"
        case .error: return "exclamationmark.circle.fill"
        case .needsReview: return "eye.circle.fill"
        case .notSupported: return "minus.circle"
        case .notTested: return "clock"
        }
    }
}

struct StateBadge: View {
    let state: ResultState
    var compact = false
    var body: some View {
        Label(compact ? "" : state.rawValue, systemImage: state.symbol)
            .font(.caption.weight(.semibold)).foregroundStyle(state.tint)
            .padding(.horizontal, 8).padding(.vertical, 5)
            .background(state.tint.opacity(0.12), in: Capsule())
            .accessibilityLabel(state.rawValue)
    }
}

struct DetailValue: View {
    let title: String
    let value: String
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.subheadline).textSelection(.enabled)
        }.padding(.vertical, 3)
    }
}

struct ShareSheet: UIViewControllerRepresentable {
    let artifact: ShareArtifact
    let completion: (String?, Bool, Error?) -> Void
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: artifact.urls, applicationActivities: nil)
        controller.completionWithItemsHandler = { type, completed, _, error in completion(type?.rawValue, completed, error) }
        return controller
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
}

struct EnvironmentView: View {
    let environment: EnvironmentSnapshot
    var body: some View {
        DetailValue(title: "Operating system", value: environment.osVersion)
        DetailValue(title: "Hardware model", value: environment.deviceModel)
        DetailValue(title: "Application", value: "\(environment.appVersion) (\(environment.build)) · \(environment.bundleID)")
        DetailValue(title: "Runtime", value: environment.simulator ? "Simulator — not physical-device evidence" : "Physical device")
        DetailValue(title: "Protected data at capture", value: environment.protectedDataAvailable.map { $0 ? "Available" : "Unavailable" } ?? "Unavailable")
    }
}
