//
//  LoginButton.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI

import SharedUtil
import SharedDesignSystem

/// 로그인 화면에서 사용되는 소셜 로그인 버튼입니다.
struct LoginButton: View {
    
    let style: LoginButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Rectangle()
                    .frame(width: screenWidth-50, height: 55)
                    .foregroundStyle(style.buttonBackgroundColor)
                    .cornerRadius(15)
                
                Text(style.textContent)
                    .foregroundStyle(style.textColor)
                    .font(Font.pretendard(.bold, size: 18))
            }
        }
        .overlay(
            Image(asset: style.buttonImage)
                .frame(width: 24, height: 24)
                .padding(.leading, 25),
            alignment: .leading
        )
    }
}

extension LoginButton {
    /// LoginButton에 적용되는 Style
    enum LoginButtonStyle {
        case kakao
        case naver
        case apple
        
        var textContent: String {
            switch self {
            case .kakao:
                return "카카오 로그인"
            case .naver:
                return "네이버 로그인"
            case .apple:
                return "Apple로 로그인"
            }
        }
        
        var textColor: Color {
            switch self {
            case .kakao:
                return .colorBlack
            case .naver, .apple:
                return .white
            }
        }
        
        var buttonBackgroundColor: Color {
            switch self {
            case .kakao:
                return .init(hex: 0xFFE812)
            case .naver:
                return .init(hex: 0x03C75A)
            case .apple:
                return .colorBlack
            }
        }
        
        var buttonImage: SharedDesignSystemImages {
            switch self {
            case .kakao:
                return SharedDesignSystemAsset.Assets.icLoginKakao
            case .naver:
                return SharedDesignSystemAsset.Assets.icLoginNaver1
            case .apple:
                return SharedDesignSystemAsset.Assets.icLoginApple
            }
        }
    }
}
