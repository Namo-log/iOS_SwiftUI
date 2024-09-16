//
//  OnboardingCompleteView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem

public struct OnboardingCompleteView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            
            Spacer()
            
            VStack(spacing: 16) {
                Text("회원 가입이 완료되었습니다")
                    .font(.pretendard(.regular, size: 20))
                    .foregroundColor(.colorBlack)
                Text("정보는 추후 마이 페이지에서 수정 가능해요")
                    .font(.pretendard(.regular, size: 16))
                    .foregroundColor(.colorBlack)
            }
            .padding(.bottom, 35)
            
            ProfileCardView()
                .padding(.horizontal, 30)
            
            Spacer()
            
            NamoButton(title: "확인", type: .active, action: {})
                .padding(.horizontal, 25)
        }
        .padding(.vertical, 40)
    }
}
