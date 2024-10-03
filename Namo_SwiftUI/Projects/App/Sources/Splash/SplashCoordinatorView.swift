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

struct SplashCoordinatorView: View {
    let store: StoreOf<SplashCoordinator>
    
    var body: some View {
        Text("Splash 임시")
            .onAppear {
                store.send(.loginCheck)
//                KeyChainManager.deleteItem(key: "accessToken")
//                KeyChainManager.deleteItem(key: "refreshToken")
            }
    }
}
