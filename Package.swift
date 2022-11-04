// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "Sample",
    targets: [
        .executableTarget(name: "Sample"),
        .target(name: "_CSample"),
    ]
)
