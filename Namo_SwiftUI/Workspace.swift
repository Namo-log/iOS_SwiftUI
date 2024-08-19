//
//  Workspace.swift
//  Config
//
//  Created by 정현우 on 8/15/24.
//

import ProjectDescription
import EnvPlugin

let workspace = Workspace(
	name: Environment.workspaceName,
	projects: ["Projects/**"]
)
