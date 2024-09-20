//
//  OnboardingSplashView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture

public struct OnboardingSplashView: View {
    
    @Perception.Bindable var store: StoreOf<OnboardingSplashStore>
    
    public init(store: StoreOf<OnboardingSplashStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {

                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color(hex: 0xe59744),
                            Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
                        ]
                    ),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                
                Image(asset: SharedDesignSystemAsset.Assets.logo)
            }
            .ignoresSafeArea()
            .namoAlertView(
                isPresented: $store.showUpdateRequired,
                title: "업데이트가 필요합니다.",
                content: "업데이트가 필요합니다.",
                confirmAction: {
                    // appStore 열기
                }
            )
        }
    }
}
