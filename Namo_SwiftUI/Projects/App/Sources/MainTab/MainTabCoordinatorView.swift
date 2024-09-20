//
//  MainTabCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import Feature

struct MainTabCoordinatorView: View {
    let store: StoreOf<MainTabCoordinator>
    
    var body: some View {
        WithPerceptionTracking {
            TabView {
                // TabCoordinator에서 받아온 CoordinatorReducer
                MoimCoordinatorView(store: store.scope(state: \.moim, action: \.moim))
                    .tabItem { Text("모임") }
            }
        }
    }
}

