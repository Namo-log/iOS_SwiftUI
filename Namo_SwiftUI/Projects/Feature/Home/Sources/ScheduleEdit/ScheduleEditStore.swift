//
//  ScheduleEditStore.swift
//  FeatureHome
//
//  Created by 정현우 on 10/3/24.
//

import SwiftUI

import ComposableArchitecture
import SwiftUICalendar

import DomainSchedule
import DomainCategory
import SharedUtil

@Reducer
public struct ScheduleEditStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 스케쥴 생성인지 수정인지
		var isNewSchedule: Bool = false
		// 현재 생성/수정 중인 스케쥴
		var schedule: ScheduleEdit
		// 카테고리 리스트
		@Shared(.inMemory(SharedKeys.categories.rawValue)) var categories: [NamoCategory] = []
		// 선택된 카테고리
		var selectedCategory: NamoCategory? = nil
		// 시작일 캘린더
		var showStartDatePicker: Bool = false
		// 종료일 캘린더
		var showEndDatePicker: Bool = false
		
		
		public init(
			isNewSchedule: Bool,
			schedule: ScheduleEdit
		) {
			self.isNewSchedule = isNewSchedule
			self.schedule = schedule
		}
	}
	
	public enum Action: BindableAction {
		case binding(BindingAction<State>)
		
		case viewOnAppear
		// 닫기 버튼
		case closeBtnTapped
		// 저장 버튼
		case saveBtnTapped
		// 시작 캘린더 토글
		case startDatePickerToggle
		// 종료 캘린더 토글
		case endDatePickerToggle
		// 알림 버튼
		case reminderBtnTapped
		// 장소 버튼
		case locationBtnTapped
		
	}
	
	@Dependency(\.categoryUseCase) var categoryUseCase
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		
		Reduce { state, action in
			switch action {
			case .binding:
				return .none
				
			case .viewOnAppear:
				if state.isNewSchedule {
					// 스케쥴 생성의 경우 base category
					state.selectedCategory = state.categories.filter({$0.baseCategory}).first
				} else {
					// 스케쥴 수정의 경우 기존 카테고리
					state.selectedCategory = state.categories.filter({$0.categoryId == state.schedule.categoryId}).first
				}
				return .none
				
			case .closeBtnTapped:
				return .none
				
			case .saveBtnTapped:
				return .none
				
			case .startDatePickerToggle:
				state.showStartDatePicker.toggle()
				
				return .none
				
			case .endDatePickerToggle:
				state.showEndDatePicker.toggle()
				
				return .none
				
			case .reminderBtnTapped:
				return .none
				
			case .locationBtnTapped:
				return .none
				
			}
		}
		
	}
	
}
