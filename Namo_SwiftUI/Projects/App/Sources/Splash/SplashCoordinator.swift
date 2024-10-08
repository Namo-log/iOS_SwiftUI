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
import FeatureOnboarding


@Reducer
struct SplashCoordinator {
    @Dependency(\.authClient) var authClient
    
    struct State: Equatable {
        var splashState: OnboardingSplashStore.State
        static let initialState: State = .init(splashState: OnboardingSplashStore.State())
    }
    
    enum Action {
        // 로그인 체크
        case loginCheck
        // 로그인 화면
        case goToLoginScreen
        // 약관 동의 화면
        case goToAgreementScreen
        // 유저 정보 작성 화면
        case goToUserInfoScreen
        // 메인 화면
        case goToMainScreen
        // splash Store Action
        case splash(OnboardingSplashStore.Action)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.splashState, action: \.splash) {
            OnboardingSplashStore()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
            case .loginCheck:
                
                switch authClient.userStatusCheck() {
                    
                case .logout:
                    return .send(.goToLoginScreen)
                case .loginWithoutEverything:
                    return .send(.goToAgreementScreen)
                case .loginWithoutAgreement:
                    return .send(.goToAgreementScreen)
                case .loginWithoutUserInfo:
                    return .send(.goToUserInfoScreen)
                case .loginWithAll:
                    return .send(.goToMainScreen)
                }
                
            default:
                return .none
            }
        }
    }
}

//                if authClient.getLoginState() != nil {
//                    return .send(.goToMainScreen)
//                } else {
//                    return .send(.goToOnboardingScreen)
//                }
                
//                로그아웃은 임시로 해당 주석을 풀어서 사용해주세요
//                return .run { send in
//                    await authClient.setLogoutState(with: .apple)
//                    await send(.goToOnboardingScreen)
//                }
