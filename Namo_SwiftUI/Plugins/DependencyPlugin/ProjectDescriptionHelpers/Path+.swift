//
//  Path+.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

public extension ProjectDescription.Path {
	static func relativeToFeature(_ path: String) -> Self {
		return .relativeToRoot("Projects/Features/\(path)")
	}
	
	static func relativeToCore(_ path: String) -> Self {
		return .relativeToRoot("Projects/Core/\(path)")
	}
}
