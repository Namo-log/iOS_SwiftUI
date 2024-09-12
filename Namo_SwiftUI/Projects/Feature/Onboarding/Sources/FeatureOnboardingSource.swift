//
//  FeatureOnboardingSource.swift
//  FeatureOnboardingInterface
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem

public struct TempView: View {
    
    public init() {}
    
    public var body: some View {
        VStack {
            LoginButton(style: .kakao, action: {})
            LoginButton(style: .naver, action: {})
            LoginButton(style: .apple, action: {})
        }
    }
}
