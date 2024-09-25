//
//  MoimRequestView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem
import FeatureFriend
import ComposableArchitecture

public struct MoimRequestView: View {
    let store: StoreOf<MoimRequestStore>
    
    @State private var tabIndex = 0
    
    public init(store: StoreOf<MoimRequestStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            SectionTabBar(tabIndex: $tabIndex, tabTitle: ["모임 요청", "친구 요청"]) {
                if tabIndex == 0 {
                    MoimRequestList()
                } else {
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
            
        }
        .namoNabBar(center: {
            Text("새로운 요청")
                .font(.pretendard(.bold, size: 16))
                .foregroundStyle(.black)
        }, left: {
            Button(action: {
                
            }, label: {
                Image(asset: SharedDesignSystemAsset.Assets.icArrowLeftThick)
            })
        })
    }
    
}

