//
//  HomeMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import SwiftUICalendar
import Factory

struct HomeMainView: View {
	@EnvironmentObject var scheduleState: ScheduleState
	@Injected(\.scheduleInteractor) var scheduleInteractor
	@Injected(\.categoryInteractor) var categoryInteractor
	@StateObject var calendarController = CalendarController()
	
	@State var focusDate: YearMonthDay? = nil
	@State var showDatePicker: Bool = false
	@State var datePickerCurrentDate: Date = Date()
	@State var pickerCurrentYear: Int = Date().toYMD().year
	@State var pickerCurrentMonth: Int = Date().toYMD().month
    @State var isToDoSheetPresented: Bool = false
	
	let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	var body: some View {
		ZStack {
			VStack(spacing: 0) {
				header
					.padding(.bottom, 22)
				
				weekday
					.padding(.bottom, 11)
				
				CalendarView(calendarController) { date in
					CalendarItem(date: date, focusDate: $focusDate, calendarSchedule: $scheduleState.calendarSchedules)
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
			
				if showDatePicker {
					datePicker
				}
			
			if isToDoSheetPresented {
				Color.black.opacity(0.3)
					.ignoresSafeArea(.all, edges: .all)
			}
		}
		.ignoresSafeArea(edges: .bottom)
		.task {
			await scheduleInteractor.setCalendar()
			await categoryInteractor.getCategories()
		}
		.onChange(of: calendarController.yearMonth) { newYearMonth in
			if calendarController.yearMonth.year <= newYearMonth.year {
				if calendarController.yearMonth.month <= newYearMonth.month {
					scheduleInteractor.calendarScrollBackward(newYearMonth)
				} else {
					scheduleInteractor.calendarScrollForward(newYearMonth)
				}
			} else {
				scheduleInteractor.calendarScrollForward(newYearMonth)
			}
		}
        .fullScreenCover(isPresented: $isToDoSheetPresented, content: {
            ToDoEditView()
                .background(ClearBackground())
        })
	}
	
	private var header: some View {
		HStack {
			Button(action: {
				withAnimation {
					showDatePicker = true
				}
			}, label: {
				HStack(spacing: 10) {
					Text(
						scheduleInteractor.formatYearMonth(calendarController.yearMonth)
					)
					.font(.pretendard(.bold, size: 22))
					
					Image(.icChevronBottomBlack)
				}
			})
			.foregroundStyle(Color.black)

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
			
			
			
			ScrollView(.vertical) {
				HStack {
					Text("개인 일정")
						.font(.pretendard(.bold, size: 15))
						.foregroundStyle(Color(.mainText))
						.padding(.bottom, 11)
						.padding(.leading, 3)
					
					Spacer()
				}
				
				if let schedules = scheduleState.calendarSchedules[focusDate!]?
					.compactMap(({$0.schedule}))
					.filter({!$0.moimSchedule})
				{
					ForEach(schedules, id: \.self) { schedule in
                        CalendarScheduleDetailItem(
                            ymd: focusDate!,
                            schedule: schedule,
                            isToDoSheetPresented: self.$isToDoSheetPresented)
					}
				} else {
					Text("등록된 개인 일정이 없습니다.")
						.font(.pretendard(.medium, size: 14))
						.foregroundStyle(Color(.mainText))
				}
				
				HStack {
					Text("모임 일정")
						.font(.pretendard(.bold, size: 15))
						.foregroundStyle(Color(.mainText))
						.padding(.top, 20)
						.padding(.bottom, 11)
						.padding(.leading, 3)
					
					Spacer()
				}
				
				if let schedules = scheduleState.calendarSchedules[focusDate!]?
					.compactMap({$0.schedule})
					.filter({$0.moimSchedule})
				{
					ForEach(schedules, id: \.self) { schedule in
						CalendarScheduleDetailItem(ymd: focusDate!, schedule: schedule, isToDoSheetPresented: self.$isToDoSheetPresented)
					}
				} else {
					Text("등록된 모임 일정이 없습니다.")
						.font(.pretendard(.medium, size: 14))
						.foregroundStyle(Color(.mainText))
				}
				
			}
			.frame(width: screenWidth-50)
			.padding(.horizontal, 25)

				 
			
			Spacer(minLength: 0)
			
		}
		.frame(width: screenWidth, height: screenHeight * 0.47)
		.background(Color.white)
		.overlay(alignment: .bottomTrailing) {
			Button(action: {
                self.isToDoSheetPresented = true
            }, label: {
				Image(.floatingAdd)
					.padding(.bottom, 37)
					.padding(.trailing, 25)
			})
		}
	}
	
	private var datePicker: some View {
		NamoAlertView(
			showAlert: $showDatePicker,
			content: AnyView(
				HStack(spacing: 0) {
					Picker("", selection: $pickerCurrentYear) {
						ForEach(2000...2099, id: \.self) {
							Text("\(String($0))년")
								.font(.pretendard(.regular, size: 23))
						}
					}
					.pickerStyle(.inline)
					
					Picker("", selection: $pickerCurrentMonth) {
						ForEach(1...12, id: \.self) {
							Text("\(String($0))월")
								.font(.pretendard(.regular, size: 23))
						}
					}
					.pickerStyle(.inline)
				}
				.frame(height: 154)
			),
			leftButtonTitle: "취소",
			leftButtonAction: {
				pickerCurrentYear = calendarController.yearMonth.year
				pickerCurrentMonth = calendarController.yearMonth.month
			},
			rightButtonTitle: "확인",
			rightButtonAction: {
				calendarController.scrollTo(YearMonth(year: pickerCurrentYear, month: pickerCurrentMonth))
			}
		)
	}
	
	
}

#Preview {
	HomeMainView()
}
