// swift-tools-version:5.5

import PackageDescription

struct PackageMetadata {
    static let version: String = "4.8.4"
    static let checksum: String = "c9c3a794e8585198b59c6bb7da5418a3194ffa1ffa6f9a1cbdf4dc0ea26dc6cf"
}

let package = Package(
    name: "GoogleCast",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "GoogleCast",
            type: .static,
            targets: ["GoogleCast"]
        )
    ],
    targets: [
        .binaryTarget(
            name: "GoogleCast",
            url: "https://github.com/BookBeat/GoogleCastSDK-ios-no-bluetooth/releases/download/\(PackageMetadata.version)/GoogleCast.xcframework.zip",
            checksum: PackageMetadata.checksum
        )
    ]
)
