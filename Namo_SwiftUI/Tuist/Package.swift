// swift-tools-version: 5.9
//  Package.swift
//  Config
//
//  Created by 정현우 on 8/15/24.
//

import PackageDescription

#if TUIST
	import ProjectDescription

	let packageSettings = PackageSettings(
		// Customize the product types for specific package product
		// Default is .staticFramework
		// productTypes: ["Alamofire": .framework,]
		productTypes: ["Kingfisher" : .framework]
	)
#endif

let package = Package(
	name: "Namo_SwiftUI",
	dependencies: [
		// Add your own dependencies here:
		// .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
		// You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
		.package(url: "https://github.com/Alamofire/Alamofire", .upToNextMajor(from: "5.8.1")),
		.package(url: "https://github.com/hmlongco/Factory", .upToNextMajor(from: "2.3.1")),
		.package(url: "https://github.com/onevcat/Kingfisher", .upToNextMajor(from: "7.10.2")),
		.package(url: "https://github.com/airbnb/lottie-ios", .upToNextMajor(from: "4.3.4")),
		.package(url: "https://github.com/GGJJack/SwiftUICalendar", .upToNextMajor(from: "0.1.14")),
		.package(url: "https://github.com/kyungkoo/naveridlogin-ios-sp", .upToNextMajor(from: "4.1.5")),
		.package(url: "https://github.com/kakao-mapsSDK/KakaoMapsSDK-SPM", .upToNextMajor(from: "2.6.3")),
		.package(url: "https://github.com/kakao/kakao-ios-sdk", .upToNextMajor(from: "2.20.0")),
		.package(url: "https://github.com/firebase/firebase-ios-sdk", .upToNextMajor(from: "11.0.0")),
	]
)
