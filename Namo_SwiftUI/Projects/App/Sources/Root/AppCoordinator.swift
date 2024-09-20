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
    case mainTab(MainTabCoordinator)
    case onBoarding(OnBoardingCoordinator)
    case splash(SplashCoordinator)
}

@Reducer
struct AppCoordinator {
    
    @ObservableState
    struct State {
        static let initialState = State(routes: [.root(.splash(.init()))],
                                        mainTab: .init(),
                                        splash: .init(),
                                        onBoarding: .init())
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
            case .router(.routeAction(_, action: .splash(.loginCheck(let isSuccess)))):
                if isSuccess {
                    state.routes = [.root(.mainTab(.init()))]
                } else {
                    state.routes = [.root(.onBoarding(.init()), embedInNavigationView: true)]
                }
                return .none
            default:
                break
            }
            return .none
        }
        .forEachRoute(\.routes, action: \.router)
    }
}


