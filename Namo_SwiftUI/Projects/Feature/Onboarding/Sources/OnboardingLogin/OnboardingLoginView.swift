//
//  OnboardingLoginView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem
import SharedUtil
import ComposableArchitecture

public struct OnboardingLoginView: View {
    
    public let store: StoreOf<OnboardingLoginStore>
    
    public init(store: StoreOf<OnboardingLoginStore>) {
        self.store = store
    }
    
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
                    store.send(.kakaoLoginButtonTapped)
                })
                LoginButton(style: .naver, action: {
                    store.send(.naverLoginButtonTapped)
                })
                LoginButton(style: .apple, action: {
                    store.send(.appleLoginButtonTapped)
                })
            }
            
            Spacer(minLength: isSmallScreen(threshold: 680, for: \.height) ? nil : 83)
        }
    }
}
