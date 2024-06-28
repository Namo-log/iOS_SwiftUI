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
	@State var previousYearMonth: YearMonth = Date().toYM()
	@State var isScrolling: Bool = false
	
	let weekdays: [String] = ["일", "월", "화", "수", "목", "금", "토"]
	
	var body: some View {
		ZStack {
			VStack(spacing: 0) {
				header
					.padding(.bottom, 22)
				
				weekday
					.padding(.bottom, 11)
				
				GeometryReader { reader in
					VStack {
						CalendarView(calendarController) { date in
							GeometryReader { geometry in
								VStack(alignment: .leading) {
									CalendarItem(date: date, isMoimCalendar: false, focusDate: $focusDate)
								}
								.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
							}
						}
					}
				}
				.padding(.leading, 14)
				.padding(.horizontal, 6)
				.padding(.top, 3)
				
				if focusDate != nil {
					detailView
						.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
						.shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
					
				}
				
				Spacer(minLength: 0)
					.frame(height: tabBarHeight)
					
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
//			await scheduleInteractor.setCalendar()
            
            if UserDefaults.standard.bool(forKey: "isLogin") {
                await categoryInteractor.getCategories()
            }
		}
		.onChange(of: calendarController.yearMonth) { newYearMonth in
			if previousYearMonth.year <= newYearMonth.year {
				if previousYearMonth.month <= newYearMonth.month {
					scheduleInteractor.calendarScrollBackward(newYearMonth)
				} else {
					scheduleInteractor.calendarScrollForward(newYearMonth)
				}
			} else {
				scheduleInteractor.calendarScrollForward(newYearMonth)
			}
			
			previousYearMonth = newYearMonth
		}
		.onReceive(NotificationCenter.default.publisher(for: .reloadCalendarViaNetwork)) { notification in
			if let userInfo = notification.userInfo, let date = userInfo["date"] as? YearMonthDay {
				Task {
					await scheduleInteractor.setCalendar(date: date.toDate())
				}
				calendarController.scrollTo(YearMonth(year: date.year, month: date.month))
				focusDate = date
			} else {
				Task {
					await scheduleInteractor.setCalendar(date: focusDate?.toDate() ?? Date())
				}
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
					if !isScrolling {
						isScrolling = true
						calendarController.scrollTo(YearMonth.current)
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
							self.isScrolling = false
						}
					}
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
	
	private var detailView: some View {
		VStack(spacing: 0) {
			Text(String(format: "%02d.%02d (%@)", focusDate!.month, focusDate!.day, focusDate!.getShortWeekday()))
				.font(.pretendard(.bold, size: 22))
				.padding(.vertical, 20)
			
			
			
			ScrollView(.vertical, showsIndicators: false) {
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
					.filter({!$0.moimSchedule}),
				   !schedules.isEmpty
				{
					ForEach(schedules, id: \.self) { schedule in
                        CalendarScheduleDetailItem(
                            ymd: focusDate!,
                            schedule: schedule,
                            isToDoSheetPresented: self.$isToDoSheetPresented)
					}
				} else {
					HStack(spacing: 12) {
						Rectangle()
							.fill(Color.textPlaceholder)
							.frame(width: 3, height: 21)
						
						Text("등록된 개인 일정이 없습니다.")
							.font(.pretendard(.medium, size: 14))
							.foregroundStyle(Color(.textDisabled))
						
						Spacer()
					}
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
					.filter({$0.moimSchedule}),
				   !schedules.isEmpty
				{
					ForEach(schedules, id: \.self) { schedule in
						CalendarScheduleDetailItem(ymd: focusDate!, schedule: schedule, isToDoSheetPresented: self.$isToDoSheetPresented)
					}
				} else {
					HStack(spacing: 12) {
						Rectangle()
							.fill(Color.textPlaceholder)
							.frame(width: 3, height: 21)
						
						Text("등록된 모임 일정이 없습니다.")
							.font(.pretendard(.medium, size: 14))
							.foregroundStyle(Color(.textDisabled))
						
						Spacer()
					}
				}
				
				Spacer()
					.frame(height: 100)
			}
			.frame(width: screenWidth-50)
			.padding(.horizontal, 25)

				 
			
			Spacer(minLength: 0)
			
		}
		.frame(width: screenWidth, height: screenHeight * 0.38)
		.background(Color.white)
		.overlay(alignment: .bottomTrailing) {
			Button(action: {
                scheduleInteractor.setDateAndTimesToCurrentSchedule(focusDate: focusDate)
                self.isToDoSheetPresented = true
            }, label: {
				Image(.floatingAdd)
					.padding(.bottom, 37)
					.padding(.trailing, 25)
			})
		}
	}
	
	private var datePicker: some View {
		AlertViewOld(
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
			},
			rightButtonTitle: "확인",
			rightButtonAction: {
				// scroll이 dismiss된 이후에 동작해야 animation이 활성화됩니다.
				DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
					calendarController.scrollTo(YearMonth(year: pickerCurrentYear, month: pickerCurrentMonth))
				}
			}
		)
		.onAppear {
			pickerCurrentYear = calendarController.yearMonth.year
			pickerCurrentMonth = calendarController.yearMonth.month
		}
	}
	
	
}

#Preview {
	HomeMainView()
		.environmentObject(ScheduleState())
}
