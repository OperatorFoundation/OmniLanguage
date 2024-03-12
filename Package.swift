// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "OmniLanguage",
    defaultLocalization: "eo",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "OmniLanguage",
            targets: ["OmniLanguage"]),
        .library(
            name: "OmniCompiler",
            targets: ["OmniCompiler"]),
    ],
    dependencies: [
        .package(url: "https://github.com/blanu/Blueprint", branch: "main"),
        .package(url: "https://github.com/blanu/Daydream", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Ghostwriter", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Number", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Text", branch: "main"),
        .package(url: "https://github.com/OperatorFoundation/Time", branch: "main"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "OmniLanguage",
            dependencies: [
                "Daydream",
                "Ghostwriter",
                "Number",
                "Text",
                "Time",
            ]
        ),
        .target(
            name: "OmniCompiler",
            dependencies: [
                "Blueprint",
                "OmniLanguage",
                "Text",
                "Time"
            ]
        ),
        .testTarget(
            name: "OmniLanguageTests",
            dependencies: [
                "OmniCompiler",
                "OmniLanguage"
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
