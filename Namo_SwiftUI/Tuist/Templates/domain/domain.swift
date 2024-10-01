//
//  domain.swift
//  Manifests
//
//  Created by 정현우 on 10/1/24.
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
			path: "Projects/Domain/\(nameAttribute)/Project.swift",
			templatePath: "../stencil/domainProject.stencil"
		),
		.file(
			path: "Projects/Domain/\(nameAttribute)/Sources/Domain\(nameAttribute)SourcesTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Domain/\(nameAttribute)/Interface/Sources/Domain\(nameAttribute)InterfaceTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Domain/\(nameAttribute)/Testing/Sources/Domain\(nameAttribute)TestingTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		.file(
			path: "Projects/Domain/\(nameAttribute)/Tests/Sources/Domain\(nameAttribute)TestsTemplate.swift",
			templatePath: "../stencil/emptyFile.stencil"
		),
		
	]
)
