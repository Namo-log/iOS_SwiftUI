//
//  FriendListStore.swift
//  FeatureFriendInterface
//
//  Created by 정현우 on 9/2/24.
//

import ComposableArchitecture

extension FriendListStore {
	public init() {
		let reducer: Reduce<State, Action> = Reduce { state, action in
			switch action {
			case .binding:
				return .none
				
			case let .favoriteBtnTapped(friendId):
				if let index = state.friends.firstIndex(where: { $0.id == friendId }) {
					state.friends[index].isFavorite.toggle()
				}
				
				return .none
				
			case .showAddFriendPopup:
				state.showAddFriendPopup = true
				
				return .none
				
			case .resetAddFriendState:
				state.addFriendNickname = ""
				state.addFriendTag = ""
				// toast가 보이는 중 popup을 띄우는 경우 toast 제거
				state.showAddFriendRequestToast = false
				state.addFriendRequestToastMessage = ""
				
				return .none
				
			case .addFriendRequestTapped:
				
				return .run { send in
					await send(.showAddFriendRequestToast)
				}
				
			case .showAddFriendRequestToast:
				state.addFriendRequestToastMessage = "\(state.addFriendNickname)#\(state.addFriendTag) 님에게 친구 신청을 보냈습니다."
				state.showAddFriendRequestToast = true
				state.showAddFriendPopup = false
				
				return .none
			}
		}
		
		self.init(reducer: reducer)
	}
}
