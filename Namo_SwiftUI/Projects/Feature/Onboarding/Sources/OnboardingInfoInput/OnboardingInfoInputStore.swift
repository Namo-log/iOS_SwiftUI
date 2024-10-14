//
//  OnboardingInfoInputStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/26/24.
//

import ComposableArchitecture
import SwiftUI
import PhotosUI

import SharedDesignSystem

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
    
    /// 닉네임 정규식 (영어, 한글, 숫자 포함 12자 이내, 특수 문자 및 이모지 불가)
    let nicknameRegex = "^[a-zA-Z0-9가-힣ㄱ-ㅎㅏ-ㅣ]{1,12}$"
    /// 년도 정규식
    let yearRegex = #"^\d{4}$"#
    /// 월 정규식
    let monthRegex = "^(0[1-9]|1[0-2])$"
    /// 일 정규식
    let dayRegex = "^(0[1-9]|[12][0-9]|3[01])$"
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        
        /// 프로필 이미지 아이템 -> 프로필 이미지로 변환
        var profileImageItem: PhotosPickerItem?
        /// 프로필 이미지
        var profileImage: UIImage?
        /// 닉네임
        var nickname: String = ""
        /// 이름
        var name: String = ""
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
		var selectedPaletterColor: PalleteColor?
        /// 좋아하는 색상
        var favoriteColor: Color?
        /// 좋아하는 색상 선택 상태
        var favoriteColorState: InfoFormState = .blank
        /// 닉네임 작성 상태
        var nicknameState: InfoFormState = .blank
        /// 이름 로드 여부
//        var isNameLoaded: Bool = false
        /// 이름 작성 상태
        var nameState: InfoFormState = .blank
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
        
        
        //        public init(name: String?) {
        //            if let name {
        //                self.name = name
        //                self.isNameLoaded = true
        //            }
        //            else {
        //                self.name = "Unvalid"
        //                self.isNameLoaded = false
        //            }
        //        }
        
        public init() {}

    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        /// 좋아하는 컬러 추가 버튼 탭
        case addFavoriteColorButtonTapped
        /// 컬러 팔레트 색 선택
		case selectPaletteColor(PalleteColor)
        /// 컬러 저장
        case saveFavoriteColor(PalleteColor?)
        /// 컬러 팔레트 dismiss
        case dismissColorPaletteView
        /// 프로필 이미지 수정
        case profileImageChanged(PhotosPickerItem?)
        /// 프로필 이미지 수정사항 반영
        case profileImageLoaded(UIImage?)
        /// 닉네임 수정
        case nicknameChanged(String)
        /// 이름 수정
        case nameChanged(String)
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
        /// 폼 작성 상태 검증
        case checkFormValidate
        /// 확인 버튼 상태 업데이트
        case updateNextButtonStatus
        /// 확인 버튼 탭
        case nextButtonTapped
        /// 토스트뷰 표시
        case showToastView
        /// 다음 화면으로
        case goToNextScreen
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding(let bindingAction):
                switch bindingAction.keyPath {
                    // 바인딩된 State 별 Action 라우팅
                case \State.profileImageItem:
                    return .send(.profileImageChanged(state.profileImageItem))
                case \State.nickname:
                    return .send(.nicknameChanged(state.nickname))
                case \State.name:
                    return .send(.nameChanged(state.name))
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
                
            case .addFavoriteColorButtonTapped:
                print("컬러 팔레트 표시")
                state.isShowingPalette = true
                return .none
                
            case .selectPaletteColor(let color):
                print("컬러 선택: \(color)")
                state.selectedPaletterColor = color
                return .none
                
            case .saveFavoriteColor(let nilableColor):
                if let color = nilableColor?.color {
                    print("컬러 저장: \(color)")
                    state.favoriteColor = color
                    state.favoriteColorState = .filled
                    return .send(.updateNextButtonStatus)
                }
                else {
                    print("컬러 저장 불가")
                    return .none
                }
                
            case .dismissColorPaletteView:
                print("컬러 팔레트 dismiss")
                state.isShowingPalette = false
                return .none
                
            case .profileImageChanged(let item):
                guard let item = item else {
                    return .send(.profileImageLoaded(nil))
                }

                return .run { send in
                    do {
                        if let data = try await item.loadTransferable(type: Data.self),
                           let image = UIImage(data: data) {
                            await send(.profileImageLoaded(image))
                        } else {
                            await send(.profileImageLoaded(nil))
                        }
                    } catch {
                        print("Error loading image: \(error)")
                        await send(.profileImageLoaded(nil))
                    }
                }
                
            case .profileImageLoaded(let image):
                state.profileImage = image
                return .none
            
            case .nicknameChanged(let nickname):
                print("현재 nickname: \(nickname), \(state.nicknameState)")
                state.nicknameState = nickname.isEmpty ? .blank : .filled
                return .send(.updateNextButtonStatus)
                
            case .nameChanged(let name):
                print("현재 name: \(name), \(state.nameState)")
                state.nameState = name.isEmpty ? .blank : .filled
                return .send(.updateNextButtonStatus)
                
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
                return .send(.updateNextButtonStatus)
            
            case .bioChanged(let bio):
                print("현재 bio: \(bio)")
                state.bioState = bio.isEmpty ? .blank : .filled
                return .send(.updateNextButtonStatus)
            
            case .updateNextButtonStatus:
                let status =
                state.favoriteColor != nil
                && state.nickname.matches(regex: nicknameRegex)
                && !state.name.isEmpty
                && state.birthYear.matches(regex: yearRegex)
                && state.birthMonth.matches(regex: monthRegex)
                && state.birthDay.matches(regex: dayRegex)
                && state.bio.count <= 50
                
                state.isNextButtonIsEnabled = status
                return .none
                
            case .nextButtonTapped:
                return .send(.checkFormValidate)
                
            case .checkFormValidate:
                state.favoriteColorState = state.favoriteColor != nil ? .valid : .invalid
                state.nicknameState = state.nickname.matches(regex: nicknameRegex) ? .valid : .invalid
                state.nameState = state.name.isEmpty ? .blank : .valid
                state.birthYearState = state.birthYear.matches(regex: yearRegex) ? .valid : .invalid
                state.birthMonthState = state.birthMonth.matches(regex: monthRegex) ? .valid : .invalid
                state.birthDayState = state.birthDay.matches(regex: dayRegex) ? .valid : .invalid
                state.bioState = state.bio.count <= 50 ? .valid : .invalid
                
                if state.favoriteColorState == .valid &&
                    state.nicknameState == .valid &&
                    state.nameState == .valid &&
                    state.birthYearState == .valid &&
                    state.birthMonthState == .valid &&
                    state.birthDayState == .valid &&
                    state.bioState == .valid {
                    print("allowed to go next")
                    return .send(.goToNextScreen)
                } else {
                    print("not allowed to go next")
                    return .send(.showToastView)
                }
            
            case .goToNextScreen:
                print("goToNextScreen")
                return .none
                
            case .showToastView:
                state.isShowingNamoToast = true
                return .none
            }
        }
    }
}
