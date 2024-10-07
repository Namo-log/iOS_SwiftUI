//
//  SplashCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators
import SharedUtil
import FeatureOnboarding

struct SplashCoordinatorView: View {
    let store: StoreOf<SplashCoordinator>
    
    var body: some View {
        OnboardingSplashView(store: store.scope(state: \.splashState, action: \.splash))
            .onAppear {
                store.send(.loginCheck)
            }
    }
}
