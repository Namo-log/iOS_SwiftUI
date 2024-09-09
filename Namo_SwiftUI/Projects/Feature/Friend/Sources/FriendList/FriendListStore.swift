//
//  FriendListStore.swift
//  FeatureFriendInterface
//
//  Created by 정현우 on 9/2/24.
//

import SwiftUI

import ComposableArchitecture

@Reducer
public struct FriendListStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 친구 검색 textfield 검색어
		public var friendSearchTerm: String
		// 친구 리스트
		public var friends: [DummyFriend]
		
		// 새 친구 popup
		public var showAddFriendPopup: Bool
		// 새 친구 닉네임
		public var addFriendNickname: String
		// 새 친구 태그
		public var addFriendTag: String
		// 친구 신청 전송 toast
		public var showAddFriendRequestToast: Bool
		// 친구 신청 전송 toast messagge
		public var addFriendRequestToastMessage: String
		
		// 친구 정보 popup
		public var showFriendInfoPopup: Bool
		// 현재 선택한 친구
		public var selectedFriend: DummyFriend?
		
		
		public init(
			friendSearchTerm: String = "",
			friends: [DummyFriend] = [],
			showAddFriendPopup: Bool = false,
			addFriendNickname: String = "",
			addFriendTag: String = "",
			showAddFriendRequestToast: Bool = false,
			addFriendRequestToastMessage: String = "",
			showFriendInfoPopup: Bool = false,
			selectedFriend: DummyFriend? = nil
		) {
			self.friendSearchTerm = friendSearchTerm
			self.friends = friends
			self.showAddFriendPopup = showAddFriendPopup
			self.addFriendNickname = addFriendNickname
			self.addFriendTag = addFriendTag
			self.showAddFriendRequestToast = showAddFriendRequestToast
			self.addFriendRequestToastMessage = addFriendRequestToastMessage
			self.showFriendInfoPopup = showFriendInfoPopup
			self.selectedFriend = selectedFriend
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
		// 친구 정보 popup 띄우기
		case showFriendInfoPopup(DummyFriend)
		// 친구 정보에서 즐겨찾기 버튼 탭
		case favoriteBtnTappedInInfo
	}
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		
		Reduce { state, action in
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
				
			case let .showFriendInfoPopup(friend):
				state.selectedFriend = friend
				state.showFriendInfoPopup = true
				
				return .none
				
			case .favoriteBtnTappedInInfo:
				if let friend = state.selectedFriend,
				   let index = state.friends.firstIndex(where: {$0 == friend}) {
					state.selectedFriend?.isFavorite.toggle()
					state.friends[index].isFavorite.toggle()
				}
				
				return .none
			}
		}
	}
}

public struct DummyFriend: Equatable {
	public let id: Int
	public let image: Color
	public let nickname: String
	public let description: String
	public var isFavorite: Bool
	public let tag: String
	public let name: String
	public let birthday: String
	
	
	public init(
		id: Int,
		image: Color = .blue,
		nickname: String = "",
		description: String = "",
		isFavorite: Bool = false,
		tag: String = "",
		name: String = "가나다",
		birthday: String = "10월 14일"
	) {
		self.id = id
		self.image = image
		self.nickname = nickname
		self.description = description
		self.isFavorite = isFavorite
		self.tag = tag
		self.name = name
		self.birthday = birthday
	}
}
