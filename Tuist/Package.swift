// swift-tools-version: 6.0
import PackageDescription

#if TUIST
    import struct ProjectDescription.PackageSettings

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,]
        productTypes: [
            "YouTubePlayerKit": .framework,
            "ComposableArchitecture": .framework
        ]
    )
#endif

let package = Package(
    name: "PuHaHang",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.19.1"),
        .package(url: "https://github.com/SvenTiigi/YouTubePlayerKit.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/LURKS02/MiniFire", .upToNextMajor(from: "1.0.3")),
        .package(url: "https://github.com/airbnb/lottie-spm.git", from: "4.5.2"),
        .package(url: "https://github.com/firebase/firebase-ios-sdk.git", .upToNextMajor(from: "11.15.0"))
    ]
)
