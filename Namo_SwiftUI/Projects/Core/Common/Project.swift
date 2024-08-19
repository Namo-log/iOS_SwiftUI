//
//  Project.swift
//  Config
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
	name: "Common",
	targets: [.staticFramework],
	internalDependencies: [
		.Core.thirdPartyLibs
	],
	frameworkHasResources: true
)
