//
//  Project.swift
//  AppManifests
//
//  Created by 권석기 on 9/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .feature(
        interface: .Onboarding,
        factory: .init(
            dependencies: [
                .domain
            ]
        )
    ),
    .feature(
        implements: .Onboarding,
        factory: .init(
            dependencies: [
                .feature(interface: .Onboarding)
            ]
        )
    ),
    .feature(
        testing: .Onboarding,
        factory: .init(
            dependencies: [
                .feature(interface: .Onboarding)
            ]
        )
    ),
    .feature(
        tests: .Onboarding,
        factory: .init(
            dependencies: [
                .feature(testing: .Onboarding)
            ]
        )
    ),
    .feature(
        example: .Onboarding,
        factory: .init(
            infoPlist: .exampleAppDefault,
            dependencies: [
                .feature(interface: .Onboarding),
                .feature(implements: .Onboarding)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.Onboarding.rawValue,
    targets: targets
)


