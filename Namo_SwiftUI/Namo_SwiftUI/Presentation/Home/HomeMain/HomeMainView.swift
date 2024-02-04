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
//	@StateObject var vm = HomeMainViewModel()
	
	@State var calendarSchedule: [YearMonthDay: [CalendarSchedule]] = [:]
	@State var focusDate: YearMonthDay? = nil
	
	let scheduleInteractor = ScheduleInteractorImpl()
	
	let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	var body: some View {
		VStack(spacing: 0) {
			header
				.padding(.bottom, 22)
			
			weekday
				.padding(.bottom, 11)
			
			CalendarView(calendarController) { date in
				CalendarItem(date: date, focusDate: $focusDate, calendarSchedule: $calendarSchedule)
			}
			.frame(width: screenWidth-20)
			.padding(.leading, 14)
			.padding(.trailing, 6)
			.padding(.bottom, 20)
			
			if focusDate != nil {
				detailView
					.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
					.shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
			} else {
				Spacer(minLength: 0)
					.frame(height: tabBarHeight)
			}
			
		}
		.ignoresSafeArea(edges: .bottom)
		.onAppear {
			scheduleInteractor.setCalendar(schedules: self.$calendarSchedule)
		}
	}
	
	private var header: some View {
		HStack(spacing: 10) {
			Text(
				scheduleInteractor.formatYearMonth(calendarController.yearMonth)
			)
			.font(.pretendard(.bold, size: 22))
			
			Image(.icChevronBottomBlack)
			
			Spacer()
			
			Text(scheduleInteractor.getCurrentDay())
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
	
	private var detailView: some View {
		VStack(spacing: 0) {
			Text(String(format: "%02d.%02d (%@)", focusDate!.month, focusDate!.day, focusDate!.getShortWeekday()))
				.font(.pretendard(.bold, size: 22))
				.padding(.vertical, 20)
			
			
			if let schedules = calendarSchedule[focusDate!]?.compactMap({$0.schedule}) {
				ScrollView(.vertical) {
					HStack {
						Text("개인 일정")
							.font(.pretendard(.bold, size: 15))
							.foregroundStyle(Color(.mainText))
							.padding(.bottom, 11)
							.padding(.leading, 3)
						
						Spacer()
					}
					
					ForEach(schedules, id: \.self) { schedule in
						CalendarScheduleDetailItem(ymd: focusDate!, schedule: schedule, scheduleInteractor: scheduleInteractor)
					}
				}
				.frame(width: screenWidth-50)
				.padding(.horizontal, 25)

				
			} else {
				Text("이 날 일정 없어용")
			}
			
			Spacer(minLength: 0)
			
		}
		.frame(width: screenWidth, height: screenHeight * 0.47)
		.background(Color.white)
	}
	
	
}

#Preview {
	HomeMainView()
}

struct CalendarScheduleDetailItem: View {
	let ymd: YearMonthDay
	let schedule: DummySchedule
	let scheduleInteractor: ScheduleInteractor
	
	var body: some View {
		HStack(spacing: 15) {
			Rectangle()
				.fill(Color(hex: schedule.color))
				.frame(width: 30, height: 55)
				.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .bottomLeft]))
			
			VStack(alignment: .leading, spacing: 4) {
//				Text("11:00 - 13:00")
				Text(scheduleInteractor.getScheduleTimeWithCurrentYMD(currentYMD: ymd, schedule: schedule))
					.font(.pretendard(.medium, size: 12))
					.foregroundStyle(Color(.mainText))
				
				Text(schedule.name)
					.font(.pretendard(.bold, size: 15))
			}
			
			Spacer()
			
			Button(action: {}, label: {
				Image(.btnAddRecord)
					.resizable()
					.frame(width: 34, height: 34)
					.padding(.trailing, 11)
			})
			
		}
		.frame(width: screenWidth-50, height: 55)
		.background(
			RoundedRectangle(cornerRadius: 15)
				.fill(Color(.textBackground))
				.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
		)
	}
}


