//
//  Project.swift
//  AppManifests
//
//  Created by 정현우 on 9/1/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.feature(
		interface: .Category,
		factory: .init(
			dependencies: [
				.domain
			]
		)
	),
	.feature(
		implements: .Category,
		factory: .init(
			dependencies: [
				.feature(interface: .Category)
			]
		)
	),
	.feature(
		testing: .Category,
		factory: .init(
			dependencies: [
				.feature(interface: .Category)
			]
		)
	),
	.feature(
		tests: .Category,
		factory: .init(
			dependencies: [
				.feature(testing: .Category)
			]
		)
	),
	.feature(
		example: .Category,
		factory: .init(
			infoPlist: .exampleAppDefault,
			dependencies: [
				.feature(interface: .Category),
				.feature(implements: .Category)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Feature.name+ModulePath.Feature.Category.rawValue,
	targets: targets
)

