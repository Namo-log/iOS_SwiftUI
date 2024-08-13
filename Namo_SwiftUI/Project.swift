import ProjectDescription


let project = Project(
    name: "Namo_SwiftUI",
    targets: [
        .target(name: "Namo_SwiftUI",
                destinations: .iOS,
                product: .app,
                bundleId: "",
                sources: ["Namo_SwiftUI/Sources/**"],
                resources: ["Namo_SwiftUI/Resources/**"],
                dependencies: []
               )
    ]
)
