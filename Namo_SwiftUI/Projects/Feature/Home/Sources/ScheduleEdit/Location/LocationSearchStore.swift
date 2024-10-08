//
//  LocationSearchStore.swift
//  FeatureHome
//
//  Created by 정현우 on 10/8/24.
//

import ComposableArchitecture


@Reducer
public struct LocationSearchStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		
	}
	
	public enum Action {
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			return .none
		}
	}
	
}
