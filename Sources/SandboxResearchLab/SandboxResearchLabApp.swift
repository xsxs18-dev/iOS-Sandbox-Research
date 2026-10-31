import SwiftUI
import UIKit

@main
struct SandboxResearchLabApp: App {
    @StateObject private var store = LabStore()
    var body: some Scene {
        WindowGroup {
            RootView().environmentObject(store)
                .task { await store.load() }
                .onOpenURL { url in Task { await store.receive(url) } }
                .onContinueUserActivity(NSUserActivityTypeBrowsingWeb) { activity in
                    Task { await store.observeUniversalLink(activity) }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.protectedDataWillBecomeUnavailableNotification)) { _ in
                    Task { await store.sampleMonitor("protectedDataWillBecomeUnavailable delivered") }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.protectedDataDidBecomeAvailableNotification)) { _ in
                    Task { await store.sampleMonitor("protectedDataDidBecomeAvailable delivered") }
                }
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                    Task { await store.sampleMonitor("didBecomeActive delivered") }
                }
        }
    }
}
