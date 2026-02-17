// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "FloatingHebrewClock",
    platforms: [
        .macOS(.v13)
    ],
    products: [
        .executable(name: "FloatingHebrewClock", targets: ["FloatingHebrewClock"])
    ],
    targets: [
        .executableTarget(
            name: "FloatingHebrewClock",
            path: "Sources/FloatingHebrewClock"
        )
    ]
)
