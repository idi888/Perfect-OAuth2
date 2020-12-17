// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import Foundation

#if os(Linux)
let isLinux = true
#else
let isLinux = false
#endif
if isLinux {

let username = ProcessInfo.processInfo.environment["GITHUBNAME"] ?? ""
let password =  ProcessInfo.processInfo.environment["GITHUBSECRET"] ?? ""


let package = Package(
    name: "OAuth2",
    platforms: [ .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "OAuth2", targets: ["OAuth2"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0"),
//        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0-beta"),
        .package(url: "https://\(username):\(password)@github.com/adirburke/GoogleCloudKit.git", .branch("master")),
        .package(url: "https://github.com/GottaGetSwifty/CodableWrappers.git", .upToNextMajor(from: "1.1.0" )),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OAuth2",
            dependencies: [ .product(name: "AsyncHTTPClient", package: "async-http-client"),
                            .product(name: "GoogleCloudCore", package: "google-cloud-kit"),
                            "CodableWrappers"]
        ),
        .testTarget(
            name: "Perfect-OAuth2Tests",
            dependencies: ["OAuth2"]),
    ]
)
} else {
  let package = Package(
    name: "OAuth2",
    platforms: [ .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(name: "OAuth2", targets: ["OAuth2"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.0.0"),
//        .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/adirburke/google-cloud-kit.git", .branch("master")),
        .package(url: "https://github.com/GottaGetSwifty/CodableWrappers.git", .upToNextMajor(from: "1.1.0" )),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "OAuth2",
            dependencies: [ .product(name: "AsyncHTTPClient", package: "async-http-client"),
                            .product(name: "GoogleCloudCore", package: "google-cloud-kit"),
                            "CodableWrappers"]
        ),
        .testTarget(
            name: "Perfect-OAuth2Tests",
            dependencies: ["OAuth2"]),
    ]
)  
}
