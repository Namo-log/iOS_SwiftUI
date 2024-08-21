//
//  TargetFactory.swift
//  ProjectDescriptionHelpers
//
//  Created by 정현우 on 8/20/24.
//

import ProjectDescription
import DependencyPlugin

// MARK: Target + Template

public struct TargetFactory {
	var name: String
	var destination: Set<Destination>
	var product: Product
	var productName: String?
	var bundleId: String?
	var infoPlist: InfoPlist?
	var sources: SourceFilesList?
	var resources: ResourceFileElements?
	var entitlements: Entitlements?
	var scripts: [TargetScript]
	var dependencies: [TargetDependency]
	var settings: Settings?
	
	public init(
		name: String = "",
		destination: Set<Destination> = [.iPhone],
		product: Product = .staticLibrary,
		productName: String? = nil,
		bundleId: String? = nil,
		infoPlist: InfoPlist? = .default,
		sources: SourceFilesList? = .sources,
		resources: ResourceFileElements? = nil,
		entitlements: Entitlements? = nil,
		scripts: [TargetScript] = [],
		dependencies: [TargetDependency] = [],
		settings: Settings? = nil
	) {
		self.name = name
		self.destination = destination
		self.product = product
		self.productName = productName
		self.bundleId = bundleId
		self.infoPlist = infoPlist
		self.sources = sources
		self.resources = resources
		self.entitlements = entitlements
		self.scripts = scripts
		self.dependencies = dependencies
		self.settings = settings
	}
}
