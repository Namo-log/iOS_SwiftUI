//
//  MainTabCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import Feature

@Reducer
struct MainTabCoordinator {
    enum Tab: Hashable {
		case home
        case moim
    }
    
    enum Action {
		case home(HomeCoordinator.Action)
        case moim(MoimCoordinator.Action)
    }
    
    @ObservableState
    struct State: Equatable {
		static let intialState = State(home: .initialState, moim: .initialState)
		var home: HomeCoordinator.State
        var moim: MoimCoordinator.State
    }
    
    var body: some ReducerOf<Self> {
        // 탭은 Navigatin을 가지지 않고 각 Coordinator를 Scope로 설정
		Scope(state: \.home, action: \.home) {
			HomeCoordinator()
		}
        Scope(state: \.moim, action: \.moim) {
            MoimCoordinator()
        }
        Reduce { state, action in
            switch action {
            default:
                return .none
            }            
        }
        
    }
}
