// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "DisplayHarbor",
    platforms: [.macOS(.v14)],
    products: [
        .executable(name: "DisplayHarbor", targets: ["DisplayHarbor"])
    ],
    targets: [
        .executableTarget(name: "DisplayHarbor", path: "Sources/DisplayHarbor")
    ]
)
