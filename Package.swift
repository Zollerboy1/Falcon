// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Falcon",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Falcon",
            targets: ["Falcon"]),
        .executable(
            name: "Sandbox",
            targets: ["Sandbox"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.9.0"),
        .package(url: "https://github.com/Zollerboy1/glad.git", from: "1.0.0"),
        .package(url: "https://github.com/Zollerboy1/GLFW.git", from: "1.0.0"),
        .package(url: "https://github.com/Zollerboy1/ImGui.git", from: "1.0.0"),
        .package(name: "SGLMath", url: "https://github.com/Zollerboy1/Math.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "Falcon",
            dependencies: ["HeliumLogger", "GLFW", "glad", "ImGui", "SGLMath"]),
        .target(
            name: "Sandbox",
            dependencies: ["Falcon"]),
        .testTarget(
            name: "FalconTests",
            dependencies: ["Falcon"]),
    ],
    cLanguageStandard: .c11,
    cxxLanguageStandard: .cxx11
)
