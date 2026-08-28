// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-effect-equation",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Effect Equation",
            targets: ["Effect Equation"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-atoms/swift-effect.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-atoms/swift-equation.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Effect Equation",
            dependencies: [
                .product(name: "Effect", package: "swift-effect"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
        .testTarget(
            name: "Effect Equation Tests",
            dependencies: [
                .target(name: "Effect Equation"),
                .product(name: "Effect", package: "swift-effect"),
                .product(name: "Equation Protocol", package: "swift-equation"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
