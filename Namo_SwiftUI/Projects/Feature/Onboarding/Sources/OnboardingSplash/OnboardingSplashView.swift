//
//  OnboardingSplashView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem

public struct OnboardingSplashView: View {
    
    @State var showUpdateRequired: Bool = false
    
    public init() {}
    
    public var body: some View {
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
            isPresented: $showUpdateRequired,
            title: "업데이트가 필요합니다.",
            content: "업데이트가 필요합니다.",
            confirmAction: {
                // appStore 열기
            }
        )
    }
}
