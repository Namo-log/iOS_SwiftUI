//
//  AppState.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

struct ScheduleState {
    var currentSchedule: Schedule
    var scheduleTemp: ScheduleTemplate
}

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
	
    // Schedule
    @Published var scheduleState: ScheduleState = ScheduleState(
        currentSchedule: Schedule(
            scheduleId: -1,
            name: "",
            startDate: Date(),
            endDate: Date(),
            alarmDate: [],
            interval: -1,
            x: nil,
            y: nil,
            locationName: "",
            categoryId: -1,
            hasDiary: false,
            moimSchedule: false
        ),
        scheduleTemp: ScheduleTemplate()
    )
    
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
