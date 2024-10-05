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

struct OnBoardingCoordinatorView: View {
    let store: StoreOf<OnBoardingCoordinator>
    
    var body: some View {
        OnboardingLoginView(store: store.scope(state: \.onBoarding, action: \.onboarding))
    }
}
