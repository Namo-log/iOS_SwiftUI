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
    case onBoarding(OnBoardingCoordinator)
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
                                        onBoarding: .init(onBoarding: .init()))
        var routes: [Route<AppScreen.State>]
        var mainTab: MainTabCoordinator.State
        var splash: SplashCoordinator.State
        var onBoarding: OnBoardingCoordinator.State
    }
    
    enum Action {
        case router(IndexedRouterActionOf<AppScreen>)
        case mainTab(MainTabCoordinator.Action)
        case onBoarding(OnBoardingCoordinator.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.mainTab, action: \.mainTab) {
            MainTabCoordinator()
        }
        Scope(state: \.onBoarding, action: \.onBoarding) {
            OnBoardingCoordinator()
        }
        
        Reduce<State, Action> { state, action in

            switch action {
            case .router(.routeAction(_, action: .onBoarding(.onboarding(.namoAppleLoginResponse(_))))):
                state.routes = [.root(.mainTab(.init(home: .initialState, moim: .initialState)), embedInNavigationView: true)]
            case .router(.routeAction(_, action: .splash(.goToOnboardingScreen))):
                state.routes = [.root(.onBoarding(.init(onBoarding: .init())), embedInNavigationView: true)]
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

