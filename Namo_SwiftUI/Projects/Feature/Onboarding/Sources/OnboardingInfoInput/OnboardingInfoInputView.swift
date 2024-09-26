//
//  OnboardingInfoInputView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem
import SharedUtil

public struct OnboardingInfoInputView: View {
    
    @State private var isShowingPalette = false
    
    public let store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
            VStack(spacing: 40) {
                Text("프로필 설정")
                    .font(.pretendard(.regular, size: 20))
                    .foregroundColor(.colorBlack)
                
                ProfileImageInputView()
                
                ProfileInfoInputView(store: store)
                    .padding(.horizontal, 30)
                    .padding(.vertical)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                Text("＊표시는 필수 항목입니다.")
                    .font(.pretendard(.regular, size: 14))
                    .foregroundColor(.mainText)
                NamoButton(title: "확인", type: .inactive, action: {
                    isShowingPalette.toggle()
                })
            }
            .padding(.horizontal, 30)
        }
        .padding(.vertical, 40)
        .sheet(isPresented: $isShowingPalette) {
            ProfileColorSelectView()
                .presentationDetents([.height(300)])
        }
        .namoToastView(isPresented: .constant(false), title: "색상과 필수 항목을 기재해주세요.")
    }
}
