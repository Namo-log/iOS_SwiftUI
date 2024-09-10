//
//  MoimView.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem
import FeatureFriend
import ComposableArchitecture

public struct MoimView: View {
    @State private var tabIndex = 0
    
    public init() {}
    
    public var body: some View {
        VStack {
            SectionTabBar(tabIndex: $tabIndex, tabTitle: ["모임 일정", "친구 리스트"]) {
                Spacer()
                if tabIndex == 0 {
                    MoimListView()
                } else {
                    FriendListView(
                        store: Store(
                            initialState: FriendListStore.State(
                                friends: dummyFriends
                            ),
                            reducer: {
                                FriendListStore()
                            }
                        )
                    )
                }
                Spacer()
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .namoNabBar(left: {
            Text("Group Calendar")
                .font(.pretendard(.bold, size: 22))
                .foregroundStyle(.black)
            
        }, right: {
            Image(asset: SharedDesignSystemAsset.Assets.icNotification)
        })
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
