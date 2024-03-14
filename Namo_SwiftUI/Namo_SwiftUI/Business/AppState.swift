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
