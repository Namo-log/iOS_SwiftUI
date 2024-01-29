//
//  HomeMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import SwiftUICalendar

struct HomeMainView: View {
	@StateObject var calendarController = CalendarController()
	@StateObject var vm = HomeMainViewModel()
	
	@State var focusDate: YearMonthDay? = nil
	
	let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	var body: some View {
		VStack(spacing: 0) {
			header
				.padding(.bottom, 22)
			
			weekday
				.padding(.bottom, 11)
			
			CalendarView(calendarController) { date in
				GeometryReader { geometry in
					VStack(alignment: .leading, spacing: 4) {
						if date.isToday {
							Text("\(date.day)")
								.font(.pretendard(.bold, size: 12))
								.foregroundStyle(Color.white)
								.background(
									Circle()
										.fill((date.isFocusYearMonth ?? false) ? Color(.mainOrange) : Color.clear)
										.frame(width: 18, height: 18)
								)
						} else {
							Text("\(date.day)")
								.font(.pretendard(.bold, size: 12))
								.foregroundStyle(
									(date.isFocusYearMonth ?? true) ? Color.black : Color(.textUnselected)
								)
						}
						
						if let schedules = vm.mySchedules[date]?.filter({ $0.position >= 0 && $0.position <= 2 }) {
							VStack(alignment: .leading, spacing: 3) {
								ForEach(schedules.indices, id: \.self) { index in
									if let schedule = schedules[index].schedule {
										if focusDate == nil {
											// only calendar
											if date == vm.getYMD(schedule.startDate) {
												if date == vm.getYMD(schedule.endDate) {
													// 만약 하루짜리 스케쥴이면 -> 한개짜리 스케쥴 item
													CalendarItem(color: schedule.color, width: geometry.size.width - 8, height: 12, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name, corners: .allCorners)
												} else {
													// 여러 일 지속 스케쥴 -> 시작 부분(왼쪽만 radius)
													CalendarItem(color: schedule.color, width: geometry.size.width + 4, height: 12, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: schedule.name, corners: [.bottomLeft, .topLeft])
												}
											} else if date == vm.getYMD(schedule.endDate) {
												// 여러 일 지속 스케쥴 -> 끝 부분(오른쪽만 radius)
												CalendarItem(color: schedule.color, width: geometry.size.width, height: 12, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil, corners: [.bottomRight, .topRight])
												
											} else {
												// 여러 일 지속 스케쥴 -> 중간 부분(no radius)
												CalendarItem(color: schedule.color, width: geometry.size.width + 4, height: 12, isFocusYearMonth: date.isFocusYearMonth ?? true, scheduleName: nil, corners: .allCorners)
											}
										} else {
											// 스케쥴 자세히 보기 상태
											if date.toDate() == schedule.startDate {
												
											} else if date.toDate() == schedule.endDate {
												
											} else {
												
											}
										}
									} else {
										// schedule이 nil인 경우 빈 공간
										RoundedRectangle(cornerRadius: 3)
											.fill(Color.clear)
											.frame(height: focusDate == nil ? 12 : 3)
									}
									
								}
							}
						}
					}
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
			.padding(.leading, 20)
			.padding(.trailing, 10)
			
//			if focusDate != nil {
//				VStack {
//					if let schedules = vm.mySchedules[focusDate!] {
//						ForEach(schedules, id: \.scheduleId) { schedule in
//							Text(schedule.name)
//						}
//					} else {
//						Text("이 날 일정 없어용")
//					}
//				}
//				.frame(height: 180)
//
//			}
			
			Spacer(minLength: 0)
				.frame(height: tabBarHeight)
			
			
		}
		.onAppear {
			vm.getSchedules()
			
		}
	}
	
	private var header: some View {
		HStack(spacing: 10) {
			Text(
				vm.formatYearMonth(
					year: calendarController.yearMonth.year,
					month: calendarController.yearMonth.month
				)
			)
			.font(.pretendard(.bold, size: 22))
			
			Image(.icChevronBottomBlack)
			
			Spacer()
			
			Text(vm.getCurrentDay())
				.font(.pretendard(.semibold, size: 16))
				.background(
					RoundedRectangle(cornerRadius: 5)
						.stroke(.black, lineWidth: 1.5)
						.frame(width: 25, height: 25)
				)
				.onTapGesture {
					calendarController.scrollTo(YearMonth.current)
				}
			
			
		}
		.padding(.top, 15)
		.padding(.horizontal, 20)
	}
	
	private var weekday: some View {
		VStack(alignment: .leading) {
			HStack {
				ForEach(weekdays, id: \.self) { weekday in
					Text(weekday)
						.font(.pretendard(.bold, size: 12))
						.foregroundStyle(Color(.textUnselected))
					
					Spacer()
				}
			}
			.padding(.horizontal, 20)
		}
		.frame(height: 30)
		.background(
			Rectangle()
				.fill(Color.white)
				.shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 8)
		)
	}
	
	
}

#Preview {
	HomeMainView()
}

struct CalendarItem: View {
	let color: String
	let width: CGFloat
	let height: CGFloat
	let isFocusYearMonth: Bool
	let scheduleName: String?
	let corners: UIRectCorner
	
	var body: some View {
		ZStack(alignment: .leading) {
			Rectangle()
				.fill(Color(hex: color))
				.clipShape(RoundedCorners(radius: 3, corners: corners)
				)
				.frame(width: width, height: height)
//				.opacity(isFocusYearMonth ? 1 : 0.5)
			
			if let scheduleName = scheduleName {
				HStack(spacing: 0) {
					Text(scheduleName)
						.lineLimit(1)
						.font(.pretendard(.bold, size: 8))
						.foregroundStyle(Color.white)
						.padding(.leading, 2)
						.padding(.trailing, 6)
					
					Spacer(minLength: 0)
				}
			}
		}
	}
}
