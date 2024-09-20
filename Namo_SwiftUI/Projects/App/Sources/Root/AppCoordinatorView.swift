//
//  AppCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct AppCoordinatorView: View {
    let store: StoreOf<AppCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .mainTab(store2):
                MainTabCoordinatorView(store: store.scope(state: \.mainTab, action: \.mainTab))
            case let .onBoarding(store):
                OnBoardingCoordinatorView(store: store)
            case let .splash(store):
                SplashCoordinatorView(store: store)
            }
        }
    }
}

