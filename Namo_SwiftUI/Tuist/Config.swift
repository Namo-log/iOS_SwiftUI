//
//  Config.swift
//  Config
//
//  Created by 정현우 on 8/15/24.
//

import ProjectDescription

let config = Config(
	plugins: [
		.local(path: .relativeToRoot("Plugins/DependencyPlugin")),
		.local(path: .relativeToRoot("Plugins/EnvPlugin"))
	],
	generationOptions: .options()
)

