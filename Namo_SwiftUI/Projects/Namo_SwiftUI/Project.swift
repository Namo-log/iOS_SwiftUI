import ProjectDescription
import DependencyPlugin

let project = Project(
	name: "Namo_SwiftUI",
	settings: .settings(configurations: [
		.debug(name: "Debug", xcconfig: "./xcconfigs/Namo_SwiftUI.xcconfig"),
		.release(name: "Release", xcconfig: "./xcconfigs/Namo_SwiftUI.xcconfig")
	]),
	targets: [
		.target(name: "Namo_SwiftUI",
				destinations: [.iPhone],
				product: .app,
				bundleId: "com.mongmong.namo",
				infoPlist: .file(path: "Resources/Namo-SwiftUI-Info.plist"),
				sources: ["Sources/**"],
				resources: ["Resources/**"],
				entitlements: .file(path: "Resources/Namo_SwiftUI.entitlements"),
				dependencies: [
					.SPM.Kingfisher,
					.SPM.Factory,
					.SPM.Alamofire,
					.SPM.Lottie,
					.SPM.SwiftUICalendar,
					.SPM.Naveridlogin,
					.SPM.KakaoMapsSDK_SPM,
					.SPM.KakaoSDK,
					.SPM.FirebaseDatabase,
					.SPM.FirebaseCrashlytics,
					.SPM.FirebaseDynamicLinks,
					.SPM.FirebaseMessaging,
					.SPM.FirebasePerformance,
					.SPM.FirebaseRemoteConfig,
					.SPM.FirebaseAnalytics,
					.SPM.ComposableArchitecture,
				]
			   )
	]
)
