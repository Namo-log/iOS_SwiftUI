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
    
    // 예시로 입력한 프로퍼티입니다.
    @Published var example = 0
	
	// Tabbar
	@Published var isTabbarHidden: Bool = false
	@Published var isTabbarOpaque: Bool = false
	
	// Alert
	@Published var showAlert: Bool = false
	@Published var alertMessage: String = ""
    
	// Category(key - categoryId, value - paletteId)
	@Published var categoryPalette: [Int: Int] = [:]
	
    @Published var isLogin: Bool = false
	
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
