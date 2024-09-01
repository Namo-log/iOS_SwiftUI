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
	.domain(
		interface: .Category,
		factory: .init(
			dependencies: [
				.core
			]
		)
	),
	.domain(
		implements: .Category,
		factory: .init(
			dependencies: [
				.domain(interface: .Category)
			]
		)
	),
	.domain(
		testing: .Category,
		factory: .init(
			dependencies: [
				.domain(interface: .Category)
			]
		)
	),
	.domain(
		tests: .Category,
		factory: .init(
			dependencies: [
				.domain(testing: .Category)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Domain.name+ModulePath.Domain.Category.rawValue,
	targets: targets
)

