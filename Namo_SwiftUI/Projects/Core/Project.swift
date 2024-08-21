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
	.core(
		factory: .init(
			dependencies: [
				.shared,
				.core(implements: .Network),
			]
		)
	)
]


let project: Project = .makeModule(
	name: ModulePath.Core.name,
	targets: targets
)
