import SwiftUI
import ResearchCore

struct ManualLabView: View {
    @EnvironmentObject private var store: LabStore
    @State private var protection: ProtectionClass = .complete
    var body: some View {
        List {
            Section("Choose a protection class") {
                Picker("Protection", selection: $protection) {
                    ForEach(ProtectionClass.allCases) { Text($0.title).tag($0) }
                }
                Text(protection.explanation).font(.footnote).foregroundStyle(.secondary)
                Button("Create, inspect, read & delete test file") { Task { await store.runOne(protection.definition) } }.disabled(store.busy)
            }
            Section("Observe lock / unlock") {
                Text("Arm while unlocked, lock the phone, wait briefly, unlock and return. Samples are collected only when iOS delivers events and allows execution. A missing locked sample is not evidence of access or denial.").font(.footnote)
                if store.isMonitoring {
                    Label("Observation armed", systemImage: "record.circle").foregroundStyle(.orange)
                    Button("Sample now") { Task { await store.sampleMonitor("Researcher requested sample") } }
                    Button("Stop & save observation") { Task { await store.stopMonitor() } }
                } else {
                    Button("Arm lock-state observation") { Task { await store.armMonitor() } }.disabled(store.busy)
                }
            }
            Section("Persistence across launches") {
                Text("Run the suite once to establish a baseline. Terminate the app using the app switcher, relaunch it, then run the persistence experiment or the suite again. Do not reinstall between measurements.").font(.footnote)
                Button("Check / arm persistence baseline") { Task { await store.runOne(PersistenceExperiment.definition) } }.disabled(store.busy)
            }
            Section("User-mediated communication") {
                Button { Task { await store.openOwnURL() } } label: { Label("Open own URL scheme", systemImage: "link") }.disabled(store.busy)
                Button { Task { await store.shareDocument() } } label: { Label("Share lab document", systemImage: "doc.badge.arrow.up") }.disabled(store.busy)
                Text("The share sheet lets you select an installed app or extension. Its completion callback cannot prove how the destination stored the document.").font(.footnote).foregroundStyle(.secondary)
            }
            Section("Universal links & extensions") {
                Text("Universal links need your own associated domain, signed entitlement and AASA file. After setup, a matching HTTPS activity delivered to this app is recorded with only its hostname. No URL query or personal payload is retained.").font(.footnote)
                Text("This app does not bundle a receiving share extension. It exercises public, user-selected sharing and authorized App Group file access. Cross-process exchange is not inferred from either.").font(.footnote)
                NavigationLink("View configuration and setup") { ConfigurationView() }
            }
            if let current = store.current {
                Section { NavigationLink("View latest evidence") { SessionDetailView(sessionID: current.id, fallback: current) } }
            }
        }.navigationTitle("Manual Lab")
    }
}
