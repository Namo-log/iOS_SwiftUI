//
//  FriendInfoPopupStore.swift
//  FeatureFriend
//
//  Created by 정현우 on 9/3/24.
//

import ComposableArchitecture

@Reducer
public struct FriendInfoPopupStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		public var friend: DummyFriend
		
		public init(
			friend: DummyFriend
		) {
			self.friend = friend
		}
	}
	
	public enum Action {
		
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			return .none
		}
	}
}
