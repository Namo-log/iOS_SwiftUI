//
//  CalendarItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/4/24.
//

import SwiftUI
import SwiftUICalendar

// 캘린더에 표시되는 아이템
struct CalendarItem: View {
	let date: YearMonthDay
	
	@EnvironmentObject var appState: AppState
	
	@Binding var focusDate: YearMonthDay?
	@Binding var calendarSchedule: [YearMonthDay: [CalendarSchedule]]
	
	var body: some View {
		GeometryReader { geometry in
			VStack(alignment: .leading, spacing: 4) {
				if date.isToday {
					Text("\(date.day)")
						.font(.pretendard(.bold, size: 12))
						.foregroundStyle(Color.white)
						.background(
							Circle()
								.fill((date.isFocusYearMonth ?? false) ? Color(.mainOrange) : Color(.textUnselected))
								.frame(width: 18, height: 18)
						)
					
				} else {
					Text("\(date.day)")
						.font(.pretendard(.bold, size: 12))
						.foregroundStyle(
							focusDate == date ? Color(.mainOrange) :
							(date.isFocusYearMonth ?? true) ? Color.black : Color(.textUnselected)
						)
				}
				
				if let schedules = calendarSchedule[date]?.filter({ $0.position >= 0 && $0.position < MAX_SCHEDULE }) {
					VStack(alignment: .leading, spacing: focusDate == nil ? 4 : 2) {
						ForEach(schedules.indices, id: \.self) { index in
							if let schedule = schedules[index].schedule {
								// 캘린더 펼친 상태
								if focusDate == nil {
									// 현재 날이 시작일이라면
									if date == schedule.startDate.toYMD() {
										// 현재 날이 시작일인 동시에 마지막 날이라면 -> 하루 짜리 스케쥴
										if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
											CalendarScheduleItem(calendarScheduleItemype: .onlyOneDay, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name)
										} else {
											// 여러 일 지속 스케쥴의 시작부분인데 토요일(주의 마지막)인 경우 오른쪽 코너 주기
											if date.dayOfWeek == .sat {
												CalendarScheduleItem(calendarScheduleItemype: .startDayWithRightCorner, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name)
											} else {
												// 여러일 지속 스케쥴의 시작부분
												CalendarScheduleItem(calendarScheduleItemype: .startDay, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name)
											}
										}
									} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
										// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
										if date.dayOfWeek == .sun {
											CalendarScheduleItem(calendarScheduleItemype: .endDayWithLeftCorner, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name)
										} else {
											CalendarScheduleItem(calendarScheduleItemype: .endDay, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										}
										
									} else {
										// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
										if date.dayOfWeek == .sat {
											CalendarScheduleItem(calendarScheduleItemype: .midDayWithRightCorner, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										} else if date.dayOfWeek == .sun {
											CalendarScheduleItem(calendarScheduleItemype: .midDayWithLeftCorner, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name)
										} else {
											CalendarScheduleItem(calendarScheduleItemype: .midDay, isLargeItem: true, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										}
									}
								} else {
									// 스케쥴 자세히 보기 상태
									if date == schedule.startDate.toYMD() {
										if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
											// 만약 하루짜리 스케쥴이면 -> 한개짜리 스케쥴 item
											CalendarScheduleItem(calendarScheduleItemype: .onlyOneDay, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										} else {
											// 여러 일 지속 스케쥴 -> 시작 부분(왼쪽만 radius)
											if date.dayOfWeek == .sat {
												CalendarScheduleItem(calendarScheduleItemype: .startDayWithRightCorner, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
											} else {
												CalendarScheduleItem(calendarScheduleItemype: .startDay, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
											}
										}
									} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
										// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
										if date.dayOfWeek == .sun {
											CalendarScheduleItem(calendarScheduleItemype: .endDayWithLeftCorner, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										} else {
											CalendarScheduleItem(calendarScheduleItemype: .endDay, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										}
									} else {
										// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
										if date.dayOfWeek == .sat {
											CalendarScheduleItem(calendarScheduleItemype: .midDayWithRightCorner, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										} else if date.dayOfWeek == .sun {
											CalendarScheduleItem(calendarScheduleItemype: .midDayWithLeftCorner, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										} else {
											CalendarScheduleItem(calendarScheduleItemype: .midDay, isLargeItem: false, color: schedule.color, geometryWidth: geometry.size.width, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil)
										}
									}
								}
							} else {
								// schedule이 nil인 경우 빈 공간
								RoundedRectangle(cornerRadius: 3)
									.fill(Color.clear)
									.frame(height: focusDate == nil ? 12 : 4)
							}
							
						}
					}
				}
			}
			.padding(.top, 2)
			.padding(.leading, 5)
		}
		.contentShape(Rectangle())
		.onTapGesture {
			withAnimation {
				if focusDate == nil || focusDate != date {
					focusDate = date
					appState.isTabbarHidden = true
				} else {
					focusDate = nil
					appState.isTabbarHidden = false
				}
			}
		}
	}
}
