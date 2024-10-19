//
//  AppCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import Combine

struct AppCoordinatorView: View {
    let store: StoreOf<AppCoordinator>
    @State private var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .mainTab(store):
                MainTabCoordinatorView(store: store)
            case let .onboarding(store):
                OnboardingCoordinatorView(store: store)
            }
        }
        .onAppear {
            NotificationCenter.default.publisher(for: .refreshTokenExpired)
                .sink { _ in store.send(.refreshTokenExpired) }
                .store(in: &cancellables)
        }
    }
}
