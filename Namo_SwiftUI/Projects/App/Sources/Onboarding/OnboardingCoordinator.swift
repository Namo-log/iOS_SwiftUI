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

@Reducer(state: .equatable)
enum OnboardingScreen {
    case login(OnboardingLoginStore)
    case agreement(OnboardingTOSStore)
    case userInfo(OnboardingInfoInputStore)
    case signUpCompletion
}

@Reducer
struct OnboardingCoordinator {
    
    @Dependency(\.authClient) var authClient
    
    @ObservableState
    struct State: Equatable {
        
        var routes: [Route<OnboardingScreen.State>]
        // 로그인 체크 여부 플래그
        var hasPerformedLoginCheck: Bool = false
        
        static let initialState: State = .init(
            routes: [.root(.login(.init()))] // 첫 화면은 로그인
        )
        
        static func routedState(_ routes: [Route<OnboardingScreen.State>]) -> State {
            var initState = initialState
            initState.routes.append(contentsOf: routes)
            return initState
        }
    }
    
    enum Action {
        case router(IndexedRouterActionOf<OnboardingScreen>)
        
        // 로그인 체크
        case loginCheck
        // 로그인 화면
        case goToLoginScreen
        // 약관 동의 화면
        case goToAgreementScreen
        // 유저 정보 작성 화면
        case goToUserInfoScreen
        // 회원가입 완료 화면
        case goToSignUpCompletion
        // 메인 화면
        case goToMainScreen
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in
            switch action {
            
                // 화면 라우팅 from routeAction
            case .router(.routeAction(_, action: let action)):
                switch action {
                    
                    // 약관 동의 화면으로 이동
                case .login(.goToNextScreen):
                    return .send(.goToAgreementScreen)
                    
                    // 유저 정보 입력 화면으로 이동
                case .agreement(.goToNextScreen):
                    return .send(.goToUserInfoScreen)
                    
                    // 회원가입 완료 화면으로 이동
                case .userInfo(.goToNextScreen):      
                    return .send(.goToSignUpCompletion)
                    
                default:
                    return .none
                }
                
                // 로그인 체크 결과 라우팅
            case .loginCheck:
                guard !state.hasPerformedLoginCheck else { return .none }
                state.hasPerformedLoginCheck = true
                
                switch authClient.userStatusCheck() {
                    
                case .logout:
                    return .send(.goToLoginScreen)
                    // 토큰 O, 약관 X, 정보입력 X
                case .loginWithoutEverything:
                    return .send(.goToAgreementScreen)
                    // 토큰 O, 약관 X
                case .loginWithoutAgreement:
                    return .send(.goToAgreementScreen)
                    // 토큰 O, 약관 O, 정보입력 X
                case .loginWithoutUserInfo:
                    return .send(.goToUserInfoScreen)
                    // 토큰 O, 약관 O, 정보입력 O
                case .loginWithAll:
                    return .send(.goToMainScreen)
                }
                
            case .goToLoginScreen:
                state.routes.push(.login(.init()))
                return .none
                
            case .goToAgreementScreen:
                state.routes.push(.agreement(.init()))
                return .none
                
            case .goToUserInfoScreen:
                // TODO: 추후 기획 확정 시 수정
                state.routes.push(.userInfo(.init(name: nil)))
                return .none
                
            case .goToSignUpCompletion:
                state.routes.push(.signUpCompletion)
                return .none
                
            case .goToMainScreen:
                // 해당 action은 AppCoordinator에서 체크합니다
                return .none
                
            default:
                return .none
            }
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
