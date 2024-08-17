//
//  Dependency+Project.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

public extension TargetDependency {
	struct Features {
		
	}
	
	static let thirdPartyLibs = TargetDependency.project(target: "ThirdPartyLibs", path: .relativeToRoot("Projects/ThirdPartyLibs"))
}
