//
//  OnboardingInfoInputStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/26/24.
//

import ComposableArchitecture
import SwiftUICore

/// InfoInput 작성 시 내용 구분용으로 사용하는 enum입니다
public enum InfoFormState: Equatable {
    // 미작성
    case blank
    // 작성됨
    case filled
    // 적합
    case valid
    // 부적합
    case invalid
    
    var lineColor: Color {
        switch self {
            
        case .blank:
            return Color.textPlaceholder
        case .filled, .valid:
            return Color.mainText
        case .invalid:
            return Color.namoOrange
        }
    }
}

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
        /// 선택된 팔레트 컬러
        var selectedPaletterColor: Color?
        /// 좋아하는 색상
        var favoriteColor: Color?
        /// 좋아하는 색상 선택 상태
        var favoriteColorState: InfoFormState = .blank
        /// 닉네임 작성 상태
        var nicknameState: InfoFormState = .blank
        /// 이름 로드 여부
        var isNameLoaded: Bool = false
        /// 생년 작성 상태
        var birthYearState: InfoFormState = .blank
        /// 생월 작성 상태
        var birthMonthState: InfoFormState = .blank
        /// 생일 작성 상태
        var birthDayState: InfoFormState = .blank
        /// 한줄소개 작성 상태
        var bioState: InfoFormState = .blank
        /// 확인 버튼 활성화 상태
        var isNextButtonIsEnabled: Bool = false
        /// 팔레트 뷰 표시 여부
        var isShowingPalette: Bool = false
        /// 토스트 표시 여부
        var isShowingNamoToast: Bool = false
        
        
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
        /// 좋아하는 컬러 추가 버튼 탭
        case addFavoriteColorButtonTapped
        /// 컬러 팔레트 색 선택
        case selectPaletteColor(Color)
        /// 컬러 저장
        case saveFavoriteColor(Color?)
        /// 컬러 팔레트 dismiss
        case dismissColorPaletteView
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
        /// 폼 작성 상태 확인
        case checkFormStatus
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
                case \State.selectedPaletterColor:
                    if let selectedColor = state.selectedPaletterColor {
                        return .send(.selectPaletteColor(selectedColor))
                    }
                    else {
                        print("nil 컬러 선택 오류")
                        return .none
                    }
                default:
                    return .none
                }
            case .addImageButtonTapped:
                print("이미지 피커 표시")
                return .none
            case .addFavoriteColorButtonTapped:
                print("컬러 팔레트 표시")
                state.isShowingPalette = true
                return .none
            case .selectPaletteColor(let color):
                print("컬러 선택: \(color)")
                state.selectedPaletterColor = color
                return .none
            case .saveFavoriteColor(let nilableColor):
                if let color = nilableColor {
                    print("컬러 저장: \(color)")
                    state.favoriteColor = color
                    state.favoriteColorState = .filled
                    return .none
                }
                else {
                    print("컬러 저장 불가")
                    return .none
                }
            case .dismissColorPaletteView:
                print("컬러 팔레트 dismiss")
                state.isShowingPalette = false
                return .none
            case .nicknameChanged(let nickname):
                state.nicknameState = nickname.isEmpty ? .blank : .filled
                print("현재 nickname: \(nickname), \(state.nicknameState)")
                return .none
            case .birthYearChanged(let year):
                print("현재 year: \(year)")
                state.birthYearState = year.isEmpty ? .blank : .filled
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthMonthChanged(let month):
                print("현재 month: \(month)")
                state.birthMonthState = month.isEmpty ? .blank : .filled
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthDayChanged(let day):
                print("현재 day: \(day)")
                state.birthDayState = day.isEmpty ? .blank : .filled
                return .send(.birthDateMerge(state.birthYear, state.birthMonth, state.birthDay))
            case .birthDateMerge(let year, let month, let day):
                state.birthDate = "\(year)-\(month)-\(day)"
                print("현재 birthDate: \(state.birthDate)")
                return .none
            case .bioChanged(let bio):
                print("현재 bio: \(bio)")
                state.bioState = bio.isEmpty ? .blank : .filled
                return .none
            case .checkFormStatus:
//                state.nickname
                return .none
            case .nextButtonTapped:
                print("다음")
                return .none
            }
        }
    }
}
