// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Launchly",
    platforms: [
        .iOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6)
    ],
    products: [
        .library(
            name: "Launchly",
            targets: ["Launchly"]),
    ],
    dependencies: [
        .package(name: "LaunchDarkly", url: "https://github.com/launchdarkly/ios-client-sdk.git", .upToNextMinor(from: "5.1.0"))
    ],
    targets: [
        .target(
            name: "Launchly",
            dependencies: ["LaunchDarkly"])
    ]
)
