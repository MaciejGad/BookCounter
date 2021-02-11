// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "BookCounter",
    platforms: [
        .macOS(.v10_15),
    ],
    dependencies: [],
    targets: [
        .target(name: "BookCounter", dependencies: [], path: "." )
    ]
)
