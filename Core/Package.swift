// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "ResearchCore",
    platforms: [.iOS(.v17), .macOS(.v13)],
    products: [.library(name: "ResearchCore", targets: ["ResearchCore"])],
    targets: [.target(name: "ResearchCore", swiftSettings: [.enableExperimentalFeature("StrictConcurrency")]),
              .testTarget(name: "ResearchCoreTests", dependencies: ["ResearchCore"])],
    swiftLanguageModes: [.v5]
)
