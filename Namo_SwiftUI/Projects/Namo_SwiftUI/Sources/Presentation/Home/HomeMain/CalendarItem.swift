//
//  CalendarItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/4/24.
//

import SwiftUI
import SwiftUICalendar
import Factory

// 캘린더에 표시되는 아이템
struct CalendarItem: View {
	@EnvironmentObject var appState: AppState
	@EnvironmentObject var moimState: MoimState
	let categoryUseCase = CategoryUseCase.shared
	let MAX_SCHEDULE = screenHeight < 800 ? 3 : 4
	
	let date: YearMonthDay
	let schedule: [CalendarSchedule]
	
	let isMoimCalendar: Bool
	@Binding var focusDate: YearMonthDay?
	
	var body: some View {
		GeometryReader { geometry in
			VStack(alignment: .leading, spacing: 4) {
				if date.isToday {
					Text("\(date.day)")
						.font(.pretendard(.bold, size: 12))
						.foregroundStyle(Color.white)
						.background(
							Circle()
								.fill((date.isFocusYearMonth ?? false) ? Color(.mainOrange) : Color(.mainOrange).opacity(0.5))
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
				
				if !isMoimCalendar {
					let schedules = schedule.filter({
					   if focusDate == nil {
						   return $0.position >= 0 && $0.position < MAX_SCHEDULE
					   } else {
						   // 탭바 높이때문에 1개 덜 보이도록
						   return $0.position >= 0 && $0.position < MAX_SCHEDULE-1
					   }
				   })
					calendarScheduleItem(geometry: geometry, schedules: schedules)
				} else if isMoimCalendar, let schedules = moimState.currentMoimSchedule[date]?.filter({ $0.position >= 0 && $0.position < MAX_SCHEDULE }) {
					calendarMoimScheduleItem(geometry: geometry, schedules: schedules)
				}
			
				if !isMoimCalendar && focusDate == nil, schedule.count > MAX_SCHEDULE {
					HStack {
						Spacer()
						Text("+\(schedule.count - MAX_SCHEDULE)")
							.font(.pretendard(.semibold, size: 8))
							.foregroundStyle(Color(.mainText))
						Spacer()
					}
				} else if isMoimCalendar && focusDate == nil, let count = moimState.currentMoimSchedule[date]?.count, count > MAX_SCHEDULE {
					HStack {
						Spacer()
						Text("+\(count - MAX_SCHEDULE)")
							.font(.pretendard(.semibold, size: 8))
							.foregroundStyle(Color(.mainText))
						Spacer()
					}
				}
			}
			.padding(.top, 4)
			.padding(.leading, 5)
		}
		.contentShape(Rectangle())
		.onTapGesture {
			withAnimation {
				if focusDate == nil || focusDate != date {
					focusDate = date
				} else {
					focusDate = nil
				}
			}
		}
	}
	
	private func calendarScheduleItem(geometry: GeometryProxy, schedules: [CalendarSchedule]) -> some View {
		VStack(alignment: .leading, spacing: focusDate == nil ? 4 : 2) {
			ForEach(schedules.indices, id: \.self) { index in
				if let schedule = schedules[index].schedule {
					let color = categoryUseCase.getColorWithPaletteId(id: appState.categoryPalette[schedule.categoryId] ?? 0)
					// 캘린더 펼친 상태
					if focusDate == nil {
						// 현재 날이 시작일이라면
						if date == schedule.startDate.toYMD() {
							// 현재 날이 시작일인 동시에 마지막 날이라면 -> 하루 짜리 스케쥴
							if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
								CalendarScheduleItem(
									calendarScheduleItemype: .onlyOneDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								// 여러 일 지속 스케쥴의 시작부분인데 토요일(주의 마지막)인 경우 오른쪽 코너 주기
								if date.dayOfWeek == .sat {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDayWithRightCorner,
										isLargeItem: true,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: schedule.name
									)
								} else {
									// 여러일 지속 스케쥴의 시작부분
									CalendarScheduleItem(
										calendarScheduleItemype: .startDay,
										isLargeItem: true,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: schedule.name
									)
								}
							}
						} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
							// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
							if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDayWithLeftCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
							
						} else {
							// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
							if date.dayOfWeek == .sat {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithRightCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithLeftCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
						}
					} else {
						// 스케쥴 자세히 보기 상태
						if date == schedule.startDate.toYMD() {
							if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
								// 만약 하루짜리 스케쥴이면 -> 한개짜리 스케쥴 item
								CalendarScheduleItem(
									calendarScheduleItemype: .onlyOneDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								// 여러 일 지속 스케쥴 -> 시작 부분(왼쪽만 radius)
								if date.dayOfWeek == .sat {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDayWithRightCorner,
										isLargeItem: false,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: nil
									)
								} else {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDay,
										isLargeItem: false,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: nil
									)
								}
							}
						} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
							// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
							if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDayWithLeftCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
						} else {
							// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
							if date.dayOfWeek == .sat {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithRightCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithLeftCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
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
	
	// TODO: 위의 calendarScheduleItem와 중복해서 구현하지 않을 방법?
	private func calendarMoimScheduleItem(geometry: GeometryProxy, schedules: [CalendarMoimSchedule]) -> some View {
		VStack(alignment: .leading, spacing: focusDate == nil ? 4 : 2) {
			ForEach(schedules.indices, id: \.self) { index in
				if let schedule = schedules[index].schedule {
					let color = schedule.curMoimSchedule ?
					Color.mainOrange :
					categoryUseCase.getColorWithPaletteId(id: schedule.users.first?.color ?? 0)
					// 캘린더 펼친 상태
					if focusDate == nil {
						// 현재 날이 시작일이라면
						if date == schedule.startDate.toYMD() {
							// 현재 날이 시작일인 동시에 마지막 날이라면 -> 하루 짜리 스케쥴
							if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
								CalendarScheduleItem(
									calendarScheduleItemype: .onlyOneDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								// 여러 일 지속 스케쥴의 시작부분인데 토요일(주의 마지막)인 경우 오른쪽 코너 주기
								if date.dayOfWeek == .sat {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDayWithRightCorner,
										isLargeItem: true,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: schedule.name
									)
								} else {
									// 여러일 지속 스케쥴의 시작부분
									CalendarScheduleItem(
										calendarScheduleItemype: .startDay,
										isLargeItem: true,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: schedule.name
									)
								}
							}
						} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
							// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
							if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDayWithLeftCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
							
						} else {
							// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
							if date.dayOfWeek == .sat {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithRightCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithLeftCorner,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: schedule.name
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDay,
									isLargeItem: true,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
						}
					} else {
						// 스케쥴 자세히 보기 상태
						if date == schedule.startDate.toYMD() {
							if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
								// 만약 하루짜리 스케쥴이면 -> 한개짜리 스케쥴 item
								CalendarScheduleItem(
									calendarScheduleItemype: .onlyOneDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								// 여러 일 지속 스케쥴 -> 시작 부분(왼쪽만 radius)
								if date.dayOfWeek == .sat {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDayWithRightCorner,
										isLargeItem: false,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: nil
									)
								} else {
									CalendarScheduleItem(
										calendarScheduleItemype: .startDay,
										isLargeItem: false,
										backgroundColor: color,
										geometryWidth: geometry.size.width,
										isFocusYearMonth: date.isFocusYearMonth ?? true,
										scheduleName: nil
									)
								}
							}
						} else if date == schedule.endDate.adjustDateIfMidNight().toYMD() {
							// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
							if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDayWithLeftCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .endDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							}
						} else {
							// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
							if date.dayOfWeek == .sat {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithRightCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else if date.dayOfWeek == .sun {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDayWithLeftCorner,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
							} else {
								CalendarScheduleItem(
									calendarScheduleItemype: .midDay,
									isLargeItem: false,
									backgroundColor: color,
									geometryWidth: geometry.size.width,
									isFocusYearMonth: date.isFocusYearMonth ?? true,
									scheduleName: nil
								)
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
