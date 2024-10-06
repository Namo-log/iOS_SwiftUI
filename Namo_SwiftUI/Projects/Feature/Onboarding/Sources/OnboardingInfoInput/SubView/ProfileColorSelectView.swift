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
    
    @Perception.Bindable var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            VStack {
                Spacer()
                NamoPallete(selectedColor: $store.selectedPaletterColor, itemName: "색상")
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
                    store.send(.saveFavoriteColor(store.selectedPaletterColor))
                    store.send(.dismissColorPaletteView)
                }, label: {
                    Text("저장")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundColor(.mainText)
                })
            })
        }
    }
}
