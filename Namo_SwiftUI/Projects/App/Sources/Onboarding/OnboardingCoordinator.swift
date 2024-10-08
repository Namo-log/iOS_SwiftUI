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
        
        var routes: [Route<OnboardingScreen.State>]
        
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
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in
            switch action {
                
            case .router(.routeAction(_, action: let action)):
                switch action {
                    
                    // 약관 동의 화면으로 이동
                case .login(.goToNextScreen):
                    state.routes.push(.agreement(.init()))
                    return .none
                    
                    // 유저 정보 입력 화면으로 이동
                case .agreement(.goToNextScreen):
                    // TODO: 추후 기획 확정 시 수정
                    state.routes.push(.userInfo(.init(name: nil)))
                    return .none
                    
                    // 회원가입 완료 화면으로 이동
                case .userInfo(.goToNextScreen):      
                    state.routes.push(.signUpCompletion)
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
