//
//  feature.swift
//  Manifests
//
//  Created by 정현우 on 9/30/24.
//

import ProjectDescription

private let nameAttribute = Template.Attribute.required("name")

private let template = Template(
	description: "Example Template",
	attributes: [
		nameAttribute,
	],
	items: [
		.file(
			path: "Projects/Feature/\(nameAttribute)/Project.swift",
			templatePath: "../stencil/featureProject.stencil"
		),
		.file(
			path: "Projects/Feature/\(nameAttribute)/Sources/Feature\(nameAttribute)SourcesTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Feature/\(nameAttribute)/Interface/Sources/Feature\(nameAttribute)InterfaceTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Feature/\(nameAttribute)/Testing/Sources/Feature\(nameAttribute)TestingTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Feature/\(nameAttribute)/Tests/Sources/Feature\(nameAttribute)TestsTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Feature/\(nameAttribute)/Example/Sources/Feature\(nameAttribute)ExampleTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		
	]
)
