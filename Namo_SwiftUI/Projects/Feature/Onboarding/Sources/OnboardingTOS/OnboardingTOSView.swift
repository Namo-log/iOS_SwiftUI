//
//  OnboardingTOSView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem

public struct OnboardingTOSView: View {
    
    public init() {}
    
    public var body: some View {
        VStack(spacing: 56) {
            
            Spacer()
            
            Text("서비스 이용을 위한 ")
                .foregroundColor(.colorBlack)
                .font(Font.pretendard(.regular, size: 18))
            + Text("약관 동의")
                .foregroundColor(.colorBlack)
                .font(Font.pretendard(.bold, size: 18))
            
            TOSListView()
            
            Spacer()
            
            NamoButton(title: "확인", type: .active, action: {
                print("확인")
            })
            .padding(.horizontal, 25)
            
        }
        .padding(.bottom, 40)
    }
}
