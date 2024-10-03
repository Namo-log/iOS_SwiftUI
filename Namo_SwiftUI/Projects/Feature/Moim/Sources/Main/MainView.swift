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
    @ObservedObject private var viewStore: ViewStoreOf<MainViewStore>
    
    public init(store: StoreOf<MainViewStore>) {
        self.store = store        
        self.viewStore = ViewStore(store, observe: {$0})
    }
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                TabBarView(currentTab: viewStore.$currentTab, tabBarOptions: ["모임 일정", "친구리스트"])
                
                TabView(selection: viewStore.$currentTab) {
                    // 모임일정 리스트
                    MoimListView(store: .init(initialState: MoimListStore.State(), reducer: {
                        MoimListStore()
                    }))
                    .overlay(alignment: .bottomTrailing) {
                        FloatingButton {
                            store.send(.set(\.$isSheetPresented, true))
                        }
                    }
                    .sheet(isPresented: viewStore.$isSheetPresented, content: {
                        MoimScheduleEditView(store: .init(initialState: MoimEditStore.State(), reducer: {
                            MoimEditStore()
                        }))
                        .presentationDetents([.height(700)])
                    })
                    .tag(0)
                    
                    // 친구 리스트
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
}
