import ProjectDescription

let projectName = "Namo_SwiftUI"
let bundleID = "com.mongmong.namo"
let targetVersion = "16.0"

// MARK: Struct
let project = Project(
  name: projectName,
  settings: baseSettings(),
  targets: [
    Target(name: "Namo_SwiftUI",
           platform: .iOS,
           product: .app,
           bundleId: bundleID,
           deploymentTarget: .iOS(targetVersion: targetVersion, devices: [.iphone, .ipad]),
           infoPlist: "Namo_SwiftUI-info.plist",
           sources: ["\(projectName)/**"],
           resources: getResources(),
           // entitlements: "Namo_SwiftUI.entitlements",
           scripts: [
            .FirebaseCrashlyticsString
           ],
           dependencies: defaultDependency(),
           settings: prodSettings()
          )
  ]
)

private func defaultDependency() -> [TargetDependency] {
    return [
     .external(name: "Alamofire"),
     .external(name: "Kingfisher"),
     .external(name: "Factory"),
     .external(name: "Realm"),
     .external(name: "Lottie"),
     .external(name: "SwiftUICalendar"),
     .external(name: "naveridlogin-ios-sp"),
     .external(name: "KakaoMapsSDK-SPM"),
     .external(name: "KakaoOpenSDK"),
     .external(name: "Firebase")
    ]
}
