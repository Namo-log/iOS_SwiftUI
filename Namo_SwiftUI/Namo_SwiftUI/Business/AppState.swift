//
//  AppState.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation
import SwiftUICalendar

struct CategoryState {
    var categoryList: [ScheduleCategory]
}

struct CategoryInputState {
    
    var categoryTitle: String
    var selectedPaletteId: Int
    var isShare: Bool
}

struct PlaceState {
    var placeList: [Place]
    var selectedPlace: Place?
}

class ScheduleState: ObservableObject {
    /// 개인 일정 생성/수정을 위한 스케줄 템플릿
	@Published var currentSchedule: ScheduleTemplate = ScheduleTemplate()
    /// 모임 일정 생성./수정을 위한 스케줄 템플릿
    @Published var currentMoimSchedule: MoimScheduleTemplate = MoimScheduleTemplate()
	
	/// calendar에 보여지기 위한 스케쥴들
	@Published var calendarSchedules: [YearMonthDay: [CalendarSchedule]] = [:]
	// 캘린더에 표시된(계산된) YearMonth를 저장
	@Published var calculatedYearMonth: [YearMonth] = []
}

class DiaryState: ObservableObject {
    /// 상세 보기를 위해 선택된 하나의 기록
    @Published var currentDiary: Diary = Diary()
    /// 기록 메인 화면에 보여지기 위한 기록들
    @Published var monthDiaries: [Diary] = []
    /// 상세 보기를 위해 선택된 하나의 모임 기록
    @Published var currentMoimDiaryInfo: GetOneMoimDiaryResDTO = GetOneMoimDiaryResDTO()
}

class MoimState: ObservableObject {
	/// 전체 모임 리스트
	@Published var moims: [Moim] = []
	/// 유저가 현재 확인하고 있는 모임
	@Published var currentMoim: Moim = Moim()
	@Published var currentMoimSchedule: [YearMonthDay: [CalendarMoimSchedule]] = [:]
	
	// 그룹 탈퇴 후 토스트
	@Published var showGroupWithdrawToast: Bool = false
	
	// 그룹 코드 복사 토스트
	@Published var showGroupCodeCopyToast: Bool = false
}

class AppState: ObservableObject {
	@Published var isLoading: Bool = false
	
	// Tabbar
	@Published var isTabbarHidden: Bool = false
	@Published var isTabbarOpaque: Bool = false
    
    @Published var currentTab: Tab = .home
	
	// Alert
	@Published var showAlert: Bool = false
	@Published var alertMessage: String = ""
    
	// Category(key - categoryId, value - paletteId)
	@Published var categoryPalette: [Int: Int] = [:]
	
    @Published var isLogin: Bool = false
	
    // TODO: - 회의한 것처럼 수정 필요
    @Published var isPersonalDiary: Bool = true
    @Published var isDeletingDiary: Bool = false
    @Published var isEditingDiary: Bool = false

    // Category
    @Published var categoryState: CategoryState = CategoryState(
        categoryList: []
    )
    
    // Place
    @Published var placeState: PlaceState = PlaceState(
        placeList: [], selectedPlace: nil
    )
    
    // 카테고리 삭제 버튼 보이기
    @Published var showCategoryDeleteBtn: Bool = false
    
    // 카테고리 삭제 불가 여부
    @Published var categoryCantDelete: Bool = false
    
    // 카테고리 삭제 완료 토글 보이기
    @Published var showCategoryDeleteDoneToast: Bool = false
    
    // 카테고리 수정 완료 토글 보이기
    @Published var showCategoryEditDoneToast: Bool = false
    
    // 카테고리 삭제 불가 토글 보이기
    @Published var showCategoryCantDeleteToast: Bool = false
    
    // 어떤 소셜로 로그인한 상태인지
    @Published var socialLogin: SocialLogin = .kakao
}
