//
//  Project+Templates.swift
//  Config
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription
import DependencyPlugin

public extension Project {
	static func makeModule(name: String, targets: [Target]) -> Self {
		let name: String = name
		let organizationName: String? = nil
		let options: Project.Options = .options()
		let packages: [Package] = []
		let settings: Settings? = nil
		let targets: [Target] = targets
		let schemes: [Scheme] = []
		
		return .init(
			name: name,
			organizationName: organizationName,
			options: options,
			packages: packages,
			settings: settings,
			targets: targets,
			schemes: schemes
		)
	}
}
