//
//  Project.swift
//  Config
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.core(
		interface: .Network,
		factory: .init(
			dependencies: [
				.shared
			]
		)
	),
	.core(
		implements: .Network,
		factory: .init(
			dependencies: [
				.core(interface: .Network)
			]
		)
	),
	.core(
		tests: .Network,
		factory: .init(
			dependencies: [
				.core(testing: .Network)
			]
		)
	),
	.core(
		testing: .Network,
		factory: .init(
			dependencies: [
				.core(interface: .Network)
			]
		)
	),
]

let project: Project = .makeModule(
	name: ModulePath.Core.name+ModulePath.Core.Network.rawValue,
	targets: targets
)
