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
        let name: String
        /// 생년월일
        var birthDate: Date?
        /// 한줄소개
        var bio: String?
        /// 프로필 이미지 적합 여부
        var isProfileImageValid: Bool?
        /// 닉네임 적합 여부
        var isNicknameValid: Bool?
        /// 이름 로드 여부
        var isNameLoaded: Bool = false
        /// 생년월일 적합 여부
        var isBirthDateValid: Bool?
        /// 확인 버튼 활성화 상태
        var isNextButtonIsEnabled: Bool = false
        /// 팔레트 뷰 표시 여부
        var isShowingPalette: Bool = false
        /// 토스트 표시 여부
        var isSowingNamoToast: Bool = false
        
        
        public init(name: String?) {
            if let name {
                self.name = name
                self.isNameLoaded = true
            }
            else {
                self.name = ""
                self.isNameLoaded = false
            }
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        /// 이미지 추가 버튼 탭
        case addImageButtonTapped
        /// 닉네임 수정
        case nicknameChanged(String)
        /// 생년월일 수정
        case birthDateChanged(Date)
        /// 한줄소개 수정
        case bioChanged(String)
        /// 확인 버튼 탭
        case nextButtonTapped
        
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .addImageButtonTapped:
                print("이미지 피커 표시")
                return .none
            case .nicknameChanged(let nickname):
                print("현재 nickname: \(nickname)")
                return .none
            case .birthDateChanged(let birthDate):
                print("현재 Date: \(birthDate)")
                return .none
            case .bioChanged(let bio):
                print("현재 bio: \(bio)")
                return .none
            case .nextButtonTapped:
                print("다음")
                return .none
            }
        }
    }
}
