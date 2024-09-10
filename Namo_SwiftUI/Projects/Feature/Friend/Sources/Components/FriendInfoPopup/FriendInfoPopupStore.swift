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
		// 친구 요청에서 온 팝업인지 아닌지
		public var isRequestPopup: Bool
		
		public init(
			friend: DummyFriend,
			isRequestPopup: Bool = false
		) {
			self.friend = friend
			self.isRequestPopup = isRequestPopup
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
