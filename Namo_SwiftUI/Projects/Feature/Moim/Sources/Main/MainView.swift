//
//  MoimView.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem
import FeatureFriend
import FeatureMoimInterface
import ComposableArchitecture

public struct MainView: View {
    @Perception.Bindable private var store: StoreOf<MainViewStore>
    
    public init(store: StoreOf<MainViewStore>) {
        self.store = store
    }
    
    public var body: some View {
        ZStack {
            WithPerceptionTracking {
                VStack(spacing: 0) {
                    TabBarView(currentTab: $store.currentTab, tabBarOptions: ["모임 일정", "친구리스트"])
                    
                    TabView(selection: $store.currentTab) {
                        
                        // 모임일정 리스트
                        MoimListView(store: store.scope(state: \.moimList, action: \.moimList))
                            .overlay(alignment: .bottomTrailing) {
                                FloatingButton {
                                    store.send(.presentComposeSheet)
                                }
                            }
                            .fullScreenCover(isPresented: $store.isSheetPresented, content: {
                                MoimScheduleEditView(store: store.scope(state: \.moimEdit, action: \.moimEdit))
                                    .background(ClearBackground())
                            })
                            .tag(0)
                        
                        // 친구 리스트
                        FriendListView(store: store.scope(state: \.friendList, action: \.friendList))
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
                .overlay(
                    Color.black.opacity(0.5)
                        .ignoresSafeArea(.all)
                        .opacity(store.isSheetPresented == true ? 1 : 0)
                )
            }
        }
    }
}
