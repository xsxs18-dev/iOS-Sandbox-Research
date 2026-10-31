// swift-tools-version: 6.0
import PackageDescription
let package = Package(
    name: "reportgen",
    dependencies: [.package(path: "../../Core")],
    targets: [.executableTarget(name: "reportgen", dependencies: [.product(name: "ResearchCore", package: "Core")])]
)
