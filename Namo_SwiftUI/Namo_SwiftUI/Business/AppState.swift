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
	@Published var currentSchedule: ScheduleTemplate = ScheduleTemplate()
	
	/// calendar에 보여지기 위한 스케쥴들
	@Published var calendarSchedules: [YearMonthDay: [CalendarSchedule]] = [:]
}

class MoimState: ObservableObject {
	/// 전체 모임 리스트
	@Published var moims: [Moim] = []
	/// 유저가 현재 확인하고 있는 모임
	@Published var currentMoim: Moim = Moim()
}

class AppState: ObservableObject {
	
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
}
