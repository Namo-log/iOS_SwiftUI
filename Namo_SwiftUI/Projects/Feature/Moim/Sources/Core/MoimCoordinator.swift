//
//  MoimCoordinator.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/21/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import FeatureMoimInterface

@Reducer(state: .equatable)
public enum MoimScreen {
    // 모임 일정
    case moimSchedule(MoimViewStore)
    // 모임/친구 요청
    case moimRequest(MoimRequestStore)
}

@Reducer
public struct MoimCoordinator {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init(routes: [Route<MoimScreen.State>],
                    moimSchedule: MoimViewStore.State,
                    moimRequest: MoimRequestStore.State) {
            self.routes = routes
            self.moimSchedule = moimSchedule
            self.moimRequest = moimRequest
        }
        
        public static let initialState = State(routes: [.root(.moimSchedule(.init()),
                                                              embedInNavigationView: true)],
                                               moimSchedule: .init(),
                                               moimRequest: .init())
        
        var routes: [Route<MoimScreen.State>]
        var moimSchedule: MoimViewStore.State
        var moimRequest: MoimRequestStore.State
    }
    
    public enum Action {
        case router(IndexedRouterActionOf<MoimScreen>)
        case moimSchedule(MoimViewStore.Action)
        case moimRequest(MoimRequestStore.Action)
    }
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.moimSchedule, action: \.moimSchedule) {
            MoimViewStore()
        }
        Scope(state: \.moimRequest, action: \.moimRequest) {
            MoimRequestStore()
        }
        
        Reduce<State, Action> { state, action in
            switch action {
            case .router(.routeAction(_, action: .moimSchedule(.notificationButtonTap))):
                state.routes.push(.moimRequest(.init()))
                return .none
            case .router(.routeAction(_, action: .moimRequest(.backButtonTap))):
                state.routes.goBack()
                return .none
            default:
                return .none
            }
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
