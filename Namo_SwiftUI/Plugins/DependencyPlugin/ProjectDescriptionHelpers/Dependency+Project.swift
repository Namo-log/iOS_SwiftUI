//
//  Dependency+Project.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

public extension TargetDependency {
	struct Features {
		public static let base = TargetDependency.Features.makeFeature("Base")
		public struct Theme {}
	}
	
	struct Core {
		public static let common = TargetDependency.project(
			target: "Common",
			path: .relativeToCore("Common")
		)
		
		public static let thirdPartyLibs = TargetDependency.project(
			target: "ThirdPartyLibs",
			path: .relativeToCore("ThirdPartyLibs")
		)
		
		public static let networks = TargetDependency.project(
			target: "Networks",
			path: .relativeToCore("Networks")
		)
		
		public static let testCore = TargetDependency.project(
			target: "TestCore",
			path: .relativeToCore("TestCore")
		)
		
		public static let uiComponent = TargetDependency.project(
			target: "UIComponent",
			path: .relativeToCore("UIComponent")
		)
	}
	
	
}

public extension TargetDependency.Features {
	static func makeFeature(_ name: String) -> TargetDependency {
		return TargetDependency.project(target: "\(name)Feature", path: .relativeToFeature("\(name)Feature"))
	}
	
	static func makeInterface(_ name: String) -> TargetDependency {
		return TargetDependency.project(target: "\(name)Interface", path: .relativeToFeature("\(name)Feature"))
	}
}

public extension TargetDependency.Features.Theme {
	static let group = "Theme"
	
	static let Feature = TargetDependency.Features.makeFeature(group)
	static let Interface = TargetDependency.Features.makeInterface(group)
}
