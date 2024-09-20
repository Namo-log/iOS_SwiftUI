//
//  SplashCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct SplashCoordinatorView: View {
    let store: StoreOf<SplashCoordinator>
    
    var body: some View {
        Text("Splash")
            .onAppear {
                store.send(.loginCheck(isSuccess: false))
            }
    }
}
