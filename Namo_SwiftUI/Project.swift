import ProjectDescription


let project = Project(
    name: "Namo_SwiftUI",
    settings: .settings(configurations: [
        .debug(name: "Debug", xcconfig: "Configurations/Namo_SwiftUI-debug.xcconfig"),
        .release(name: "Release", xcconfig: "Configurations/Namo_SwiftUI-release.xcconfig")
    ]),
    targets: [
        .target(name: "Namo_SwiftUI",
                destinations: .iOS,
                product: .app,
                bundleId: "com.mongmong.namo.test",
                sources: ["Namo_SwiftUI/Sources/**"],
                resources: ["Namo_SwiftUI/Resources/**"],
                dependencies: []
               )
    ]
)
