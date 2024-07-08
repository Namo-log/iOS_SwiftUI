import ProjectDescription

let dependencies = Dependencies(
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(
                url: "https://github.com/Alamofire/Alamofire.git",
                requirement: .exact("5.9.1")
            ),
            .remote(
                url: "https://github.com/onevcat/Kingfisher.git",
                requirement: .exact("7.11.0")
            ),
            .remote(
                url: "https://github.com/hmlongco/Factory.git",
                requirement: .exact("2.3.1")
            ),
            .remote(
                url: "https://github.com/realm/realm-swift.git",
                requirement: .exact("master")
            ),
            .remote(
                url: "https://github.com/airbnb/lottie-ios.git",
                requirement: .exact("4.4.3")
            ),
            .remote(
                url: "https://github.com/GGJJack/SwiftUICalendar.git",
                requirement: .exact("0.1.14")
            ),
            .remote(
                url: "https://github.com/kyungkoo/naveridlogin-ios-sp.git",
                requirement: .exact("4.1.5")
            ),
            .remote(
                url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM.git",
                requirement: .exact("2.10.4")
            ),
            .remote(
                url: "https://github.com/kakao/kakao-partner-ios-sdk.git",
                requirement: .exact("2.22.1")
            ),
            .remote(
                url: "https://github.com/firebase/firebase-ios-sdk.git",
                requirement: .exact("10.27.0")
            )
        ]
    ),
    platforms: [.iOS]
)
