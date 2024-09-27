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
        var nickname: String = ""
        /// 이름
        let name: String
        /// 생년
        var birthYear: String = ""
        /// 생월
        var birthMonth: String = ""
        /// 생일
        var birthDay: String = ""
        /// 생년월일
        var birthDate: String?
        /// 한줄소개
        var bio: String = ""
        /// 좋아하는 색상
        var favoriteColor: Color?
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
                self.name = "Unvalid"
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
        /// 생년 수정
        case birthYearChanged(String)
        /// 생월 수정
        case birthMonthChanged(String)
        /// 생일 수정
        case birthDayChanged(String)
        /// 생년월일 병합
        case birthDateMerge(String, String, String)
        /// 한줄소개 수정
        case bioChanged(String)
        /// 확인 버튼 탭
        case nextButtonTapped
        
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(let bindingAction):
                switch bindingAction.keyPath {
                case \State.nickname:
                    return .send(.nicknameChanged(state.nickname))
                case \State.bio:
                    return .send(.bioChanged(state.bio))
                case \State.birthYear:
                    return .send(.birthYearChanged(state.birthYear))
                case \State.birthMonth:
                    return .send(.birthMonthChanged(state.birthMonth))
                case \State.birthDay:
                    return .send(.birthDayChanged(state.birthDay))
                default:
                    return .none
                }
            case .addImageButtonTapped:
                print("이미지 피커 표시")
                return .none
            case .nicknameChanged(let nickname):
                print("현재 nickname: \(nickname)")
                return .none
            case .birthYearChanged(let year):
                print("현재 year: \(year)")
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthMonthChanged(let month):
                print("현재 month: \(month)")
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthDayChanged(let day):
                print("현재 day: \(day)")
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthDateMerge(let year, let month, let day):
                state.birthDate = "\(year)-\(month)-\(day)"
                print("현재 birthDate: \(state.birthDate)")
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
