//
//  HomeMainStore.swift
//  FeatureHome
//
//  Created by 정현우 on 9/18/24.
//

import SwiftUI

import ComposableArchitecture
import SwiftUICalendar

import DomainSchedule

@Reducer
public struct HomeMainStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// datepicker popup
		var showDatePicker: Bool = false
		
		// 달력에서 현재 focusing된 날짜
		var focusDate: YearMonthDay? = nil
		
		// 캘린더에 표시될 일정
		var schedules: [YearMonthDay: [CalendarSchedule]] = [:]
		
		public init() {}
	}
	
	public enum Action: BindableAction {
		case binding(BindingAction<State>)
		// +- 2달 일정 가져오기
		case getSchedule(ym: YearMonth)
		// 뒤로 스크롤
		case scrollBackwardTo(ym: YearMonth)
		// 앞으로 스크롤
		case scrollForwardTo(ym: YearMonth)
		// state에 적용
		case setScheduleToState(schedules: [YearMonthDay: [CalendarSchedule]])
		
		
		// datepicker popup
		case datePickerTapped
		// 보관함 열기
		case archiveTapped
		// 특정 날짜 선택
		case selectDate(YearMonthDay)
		
	}
	
	@Dependency(\.scheduleUseCase) var scheduleUseCase
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		Reduce { state, action in
			switch action {
			case .binding:
				return .none
				
			case .getSchedule(let ym):
				
				return .run { send in
					let response = await getSchedule(ym: ym)
					await send(.setScheduleToState(schedules: response))
				}
				
			case .scrollBackwardTo(let ym):
				return .run { send in
					let response = await getSchedule(ym: ym)
					await send(.setScheduleToState(schedules: response))
				}
			case .scrollForwardTo(let ym):
				return .run { send in
					let response = await getSchedule(ym: ym)
					await send(.setScheduleToState(schedules: response))
				}
			case .setScheduleToState(let schedules):
				state.schedules = schedules
				
				return .none
				
				
			case .datePickerTapped:
				state.showDatePicker = true
				
				return .none
				
			case .archiveTapped:
				return .none

			case .selectDate(let date):
				if state.focusDate == date {
					state.focusDate = nil
				} else {
					state.focusDate = date
				}
				
				return .none
			}
			
		}
	}
	
	func getSchedule(ym: YearMonth) async -> [YearMonthDay: [CalendarSchedule]] {
//		let response = await scheduleUseCase.getSchedule(
//			startDate: ym.addMonth(-2).getFirstDay(),
//			endDate: ym.addMonth(2).getLastDay()
//		)
		
		let response = Schedule.dummySchedules
		
		return scheduleUseCase.mapScheduleToCalendar(response)
	}
}
