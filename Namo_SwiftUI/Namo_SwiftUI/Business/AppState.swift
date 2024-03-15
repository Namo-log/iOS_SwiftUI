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
	
    @Published var isLogin: Bool = false
	
    // TODO: - 회의한 것처럼 수정 필요
    @Published var isPersonalDiary: Bool = true
    @Published var isDeletingDiary: Bool = false
    @Published var isEditingDiary: Bool = false

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

    // categoryId : name
//    @Published var categoryName: [Int: String] = [:]
    
//    @Published var categoryList: [CategoryDTO] = []
}
