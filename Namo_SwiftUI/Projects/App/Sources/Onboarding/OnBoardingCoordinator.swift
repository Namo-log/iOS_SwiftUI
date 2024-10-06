//
//  OnBoardingCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import FeatureOnboarding
import SharedUtil

@Reducer
struct OnBoardingCoordinator {
    struct State: Equatable {
        var onBoarding: OnboardingLoginStore.State
    }
    
    enum Action {
        case onboarding(OnboardingLoginStore.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.onBoarding, action: \.onboarding) {
            OnboardingLoginStore()
        }
        
        Reduce<State, Action> { state, action in
            switch action {       
            default:
                return .none
            }
        }
    }
}
