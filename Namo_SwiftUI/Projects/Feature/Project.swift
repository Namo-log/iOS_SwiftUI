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
	.feature(
		factory: .init(
			dependencies: [
				.domain,
				.feature(implements: .Friend)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Feature.name,
	targets: targets
)
