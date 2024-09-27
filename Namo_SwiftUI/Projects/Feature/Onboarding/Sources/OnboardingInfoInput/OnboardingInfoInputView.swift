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
    
    @Perception.Bindable var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            VStack {
                VStack(spacing: 40) {
                    Text("프로필 설정")
                        .font(.pretendard(.regular, size: 20))
                        .foregroundColor(.colorBlack)
                    
                    ProfileImageInputView(store: store)
                    
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
                        store.isShowingNamoToast = true
                    })
                    .onTapGesture {
                        if !store.isNextButtonIsEnabled {
                            store.isShowingNamoToast = true
                        }
                    }
                }
                .padding(.horizontal, 30)
            }
            .padding(.vertical, 40)
            .sheet(isPresented: $store.isShowingPalette) {
                ProfileColorSelectView(store: store)
                    .presentationDetents([.height(300)])
            }
            .namoToastView(isPresented: $store.isShowingNamoToast, title: "색상과 필수 항목을 기재해주세요.")
        }
    }
}
