//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정현우 on 8/21/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin
import ConfigPlugin

let targets: [Target] = [
	.app(
		implements: .IOS,
		factory: .init(
			infoPlist: .file(path: "Resources/Namo-SwiftUI-Info.plist"),
			entitlements: .file(path: "Resources/Namo_SwiftUI.entitlements"),
			dependencies: [
				.feature
			],
			settings: .settings(configurations: XCConfig.path)
		)
	)
]

let project: Project = .makeModule(
	name: "Namo_SwiftUI",
	targets: targets
)
