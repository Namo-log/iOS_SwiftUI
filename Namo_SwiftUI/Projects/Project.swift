import ProjectDescription


let project = Project(
    name: "Namo_SwiftUI",
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "Configurations/Namo_SwiftUI-debug.xcconfig"),
        .release(name: "Release", xcconfig: "Configurations/Namo_SwiftUI-release.xcconfig")
    ]),
    targets: [
        .target(name: "NamoApp",
                destinations: [.iPhone],
                product: .app,
                bundleId: "com.mongmong.namo.test",
                sources: ["Sources/**"],
                resources: ["Resources/**"],
                dependencies: [
                    .external(name: "Kingfisher"),
                    .external(name: "Factory"),
                    .external(name: "Alamofire"),
                    .external(name: "Lottie"),
                    .external(name: "SwiftUICalendar"),
                    .external(name: "naveridlogin-ios-sp"),
                    .external(name: "KakaoMapsSDK-SPM"),
                    .external(name: "KakaoSDK"),
                    .external(name: "FirebaseDatabase"),
                    .external(name: "FirebaseCrashlytics"),
                    .external(name: "FirebaseDynamicLinks"),
                    .external(name: "FirebaseMessaging"),
                    .external(name: "FirebasePerformance"),
                    .external(name: "FirebaseRemoteConfig"),
                    .external(name: "FirebaseAnalytics"),
                ]
               )
    ]
)
