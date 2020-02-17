// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Falcon",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "Falcon",
            targets: ["Falcon"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.9.0"),
        .package(url: "https://github.com/SwiftGL/OpenGL.git", from: "3.0.0"),
        .package(url: "https://github.com/SwiftGL/Math.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .systemLibrary(
            name: "GLFW",
            pkgConfig: "glfw3",
            providers: [.brew(["glfw3"])]),
        .target(
            name: "Falcon",
            dependencies: ["HeliumLogger", "SGLOpenGL", "SGLMath", "GLFW"]),
        .testTarget(
            name: "FalconTests",
            dependencies: ["Falcon"]),
    ]
)
