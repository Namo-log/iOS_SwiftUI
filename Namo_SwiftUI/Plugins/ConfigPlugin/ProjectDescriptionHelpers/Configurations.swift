//
//  Configurations.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

// TODO: 각 target에 따른 별도의 xcconfig 사용?(framework, test, demo 등)
public struct XCConfig {	
	public static let path: [Configuration] = [
        .debug(name: "Debug", xcconfig: .relativeToRoot("xcconfigs/Namo_SwiftUI-debug.xcconfig")),
		.release(name: "Release", xcconfig: .relativeToRoot("xcconfigs/Namo_SwiftUI-release.xcconfig"))
	]
}
