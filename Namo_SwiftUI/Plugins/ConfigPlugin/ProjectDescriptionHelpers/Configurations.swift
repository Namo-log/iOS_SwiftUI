//
//  Configurations.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

// TODO: 각 target에 따른 별도의 xcconfig 사용?(framework, test, demo 등)
public struct XCConfig {
	private struct Path {
		static var path: ProjectDescription.Path {
			.relativeToRoot("xcconfigs/Namo_SwiftUI.xcconfig")
		}
	}
	
	public static let path: [Configuration] = [
		.debug(name: "Debug", xcconfig: Path.path),
		.release(name: "Release", xcconfig: Path.path)
	]
}
