//
//  Project.swift
//  AppManifests
//
//  Created by 정현우 on 8/21/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.shared(
		factory: .init(
			dependencies: [
				.shared(implements: .DesignSystem),
				.shared(implements: .ThirdPartyLib),
				.shared(implements: .Util)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Shared.name,
	targets: targets
)
