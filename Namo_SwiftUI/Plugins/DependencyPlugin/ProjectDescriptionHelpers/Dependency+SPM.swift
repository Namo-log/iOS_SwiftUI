//
//  Dependency+SPM.swift
//  EnvPlugin
//
//  Created by 정현우 on 8/15/24.
//

import ProjectDescription

public extension TargetDependency {
	struct SPM {}
}

public extension TargetDependency.SPM {
	static let Kingfisher = TargetDependency.external(name: "Kingfisher")
	static let Factory = TargetDependency.external(name: "Factory")
	static let Alamofire = TargetDependency.external(name: "Alamofire")
	static let Lottie = TargetDependency.external(name: "Lottie")
	static let SwiftUICalendar = TargetDependency.external(name: "SwiftUICalendar")
	static let Naveridlogin = TargetDependency.external(name: "naveridlogin-ios-sp")
	static let KakaoMapsSDK_SPM = TargetDependency.external(name: "KakaoMapsSDK-SPM")
	static let KakaoSDK = TargetDependency.external(name: "KakaoSDK")
	static let FirebaseDatabase = TargetDependency.external(name: "FirebaseDatabase")
	static let FirebaseCrashlytics = TargetDependency.external(name: "FirebaseCrashlytics")
	static let FirebaseDynamicLinks = TargetDependency.external(name: "FirebaseDynamicLinks")
	static let FirebaseMessaging = TargetDependency.external(name: "FirebaseMessaging")
	static let FirebasePerformance = TargetDependency.external(name: "FirebasePerformance")
	static let FirebaseRemoteConfig = TargetDependency.external(name: "FirebaseRemoteConfig")
	static let FirebaseAnalytics = TargetDependency.external(name: "FirebaseAnalytics")
	static let ComposableArchitecture = TargetDependency.external(name: "ComposableArchitecture")
	static let TCACoordinators = TargetDependency.external(name: "TCACoordinators")
}
