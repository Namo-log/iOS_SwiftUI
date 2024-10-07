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
        static let initialState = State(routes: [.root(.splash(.init()), embedInNavigationView: true)],
                                        mainTab: .intialState,
                                        splash: .init(),
                                        onboarding: OnboardingCoordinator.State.initialState)
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
            case .router(.routeAction(_, action: .onboarding(.login(.namoAppleLoginResponse(_))))):
                state.routes = [.root(.mainTab(.init(home: .initialState, moim: .initialState)), embedInNavigationView: true)]
            case .router(.routeAction(_, action: .splash(.goToOnboardingScreen))):
                state.routes = [.root(.onboarding(OnboardingCoordinator.State.initialState), embedInNavigationView: true)]
            case .router(.routeAction(_, action: .splash(.goToMainScreen))):
                state.routes = [.root(.mainTab(.init(home: .initialState, moim: .initialState)), embedInNavigationView: true)]
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}


