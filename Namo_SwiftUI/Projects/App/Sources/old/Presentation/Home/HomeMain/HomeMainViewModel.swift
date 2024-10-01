////
////  HomeMainViewModel.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 7/10/24.
////
//
//import SwiftUI
//import SwiftUICalendar
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//
//final class HomeMainViewModel: ObservableObject {
//	struct State {
//		// 최초 1회만 캘린더 불러오기 위한 플래그 변수
//		var isInit: Bool = false
//		// 캘린더에 표시될 일정
//		var calendarSchedules: [YearMonthDay: [CalendarSchedule]] = [:]
//		// 현재 포커싱된(detailView로 띄울) YMD
//		var focusDate: YearMonthDay? = nil
//		// datepicker alert
//		var showDatePicker: Bool = false
//		// datepicker date
//		var pickerCurrentYear: Int = Date().toYMD().year
//		var pickerCurrentMonth: Int = Date().toYMD().month
//		// 일정 생성/수정 sheet
//		var isToDoSheetPresented: Bool = false
//		// 현재 날짜로 스크롤 중인 경우
//		var isScrolling: Bool = false
//	}
//	
//	enum Action {
//		case viewDidLoad
//		case reloadCalendar(date: YearMonthDay? = nil)
//		case didTapAddScheduleButton
//		case scheduleDiaryEditButtonTapped(schedule: Schedule)
//		case scheduleEditButtonTapped(schedule: Schedule)
//	}
//	
//	let scheduleUseCase = ScheduleUseCase.shared
//	
//	@Injected(\.scheduleState) private var scheduleState
//	@Injected(\.diaryState) private var diaryState
//	@Published var state: State
//	
//	init(
//		state: State = .init()
//	) {
//		self.state = state
//	}
//	
//	func action(_ action: Action) {
//		switch action {
//		case .viewDidLoad:
//			Task {
//				await viewDidLoad()
//			}
//		case let .reloadCalendar(date):
//			Task {
//				await reloadCalendar(date: date)
//			}
//		case .didTapAddScheduleButton:
//			didTapAddScheduleButton()
//		case let .scheduleDiaryEditButtonTapped(schedule):
//			scheduleDiaryEditButtonTapped(schedule: schedule)
//		case let .scheduleEditButtonTapped(schedule):
//			scheduleEditButtonTapped(schedule: schedule)
//		}
//	}
//	
//	private func viewDidLoad() async {
//		let schedules = await scheduleUseCase.setCalendar()
//		
//		await MainActor.run {
//			state.calendarSchedules = schedules
//		}
//	}
//	
//	private func reloadCalendar(date: YearMonthDay?) async {
//		let schedules = await scheduleUseCase.setCalendar()
//		
//		await MainActor.run {
//			state.calendarSchedules = schedules
//			
//			if let date = date {
//				state.focusDate = date
//			}
//		}
//	}
//	
//	private func didTapAddScheduleButton() {
//		if let (startDate, endDate) = scheduleUseCase.newScheduleDate(focusDate: state.focusDate) {
//			scheduleState.currentSchedule.startDate = startDate
//			scheduleState.currentSchedule.endDate = endDate
//			state.isToDoSheetPresented = true
//		}
//	}
//	
//	private func scheduleDiaryEditButtonTapped(schedule: Schedule) {
//		DispatchQueue.main.async { [weak self] in
//			guard let self = self else {return}
//			self.setScheduleToCurrentSchedule(schedule: schedule)
//			self.scheduleState.isCurrentScheduleIsGroup = schedule.moimSchedule
//			
//			AppState.shared.isPersonalDiary = !schedule.moimSchedule
//			AppState.shared.isEditingDiary = schedule.hasDiary ?? false
//			
//			AppState.shared.navigationPath.append(
//				HomeNavigationType.editDiaryView(
//					memo: self.diaryState.currentDiary.contents ?? "",
//					images: self.diaryState.currentDiary.images ?? [],
//					info: ScheduleInfo(
//						scheduleId: schedule.scheduleId,
//						scheduleName: schedule.name,
//						date: schedule.startDate,
//						place: schedule.locationName,
//						categoryId: schedule.categoryId
//					)
//				)
//			)
//		}
//	}
//	
//	private func scheduleEditButtonTapped(schedule: Schedule) {
//		DispatchQueue.main.async { [weak self] in
//			guard let self = self else {return}
//			self.setScheduleToCurrentSchedule(schedule: schedule)
//			self.scheduleState.isGroup = schedule.moimSchedule
//			self.state.isToDoSheetPresented = true
//		}
//	}
//	
//	private func setScheduleToCurrentSchedule(schedule: Schedule) {
//		DispatchQueue.main.async { [weak self] in
//			guard let self = self else {return}
//			self.scheduleState.currentSchedule = ScheduleTemplate(
//				scheduleId: schedule.scheduleId,
//				name: schedule.name,
//				categoryId: schedule.categoryId,
//				startDate: schedule.startDate,
//				endDate: schedule.endDate,
//				alarmDate: schedule.alarmDate,
//				x: schedule.x,
//				y: schedule.y,
//				locationName: schedule.locationName
//			)
//		}
//	}
//	
//	
//}
