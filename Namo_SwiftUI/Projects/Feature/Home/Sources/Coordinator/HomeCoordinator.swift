//
//  HomeCoordinator.swift
//  FeatureHome
//
//  Created by 정현우 on 9/27/24.
//

import ComposableArchitecture
import TCACoordinators

@Reducer(state: .equatable)
public enum HomeScreen {
	case homeMain(HomeMainStore)
}

@Reducer
public struct HomeCoordinator {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		var routes: [Route<HomeScreen.State>]
		
		public static let initialState = State(routes: [.root(.homeMain(.init()), embedInNavigationView: true)])
	}
	
	public enum Action {
		case router(IndexedRouterActionOf<HomeScreen>)
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .router(.routeAction(_, action: .homeMain(.archiveTapped))):
				return .none
				
				
			default:
				return .none
			}
		}
	}
}
