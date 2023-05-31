// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GoogleCastSDK-ios-no-bluetooth",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(
            name: "GoogleCast",
            targets: ["GoogleCast"]),
    ],
    targets: [
         .binaryTarget(
            name: "GoogleCast",
            path: "GoogleCast.xcframework"
        )
    ]
)
