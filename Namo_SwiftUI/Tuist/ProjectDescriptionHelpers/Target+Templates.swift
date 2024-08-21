//
//  Target+Templates.swift
//  ProjectDescriptionHelpers
//
//  Created by 정현우 on 8/21/24.
//

import ProjectDescription
import DependencyPlugin

public extension Target {
	private static func make(factory: TargetFactory) -> Self {
		return .target(
			name: factory.name,
			destinations: factory.destination,
			product: factory.product,
			bundleId: factory.bundleId ?? Project.Environment.bundlePrefix + ".\(factory.name)",
			deploymentTargets: Project.Environment.deploymentTarget,
			infoPlist: factory.infoPlist,
			sources: factory.sources,
			resources: factory.resources,
			entitlements: factory.entitlements,
			scripts: factory.scripts,
			dependencies: factory.dependencies,
			settings: factory.settings
		)
	}
}

// MARK: Target + App

public extension Target {
	static func app(implements module: ModulePath.App, factory: TargetFactory) -> Self {
		var newFactory = factory
		
		switch module {
		case .IOS:
			newFactory.destination = [.iPhone]
			newFactory.product = .app
			newFactory.name = Project.Environment.appName
			newFactory.bundleId = Project.Environment.bundlePrefix
			newFactory.resources = ["Resources/**"]
		}
		return make(factory: newFactory)
	}
}


// MARK: Target + Feature

public extension Target {
	static func feature(factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name
		
		return make(factory: newFactory)
	}
	
	static func feature(implements module: ModulePath.Feature, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name + module.rawValue
		
		return make(factory: newFactory)
	}
	
	static func feature(tests module: ModulePath.Feature, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name + module.rawValue + "Tests"
		newFactory.sources = .tests
		newFactory.product = .unitTests
		
		return make(factory: newFactory)
	}
	
	static func feature(testing module: ModulePath.Feature, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name + module.rawValue + "Testing"
		newFactory.sources = .testing
		
		return make(factory: newFactory)
	}
	
	static func feature(interface module: ModulePath.Feature, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name + module.rawValue + "Interface"
		newFactory.sources = .interface
		
		return make(factory: newFactory)
	}
	
	static func feature(example module: ModulePath.Feature, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Feature.name + module.rawValue + "Example"
		newFactory.sources = .exampleSources
		newFactory.product = .app
		
		return make(factory: newFactory)
	}
}

// MARK: Target + Domain

public extension Target {
	static func domain(factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Domain.name
		
		return make(factory: newFactory)
	}
	
	static func domain(implements module: ModulePath.Domain, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Domain.name + module.rawValue
		
		return make(factory: newFactory)
	}
	
	static func domain(tests module: ModulePath.Domain, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Domain.name + module.rawValue + "Tests"
		newFactory.product = .unitTests
		newFactory.sources = .tests
		
		return make(factory: newFactory)
	}
	
	static func domain(testing module: ModulePath.Domain, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Domain.name + module.rawValue + "Testing"
		newFactory.sources = .testing
		
		return make(factory: newFactory)
	}
	
	static func domain(interface module: ModulePath.Domain, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Domain.name + module.rawValue + "Interface"
		newFactory.sources = .interface
		
		return make(factory: newFactory)
	}
}

// MARK: Target + Core

public extension Target {
	static func core(factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Core.name
		
		return make(factory: newFactory)
	}
	
	static func core(implements module: ModulePath.Core, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Core.name + module.rawValue
		
		return make(factory: newFactory)
	}
	
	static func core(tests module: ModulePath.Core, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Core.name + module.rawValue + "Tests"
		newFactory.product = .unitTests
		newFactory.sources = .tests
		
		return make(factory: newFactory)
	}
	
	static func core(testing module: ModulePath.Core, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Core.name + module.rawValue + "Testing"
		newFactory.sources = .testing
		
		return make(factory: newFactory)
	}
	
	static func core(interface module: ModulePath.Core, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Core.name + module.rawValue + "Interface"
		newFactory.sources = .interface
		
		return make(factory: newFactory)
	}
}

// MARK: Target + Shared

public extension Target {
	static func shared(factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Shared.name
//		newFactory.product = .staticFramework
		
		return make(factory: newFactory)
	}
	
	static func shared(implements module: ModulePath.Shared, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Shared.name + module.rawValue
		
		if module == .DesignSystem {
			newFactory.sources = .sources
			newFactory.resources = ["Resources/**"]
//			newFactory.product = .staticFramework
		} else if module == .ThirdPartyLib {
			newFactory.product = .staticFramework
		}
		
		return make(factory: newFactory)
	}
	
	static func shared(interface module: ModulePath.Shared, factory: TargetFactory) -> Self {
		var newFactory = factory
		newFactory.name = ModulePath.Shared.name + module.rawValue + "Interface"
		newFactory.sources = .interface
		
		return make(factory: newFactory)
	}
}

