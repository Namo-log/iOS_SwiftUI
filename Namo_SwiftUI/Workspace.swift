//
//  Workspace.swift
//  Config
//
//  Created by 정현우 on 8/15/24.
//

import ProjectDescription
import DependencyPlugin

let workspace = Workspace(
	name: Project.Environment.appName,
	projects: ["Projects/**"]
)
