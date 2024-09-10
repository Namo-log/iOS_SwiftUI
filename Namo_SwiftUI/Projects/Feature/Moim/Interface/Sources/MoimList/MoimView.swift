//
//  MoimView.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem

public struct MoimView: View {
    @State private var tabIndex = 0
    
    public init() {}
    
    public var body: some View {
        VStack {
            SectionTabBar(tabIndex: $tabIndex)
            Spacer()
            if tabIndex == 0 {
                MoimListView()
            } else {
                Text("친구 리스트")
            }
            Spacer()
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
