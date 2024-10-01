//
//  Project.swift
//  Manifests
//
//  Created by 정현우 on 9/18/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.domain(
		interface: .Schedule,
		factory: .init(
			dependencies: [
				.core
			]
		)
	),
	.domain(
		implements: .Schedule,
		factory: .init(
			dependencies: [
				.domain(interface: .Schedule)
			]
		)
	),
	.domain(
		testing: .Schedule,
		factory: .init(
			dependencies: [
				.domain(interface: .Schedule)
			]
		)
	),
	.domain(
		tests: .Schedule,
		factory: .init(
			dependencies: [
				.domain(testing: .Schedule)
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Domain.name+ModulePath.Domain.Schedule.rawValue,
	targets: targets
)

