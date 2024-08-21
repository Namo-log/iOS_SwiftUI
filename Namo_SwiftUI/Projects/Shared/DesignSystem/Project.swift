//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 정현우 on 8/21/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
	.shared(
		implements: .DesignSystem,
		factory: .init(
			dependencies: [
				
			]
		)
	)
]

let project: Project = .makeModule(
	name: ModulePath.Shared.name+ModulePath.Shared.DesignSystem.rawValue,
	targets: targets
)
