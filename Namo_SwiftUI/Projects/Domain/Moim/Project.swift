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
    .domain(
        interface: .Moim,
        factory: .init(
            dependencies: [
                .core
            ]
        )
    ),
    .domain(
        implements: .Moim,
        factory: .init(
            dependencies: [
                .domain(interface: .Moim)
            ]
        )
    ),
    .domain(
        testing: .Moim,
        factory: .init(
            dependencies: [
                .domain(interface: .Moim)
            ]
        )
    ),
    .domain(
        tests: .Moim,
        factory: .init(
            dependencies: [
                .domain(testing: .Moim)
            ]
        )
    )
]

let project: Project = .makeModule(
    name: ModulePath.Domain.name+ModulePath.Domain.Moim.rawValue,
    targets: targets
)


