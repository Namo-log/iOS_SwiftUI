//
//  ProfileColorSelectView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem

public struct ProfileColorSelectView: View {
    
    var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack(spacing: 40) {
            NamoPallete(itemName: "기본 색상", colors: [.colorGreen, .colorLavendar, .colorBlack, .colorBlue])
            NamoPallete(itemName: "팔레트", colors: [.colorBlack, .colorBlue, .colorCyan, .colorGray, .colorGreen, .colorLavendar, .colorBlack, .colorBlue, .colorCyan])
            Spacer()
        }
        .padding(30)
        .namoNabBar(center: {
            Text("좋아하는 색상")
                .font(.pretendard(.bold, size: 15))
                .foregroundColor(.mainText)
        }, left: {
            Button(action: {
                store.send(.dismissColorPaletteView)
            }, label: {
                Text("취소")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundColor(.mainText)
            })
        }, right: {
            Button(action: {
                store.send(.dismissColorPaletteView)
            }, label: {
                Text("저장")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundColor(.mainText)
            })
        })
    }
}
