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

/// 유저의 현재 상태를 분류합니다
enum UserStatus {
    /// 로그인 X
    case logout
    /// 로그인 + 추가 정보 미입력
    case loginWithoutEverything
    /// 로그인, 약관동의 정보 필요
    case loginWithoutAgreement
    /// 로그인, 유저 정보 필요
    case loginWithoutUserInfo
    /// 로그인 + 모든 정보 입력
    case loginWithAll
}

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
                
                switch userStatusCheck() {
                    
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
    /// 유저의 현재 상태를 파악합니다
    func userStatusCheck() -> UserStatus {
        // 로그인 상태 확인
        guard let _ = authClient.getLoginState() else { return .logout }
        // 약관 동의 여부 nil 체크
        guard let agreementCompleted = authClient.getAgreementCompletedState() else { return .loginWithoutAgreement }
        // 유저 정보 작성 여부 nil 체크
        guard let userInfoCompleted = authClient.getUserInfoCompletedState() else { return .loginWithoutUserInfo }
        // 필요 정보 작성 여부 체크
        guard agreementCompleted && userInfoCompleted else { return .loginWithoutEverything }
        
        return .loginWithAll
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
