//
//  NamoCalendarView.swift
//  FeatureCalendar
//
//  Created by 정현우 on 10/2/24.
//

import SwiftUI

import SwiftUICalendar

import SharedDesignSystem
import DomainSchedule

public struct NamoCalendarView: View {
	@ObservedObject var calendarController: CalendarController
	// 현재 포커싱된(detailView) 날짜
	@Binding var focusDate: YearMonthDay?
	// 캘린더에 표시할 스케쥴
	@Binding var schedules: [YearMonthDay: [CalendarSchedule]]
	// 상단에 요일을 보이게 할지
	let showWeekDay: Bool
	// 하단 detail view를 보이게 할지
	let showDetailView: Bool
	// 특정 달을 선택했을때
	let dateTapAction: (YearMonthDay) -> Void
	
	private let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	public init(
		calendarController: CalendarController,
		focusDate: Binding<YearMonthDay?> = .constant(nil),
		schedules: Binding<[YearMonthDay: [CalendarSchedule]]> = .constant([:]),
		showWeekDay: Bool = true,
		showDetailView: Bool = true,
		dateTapAction: @escaping (YearMonthDay) -> Void
	) {
		self.calendarController = calendarController
		self._focusDate = focusDate
		self._schedules = schedules
		self.showWeekDay = showWeekDay
		self.showDetailView = showDetailView
		self.dateTapAction = dateTapAction
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			if showWeekDay {
				weekday
					.padding(.bottom, 11)
			}
			
			GeometryReader { reader in
				VStack {
					CalendarView(calendarController) { date in
						GeometryReader { geometry in
							VStack(alignment: .leading) {
								calendarDate(date: date)
									.onTapGesture {
										dateTapAction(date)
										print(date)
									}
							}
							.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
						}
					}
				}
			}
			
			if showDetailView && focusDate != nil {
				detailView
					.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
					.shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
			}
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
						focusDate == date
						? Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
						: (date.isFocusYearMonth ?? true)
							? Color.black
							: Color(asset: SharedDesignSystemAsset.Assets.textUnselected)
					)
			}
		}
	}
	
	private var detailView: some View {
		let focusDate = focusDate!
		
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
			if let schedules = schedules[focusDate!]?.compactMap({$0.schedule}).filter({!$0.isMeetingSchedule}),
			   !schedules.isEmpty
			{
				ForEach(schedules, id: \.self) { schedule in
					NamoCalendarDetailScheduleItem(
						ymd: focusDate!,
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
			if let schedules = schedules[focusDate!]?.compactMap({$0.schedule}).filter({$0.isMeetingSchedule}),
			   !schedules.isEmpty
			{
				ForEach(schedules, id: \.self) { schedule in
					NamoCalendarDetailScheduleItem(
						ymd: focusDate!,
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
