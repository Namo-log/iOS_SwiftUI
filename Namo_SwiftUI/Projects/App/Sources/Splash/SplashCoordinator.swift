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
    @Dependency(\.authClient) var authClient
    
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
                if authClient.getLoginState() != nil {
					try! KeyChainManager.addItem(key: "accessToken", value: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsInJlZ0RhdGUiOjE3MjgxOTE3NDExMzh9.eyJpZCI6IjE0IiwiZXhwIjoxNzI4MjM0OTQxfQ.gbvfL012Yz9Muu0qhxC4Zk7BHWg6hzBI7Xnu51H5jEY")
                    return .send(.goToMainScreen)
                } else {
                    return .send(.goToOnboardingScreen)
                }
                
//                로그아웃은 임시로 해당 주석을 풀어서 사용해주세요
//                return .run { send in
//                    await authClient.setLogoutState(with: .apple)
//                    await send(.goToOnboardingScreen)
//                }
            default:
                return .none
            }
        }
    }
}
