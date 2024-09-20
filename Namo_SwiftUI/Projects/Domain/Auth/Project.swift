//
//  Project.swift
//  AppManifests
//
//  Created by 박민서 on 9/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.domain(
		interface: .Auth,
		factory: .init(
			dependencies: [
				.core
			]
		)
	),
	.domain(
		implements: .Auth,
		factory: .init(
			dependencies: [
				.domain(interface: .Auth)
			]
		)
	),
	.domain(
		testing: .Auth,
		factory: .init(
			dependencies: [
				.domain(interface: .Auth)
			]
		)
	),
	.domain(
		tests: .Auth,
		factory: .init(
			dependencies: [
				.domain(testing: .Auth)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Domain.name+ModulePath.Domain.Auth.rawValue,
	targets: targets
)

