//
//  FriendRequestListStore.swift
//  FeatureFriend
//
//  Created by 정현우 on 9/10/24.
//

import ComposableArchitecture

@Reducer
public struct FriendRequestListStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 친구 요청 리스트
		var friends: [DummyFriend]
		var selectedFriend: DummyFriend? = nil
		
		// 친구 정보 popup
		var showFriendInfoPopup: Bool = false
		
		public init(
			friends: [DummyFriend]
		) {
			self.friends = friends
		}
	}
	
	public enum Action: BindableAction {
		case binding(BindingAction<State>)
		// 친구 상세 보기
		case friendDetailTapped(DummyFriend)
		// 수락하기
		case acceptTapped
		// 거절하기
		case rejectTapped
	}
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		
		Reduce { state, action in
			switch action {
			case .binding:
				return .none
				
			case let .friendDetailTapped(friend):
				state.selectedFriend = friend
				state.showFriendInfoPopup = true
				
				return .none
				
			case .acceptTapped:
				return .none
				
			case .rejectTapped:
				return .none
			}
		}
	}
	
}
