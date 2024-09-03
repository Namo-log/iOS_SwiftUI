import SwiftUI

import ComposableArchitecture

import FeatureFriendInterface

@main
struct FeatureFriendExampleApp: App {
	var body: some Scene {
		WindowGroup {
			TabView {
				FriendListView(
					store: Store(
						initialState: FriendListStore.State(
							friends: [
								DummyFriend(
									id: 1,
									image: .blue,
									nickname: "닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임닉네임",
									description: "설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명설명",
									isFavorite: true
								),
								DummyFriend(
									id: 2,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 3,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 4,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 5,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 6,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 7,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								),
								DummyFriend(
									id: 8,
									image: .blue,
									nickname: "닉네임",
									description: "설명",
									isFavorite: false
								)
							]
						),
						reducer: {
							FriendListStore()
						}
					)
				)
			}
		}
	}
}
