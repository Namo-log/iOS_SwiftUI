import SwiftUI

import ComposableArchitecture

import FeatureFriend

@main
struct FeatureFriendExampleApp: App {
	
	var body: some Scene {
		WindowGroup {
//			FriendListView(
//				store: Store(
//					initialState: FriendListStore.State(
//						friends: dummyFriends
//					),
//					reducer: {
//						FriendListStore()
//					}
//				)
//			)
			FriendRequestListView(
				store: Store(
					initialState: FriendRequestListStore.State(
						friends: dummyFriends
					),
					reducer: {
						FriendRequestListStore()
					}
				)
			)
		}
	}
	
	
	let dummyFriends: [DummyFriend] = [
		DummyFriend(
			id: 1,
			image: .blue,
			nickname: "닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네https://cyber.gachon.ac.kr/ubion_document/94/f7/94f7ee67dadffd59821c4ba9351f7c74fbc8764b/94f7ee67dadffd59821c4ba9351f7c74fbc8764b.files/3.png임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임",
			description: "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명",
			isFavorite: true,
			tag: "1234"
		),
		DummyFriend(
			id: 2,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 3,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 4,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 5,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 6,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 7,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		),
		DummyFriend(
			id: 8,
			image: .blue,
			nickname: "닉네임",
			description: "설명",
			isFavorite: false,
			tag: "1234"
		)
	]
	
}
