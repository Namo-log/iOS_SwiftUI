//
//  OnBoardingCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import FeatureOnboarding

struct OnboardingCoordinatorView: View {
    let store: StoreOf<OnboardingCoordinator>
    
    var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
                
            case let .login(store):
                OnboardingLoginView(store: store)
            case let .agreement(store):
                OnboardingTOSView(store: store)
            case let .userInfo(store):
                OnboardingInfoInputView(store: store)
            case .signUpCompletion:
                OnboardingCompleteView()
            }
        }
        .onAppear {
            store.send(.loginCheck)
        }
    }
}
