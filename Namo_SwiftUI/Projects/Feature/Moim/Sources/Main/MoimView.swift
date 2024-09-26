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
    @State private var currentTab: Int = 0
    private let store: StoreOf<MoimViewStore>
    
    public init(store: StoreOf<MoimViewStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 0) {
            TabBarView(currentTab: $currentTab, tabBarOptions: ["모임 일정", "친구리스트"])
            
            TabView(selection: $currentTab) {
                MoimListView(store: .init(initialState: MoimListStore.State(), reducer: {
                    MoimListStore()
                }))
                .tag(0)
                
                FriendListView(
                    store: .init(
                        initialState: FriendListStore.State(
                            friends: []
                        ),
                        reducer: {
                            FriendListStore()
                        }
                    )
                )
                .tag(1)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
           
        }
        .namoNabBar(left: {
            Text("Group Calendar")
                .font(.pretendard(.bold, size: 22))
                .foregroundStyle(.black)
        }, right: {
            Button(action: {
                store.send(.notificationButtonTap)
            }) {
                Image(asset: SharedDesignSystemAsset.Assets.icNotification)
            }
        })
    }
}
