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
}

@Reducer
struct AppCoordinator {
    
    @ObservableState
    struct State {
        static let initialState = State(routes: [.root(.onboarding(.initialState), embedInNavigationView: true)])
        var routes: [Route<AppScreen.State>]
    }
    
    enum Action {
        case router(IndexedRouterActionOf<AppScreen>)
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in

            switch action {
                
            // mainTab 이동 - 로그인 체크 결과 goToMainScreen 시
            case .router(.routeAction(_, action: .onboarding(.goToMainScreen))):
                state.routes = [.root(.mainTab(.init(home: .initialState, moim: .initialState)), embedInNavigationView: true)]
                return .none
                
            default:
                return .none
            }
        }
        .forEachRoute(\.routes, action: \.router)
    }
}

