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
        VStack {
            Text("서비스 이용을 위한 ")
                .font(Font.pretendard(.regular, size: 18))
            + Text("약관 동의")
                .font(Font.pretendard(.bold, size: 18))
            TOSListView()
        }
        .padding(.bottom, 40)
    }
}
