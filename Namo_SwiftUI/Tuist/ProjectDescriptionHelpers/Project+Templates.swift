//
//  Project+Templates.swift
//  Config
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription
import EnvPlugin
import ConfigPlugin

public extension Project {
	static func makeModule(
		name: String,
		targets: Set<FeatureTarget>,
		internalDependencies: [TargetDependency] = [],  // 모듈간 의존성
		externalDependencies: [TargetDependency] = [],  // 외부 라이브러리 의존성
		frameworkHasResources: Bool = true  // target이 framework인 경우 Resource 포함 여부
	) -> Project {
		
		var projectTargets: [Target] = []
		let baseSettings: SettingsDictionary = .baseSettings
		let destination = Environment.destination
		
		// MARK: - App
		
		if targets.contains(.app) {
			
			let target = Target.target(
				name: name,
				destinations: destination,
				product: .app,
				bundleId: "\(Environment.bundlePrefix)",
				infoPlist: .file(path: "Resources/Namo-SwiftUI-Info.plist"),
				sources: ["Sources/**"],
				resources: ["Resources/**"],
				entitlements: .file(path: "Resources/Namo_SwiftUI.entitlements"),
				dependencies: [
					internalDependencies,
					externalDependencies
				].flatMap { $0 },
				settings: .settings(base: baseSettings, configurations: XCConfig.path)
			)
			
			projectTargets.append(target)
		}
		
		if targets.contains(.interface) {
			let target = Target.target(
				name: "\(name)Interface",
				destinations: destination,
				product: .staticFramework,
				bundleId: "\(Environment.bundlePrefix).\(name)Interface",
				sources: ["Interface/Sources/**"],
				dependencies: [
					internalDependencies,
					externalDependencies
				].flatMap { $0 },
				settings: .settings(base: baseSettings, configurations: XCConfig.path)
			)
			
			projectTargets.append(target)
		}
		
		// MARK: - Framework
		// TODO: static vs dynamic
		if targets.contains(.staticFramework) {
			let target = Target.target(
				name: name,
				destinations: destination,
				product: .staticFramework,
				bundleId: "\(Environment.bundlePrefix).\(name)",
				sources: name == "ThirdPartyLibs" ? [] : ["Sources/**"],
				resources: frameworkHasResources ? ["Resources/**"] : [],
				dependencies: [
					internalDependencies,
					externalDependencies
				].flatMap { $0 },
				settings: .settings(base: baseSettings, configurations: XCConfig.path)
			)
			
			projectTargets.append(target)
		}
		
		// MARK: - Unit Tests
		if targets.contains(.unitTest) {
			let deps: [TargetDependency] = [.target(name: name)]
			
			let target = Target.target(
				name: "\(name)Tests",
				destinations: destination,
				product: .unitTests,
				bundleId: "\(Environment.bundlePrefix).\(name)Tests",
				sources: ["Tests/Sources/**"],
				resources: ["Tests/Resources/**"],
				dependencies: [
					deps
				].flatMap { $0 },
				settings: .settings(base: baseSettings, configurations: XCConfig.path)
			)
			
			projectTargets.append(target)
		}
		
		return Project(
			name: name,
			targets: projectTargets
		)
	}
}
