//
//  Project.swift
//  Config
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
	name: "ThirdPartyLibs",
	targets: [.staticFramework],
	externalDependencies: [
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
