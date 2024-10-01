//
//  SplashCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import SharedUtil

@Reducer
struct SplashCoordinator {
    struct State: Equatable {
        var isLogin: Bool = false        
    }
    
    enum Action {
        case loginCheck
        case goToOnboardingScreen
        case goToMainScreen
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
            case .loginCheck:
                if KeyChainManager.readItem(key: "accessToken") != nil,
                   KeyChainManager.readItem(key: "refreshToken") != nil {
                    return .send(.goToMainScreen)
                } else {
                    return .send(.goToOnboardingScreen)
                }
            default:
                return .none
            }
        }
    }
}
