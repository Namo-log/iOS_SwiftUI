//
//  MoimCoordinator.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/21/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

@Reducer(state: .equatable)
public enum MoimScreen {
    // 모임 일정
    case moimSchedule
}

@Reducer
public struct MoimCoordinator {
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init(routes: [Route<MoimScreen.State>]) {
            self.routes = routes
        }
        
        public static let initialState = State(routes: [.root(.moimSchedule)])
        
        var routes: [Route<MoimScreen.State>]        
    }
    
    public enum Action {
        case router(IndexedRouterActionOf<MoimScreen>)
    }
}
