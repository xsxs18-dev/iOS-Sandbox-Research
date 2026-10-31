// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "SandboxResearchLab",
    platforms: [.iOS(.v17)],
    products: [.library(name: "SandboxResearchLab", targets: ["SandboxResearchLab"])],
    dependencies: [.package(path: "Core")],
    targets: [.target(name: "SandboxResearchLab", dependencies: [.product(name: "ResearchCore", package: "Core")],
                      swiftSettings: [.enableExperimentalFeature("StrictConcurrency")])],
    swiftLanguageModes: [.v5]
)
