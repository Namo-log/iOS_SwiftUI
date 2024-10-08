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
    
    @ObservableState
    struct State: Equatable {
        var loginState: OnboardingLoginStore.State
        var agreementState: OnboardingTOSStore.State
        var userInfoState: OnboardingInfoInputStore.State
        
        var routes: [Route<OnboardingScreen.State>]
        
        static let initialState: State = .init(
            loginState: .init(),
            agreementState: .init(),
            userInfoState: .init(name: nil),
            routes: [.root(.login(OnboardingLoginStore.State()))] // 첫 화면은 로그인
        )
        
        static func manualState(_ routes: [Route<OnboardingScreen.State>]) -> State {
            return State(
                loginState: .init(),
                agreementState: .init(),
                userInfoState: .init(name: nil),
                routes: routes
            )
        }
    }
    
    enum Action {
        case login(OnboardingLoginStore.Action)
        case agreement(OnboardingTOSStore.Action)
        case userInfo(OnboardingInfoInputStore.Action)
        case signUpCompletion
        
        case router(IndexedRouterActionOf<OnboardingScreen>)
    }
    
    var body: some ReducerOf<Self> {
        
        Scope(state: \.loginState, action: \.login) {
            OnboardingLoginStore()
        }
        
        Scope(state: \.agreementState, action: \.agreement) {
            OnboardingTOSStore()
        }
        
        Scope(state: \.userInfoState, action: \.userInfo) {
            OnboardingInfoInputStore()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
                
            case .router(.routeAction(_, action: let action)):
                switch action {
                    
                    // 약관 동의 화면으로 이동
                case .login(.goToNextScreen):
                    print("되는건가")
                    state.routes.append(.push(.agreement(state.agreementState)))
                    return .none
                    
                    // 유저 정보 입력 화면으로 이동
                case .agreement(.goToNextScreen):
                    print("되는건가")
                    state.routes.append(.push(.userInfo(state.userInfoState)))
                    return .none
                    
                    // 회원가입 완료 화면으로 이동
                case .userInfo(.goToNextScreen):
                    print("되는건가")
                    state.routes.append(.push(.signUpCompletion))
                    return .none
                    
                default:
                    return .none
                }
                
            default:
                return .none
            }
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
