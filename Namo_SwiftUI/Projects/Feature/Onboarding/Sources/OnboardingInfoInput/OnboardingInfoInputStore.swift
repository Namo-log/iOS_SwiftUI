//
//  OnboardingInfoInputStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/26/24.
//

import ComposableArchitecture
import SwiftUICore

@Reducer
public struct OnboardingInfoInputStore {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        
        /// 프로필 이미지
        var profileImage: Image?
        /// 닉네임
        var nickname: String?
        /// 이름
        var name: String
        /// 생년월일
        var birthDate: Date?
        /// 한줄소개
        var bio: String?
        /// 프로필 이미지 적합 여부
        var profileImageValid: Bool?
        /// 닉네임 적합 여부
        var nicknameValid: Bool?
        /// 이름 적합 여부
        var nameValid: Bool?
        /// 생년월일 적합 여부
        var birthDateValid: Bool?
        /// 확인 버튼 활성화 상태
        var nextButtonIsEnabled: Bool = false
        /// 팔레트 뷰 표시 여부
        var isShowingPalette: Bool = false
        /// 토스트 표시 여부
        var isSowingNamoToast: Bool = false
        
        
        public init(name: String) {
            self.name = name
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            }
        }
    }
}
