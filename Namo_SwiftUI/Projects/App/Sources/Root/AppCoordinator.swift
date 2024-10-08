//
//  AppCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

@Reducer(state: .equatable)
enum AppScreen {
    // 메인탭
    case mainTab(MainTabCoordinator)
    // 온보딩
    case onboarding(OnboardingCoordinator)
    // 스플래시
    case splash(SplashCoordinator)
}

@Reducer
struct AppCoordinator {
    
    @ObservableState
    struct State {
        static let initialState = State(routes: [.root(.splash(.initialState), embedInNavigationView: true)],
                                        mainTab: .intialState,
                                        splash: .initialState,
                                        onboarding: .initialState)
        var routes: [Route<AppScreen.State>]
        var mainTab: MainTabCoordinator.State
        var splash: SplashCoordinator.State
        var onboarding: OnboardingCoordinator.State
    }
    
    enum Action {
        case router(IndexedRouterActionOf<AppScreen>)
        case mainTab(MainTabCoordinator.Action)
        case onboarding(OnboardingCoordinator.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.mainTab, action: \.mainTab) {
            MainTabCoordinator()
        }
        Scope(state: \.onboarding, action: \.onboarding) {
            OnboardingCoordinator()
        }
        
        Reduce<State, Action> { state, action in

            switch action {
                
            // Splash - 로그인 체크 결과 화면 라우팅
            case .router(.routeAction(_, action: .splash(let action))):
                switch action {

                case .goToLoginScreen:
                    state.routes = [.root(.onboarding(OnboardingCoordinator.State.initialState))]
                        
                case .goToAgreementScreen:
                    state.routes = [
                        .root(.onboarding(.manualState([
                            .root(.login(.init()), embedInNavigationView: true),
                            .push(.agreement(.init()))
                        ])))
                    ]
                    
                case .goToUserInfoScreen:
                    state.routes = [
                        .root(.onboarding(.manualState([
                            .root(.login(.init()), embedInNavigationView: true),
                            .push(.userInfo(.init(name: nil)))
                        ])))
                    ]
                    
                case .goToMainScreen:
                    state.routes = [.root(.mainTab(.init(home: .initialState, moim: .initialState)), embedInNavigationView: true)]
                    
                default:
                    break
                }
                
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}


