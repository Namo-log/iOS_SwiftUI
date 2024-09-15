//
//  OnboardingLoginView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem
import SharedUtil

public struct OnboardingLoginView: View {
    
    public init() {}
    
    public var body: some View {
        
        VStack {
            // TODO: 추후 화면 사이즈별 대응 디자인 기준 적용 필요
            Spacer(minLength: isSmallScreen(threshold: 680, for: \.height) ? nil : 170)
            
            VStack(spacing: 34) {
                Text("나의 모임 기록 ")
                    .font(Font.pretendard(.regular, size: 18))
                + Text("나모")
                    .font(Font.pretendard(.bold, size: 18))
                
                Image(asset: SharedDesignSystemAsset.Assets.loginLogo)
                    .frame(width: 150, height: 150)
            }
            
            Spacer(minLength: isSmallScreen(threshold: 680, for: \.height) ? nil : 138)
            
            VStack(spacing: 20) {
                LoginButton(style: .kakao, action: {
                    print(screenHeight)
                })
                LoginButton(style: .naver, action: {})
                LoginButton(style: .apple, action: {})
            }
            
            Spacer(minLength: isSmallScreen(threshold: 680, for: \.height) ? nil : 83)
        }
    }
}
