//
//  ScheduleEditCoordinator.swift
//  FeatureHome
//
//  Created by 정현우 on 10/3/24.
//

import ComposableArchitecture
import TCACoordinators

@Reducer(state: .equatable)
public enum ScheduleEditScreen {
	case scheduleEdit(ScheduleEditStore)
}

@Reducer
public struct ScheduleEditCoordinator {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		var routes: [Route<ScheduleEditScreen.State>]
	}
	
	public enum Action {
		case router(IndexedRouterActionOf<ScheduleEditScreen>)
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
				
			default:
				return .none
			}
		}
		.forEachRoute(\.routes, action: \.router)
	}
}

