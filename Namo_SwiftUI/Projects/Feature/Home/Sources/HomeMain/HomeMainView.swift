//
//  HomeMainView.swift
//  FeatureHome
//
//  Created by 정현우 on 9/18/24.
//

import SwiftUI

import ComposableArchitecture
import SwiftUICalendar

import SharedUtil
import SharedDesignSystem

public struct HomeMainView: View {
	@Perception.Bindable public var store: StoreOf<HomeMainStore>
	@StateObject var calendarController = CalendarController()
	
	let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	public init(store: StoreOf<HomeMainStore>) {
		self.store = store
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			header
				.padding(.bottom, 22)
				.padding(.horizontal, 20)
			
			weekday
				.padding(.bottom, 11)
			
			NamoCalendarView(
				calendarController: calendarController,
				focusDate: $store.focusDate,
				dateTapAction: { date in
					store.send(.selectDate(date), animation: .default)
				}
			)
			.padding(.leading, 14)
			.padding(.horizontal, 6)
			.padding(.top, 3)
			
			if store.focusDate != nil {
				detailView
					.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
					.shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
			}
			
			Spacer()
				.frame(height: tabBarHeight)
			
		}
		.ignoresSafeArea(edges: .bottom)
//		.onAppear {
//			store.send(.getSchedule(ym: calendarController.yearMonth))
//		}
//		.onChange(of: calendarController.yearMonth) { newYM in
//			if calendarController.yearMonth < newYM {
//				// 다음달로
//				store.send(.scrollForwardTo(ym: newYM))
//			} else {
//				// 이전달로
//				store.send(.scrollBackwardTo(ym: newYM))
//			}
//		}
	}
	
	private var header: some View {
		HStack {
			// datepicker
			Button(
				action: {
					store.send(.datePickerTapped)
				}, label: {
					HStack(spacing: 10) {
						Text(calendarController.yearMonth.formatYYYYMM())
							.font(.pretendard(.bold, size: 22))
							.foregroundStyle(Color.colorBlack)
					}
				}
			)
			
			Spacer()
			
			// 보관함
			Button(
				action: {
					store.send(.archiveTapped)
				}, label: {
					Image(asset: SharedDesignSystemAsset.Assets.icArchive)
						.resizable()
						.frame(width: 24, height: 24)
				}
			)
			.padding(.trailing, 20)
			
			// 오늘 날짜로
			Button(
				action: {
					calendarController.scrollTo(.current, isAnimate: true)
				}, label: {
					Text(Date().toDD())
						.font(.pretendard(.semibold, size: 16))
						.background(
							RoundedRectangle(cornerRadius: 5)
								.stroke(.black, lineWidth: 1.5)
								.frame(width: 25, height: 25)
						)
				}
			)
			.tint(Color.colorBlack)
			
		}
	}
	
	private var weekday: some View {
		VStack(alignment: .leading) {
			HStack {
				ForEach(weekdays, id: \.self) { weekday in
					Text(weekday)
						.font(.pretendard(.bold, size: 12))
						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.textUnselected))
					
					Spacer()
				}
			}
			.padding(.leading, 14)
			.padding(.trailing, 6)
		}
		.frame(height: 30)
		.background(
			Rectangle()
				.fill(Color.white)
				.shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 8)
		)
	}
	
	private var calendar: some View {
		GeometryReader { reader in
			VStack {
				CalendarView(calendarController) { date in
					GeometryReader { geometry in
						VStack(alignment: .leading) {
							calendarDate(date: date)
								.onTapGesture {
									store.send(.selectDate(date), animation: .default)
								}
						}
						.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
					}
				}
			}
		}
	}
	
	private func calendarDate(date: YearMonthDay) -> some View {
		GeometryReader { geometry in
			if date.isToday {
				Text("\(date.day)")
					.font(.pretendard(.bold, size: 12))
					.foregroundStyle(Color.white)
					.background(
						Circle()
							.fill(
								(date.isFocusYearMonth ?? false)
								? Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
								: Color(asset: SharedDesignSystemAsset.Assets.mainOrange).opacity(0.5))
							.frame(width: 18, height: 18)
					)
			} else {
				Text("\(date.day)")
					.font(.pretendard(.bold, size: 12))
					.foregroundStyle(
						store.state.focusDate == date
						? Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
						: (date.isFocusYearMonth ?? true)
							? Color.black
							: Color(asset: SharedDesignSystemAsset.Assets.textUnselected)
					)
			}
		}
	}
	
	private var detailView: some View {
		let focusDate = store.state.focusDate!
		
		return VStack(spacing: 0) {
			Text(String(format: "%02d.%02d (%@)", focusDate.month, focusDate.day, focusDate.getShortWeekday()))
				.font(.pretendard(.bold, size: 22))
				.padding(.vertical, 20)
			
			ScrollView(.vertical, showsIndicators: false) {
				detailViewPersonalSchedule
					.padding(.bottom, 32)
				
				detailViewMeetingSchedule
			}
		}
	}
	
	private var detailViewPersonalSchedule: some View {
		VStack {
			HStack {
				Text("개인 일정")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
					.padding(.bottom, 11)
					.padding(.leading, 3)
				
				Spacer()
			}
			
			// 개인 일정
			if let schedules = store.schedules[store.state.focusDate!]?.compactMap({$0.schedule}).filter({!$0.isMeetingSchedule}),
			   !schedules.isEmpty
			{
				ForEach(schedules, id: \.self) { schedule in
					NamoCalendarDetailScheduleItem(
						ymd: store.focusDate!,
						schedule: schedule,
						diaryEditAction: {
							
						}
					)
				}
			} else {
				HStack(spacing: 12) {
					Rectangle()
						.fill(Color(asset: SharedDesignSystemAsset.Assets.textPlaceholder))
						.frame(width: 3, height: 21)
					
					Text("등록된 개인 일정이 없습니다.")
						.font(.pretendard(.medium, size: 14))
						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.textDisabled))
					
					Spacer()
				}
			}
		}
	}
	
	private var detailViewMeetingSchedule: some View {
		VStack {
			HStack {
				Text("모임 일정")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
					.padding(.bottom, 11)
					.padding(.leading, 3)
				
				Spacer()
			}
			
			// 개인 일정
			if let schedules = store.schedules[store.state.focusDate!]?.compactMap({$0.schedule}).filter({$0.isMeetingSchedule}),
			   !schedules.isEmpty
			{
				ForEach(schedules, id: \.self) { schedule in
					NamoCalendarDetailScheduleItem(
						ymd: store.focusDate!,
						schedule: schedule,
						diaryEditAction: {
							
						}
					)
				}
			} else {
				HStack(spacing: 12) {
					Rectangle()
						.fill(Color(asset: SharedDesignSystemAsset.Assets.textPlaceholder))
						.frame(width: 3, height: 21)
					
					Text("등록된 모임 일정이 없습니다.")
						.font(.pretendard(.medium, size: 14))
						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.textDisabled))
					
					Spacer()
				}
			}
		}
	}

}
