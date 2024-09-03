//
//  FriendListStoreInterface.swift
//  FeatureFriendInterface
//
//  Created by 정현우 on 9/2/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
public struct FriendListStore {
	private let reducer: Reduce<State, Action>
	
	public init(reducer: Reduce<State, Action>) {
		self.reducer = reducer
	}
	
	@ObservableState
	public struct State: Equatable {
		// 친구 검색 textfield 검색어
		var friendSearchTerm: String
		// 친구 리스트
		var friends: [DummyFriend]
		
		// 새 친구 popup
		var showAddFriendPopup: Bool
		// 새 친구 닉네임
		var addFriendNickname: String
		// 새 친구 태그
		var addFriendTag: String
		// 친구 신청 전송 toast
		var showAddFriendRequestToast: Bool
		// 친구 신청 전송 toast messagge
		var addFriendRequestToastMessage: String
		
		
		public init(
			friendSearchTerm: String = "",
			friends: [DummyFriend] = [],
			showAddFriendPopup: Bool = false,
			addFriendNickname: String = "",
			addFriendTag: String = "",
			showAddFriendRequestToast: Bool = false,
			addFriendRequestToastMessage: String = ""
		) {
			self.friendSearchTerm = friendSearchTerm
			self.friends = friends
			self.showAddFriendPopup = showAddFriendPopup
			self.addFriendNickname = addFriendNickname
			self.addFriendTag = addFriendTag
			self.showAddFriendRequestToast = showAddFriendRequestToast
			self.addFriendRequestToastMessage = addFriendRequestToastMessage
		}
	}
	
	public enum Action: BindableAction {
		case binding(BindingAction<State>)
		// 친구 즐겨찾기 버튼 탭
		case favoriteBtnTapped(Int)
		// 새 친구 popup 띄우기
		case showAddFriendPopup
		// 새 친구 popup 데이터 초기화
		case resetAddFriendState
		// 친구 신청 버튼 탭
		case addFriendRequestTapped
		// 친구 신청 완료 toast 띄우기
		case showAddFriendRequestToast
	}
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		
		reducer
	}
}

public struct DummyFriend: Equatable {
//	let image: String
	let id: Int
	let image: Color
	let nickname: String
	let description: String
	var isFavorite: Bool
	
	
	public init(id: Int, image: Color, nickname: String, description: String, isFavorite: Bool) {
		self.id = id
		self.image = image
		self.nickname = nickname
		self.description = description
		self.isFavorite = isFavorite
	}
}
