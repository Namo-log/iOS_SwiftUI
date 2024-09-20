//
//  RootApp.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import TCACoordinators
import ComposableArchitecture

@main
struct RootApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppCoordinatorView(store: Store(initialState: .initialState, reducer: {
                AppCoordinator()
            }))
        }
    }
}
