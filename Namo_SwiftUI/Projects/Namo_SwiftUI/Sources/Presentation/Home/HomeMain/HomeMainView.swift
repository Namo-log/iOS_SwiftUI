//
//  HomeMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import SwiftUICalendar
import Factory
import Networks
import Common

enum HomeNavigationType: Hashable {
	case editDiaryView(memo: String, images: [ImageResponse], info: ScheduleInfo)
}

struct HomeMainView: View {
	@EnvironmentObject var scheduleState: ScheduleState
	let categoryUseCase = CategoryUseCase.shared
	@StateObject var calendarController = CalendarController()
	@StateObject var homeMainVM = HomeMainViewModel()
	
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
									CalendarItem(date: date, schedule: homeMainVM.state.calendarSchedules[date] ?? [], isMoimCalendar: false, focusDate: $homeMainVM.state.focusDate)
								}
								.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
							}
						}
					}
				}
				.padding(.leading, 14)
				.padding(.horizontal, 6)
				.padding(.top, 3)
				
				if homeMainVM.state.focusDate != nil {
					detailView
						.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
						.shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 0)
					
				}
				
				Spacer(minLength: 0)
					.frame(height: tabBarHeight)
					
			}
			
				if homeMainVM.state.showDatePicker {
					datePicker
				}
			
			if homeMainVM.state.isToDoSheetPresented {
				Color.black.opacity(0.3)
					.ignoresSafeArea(.all, edges: .all)
			}
		}
		.ignoresSafeArea(edges: .bottom)
		.task {
			homeMainVM.action(.viewDidLoad)
            
            if UserDefaults.standard.bool(forKey: "isLogin") {
                await categoryUseCase.getCategories()
            }
		}
		.onReceive(NotificationCenter.default.publisher(for: .reloadCalendarViaNetwork)) { notification in
			if let userInfo = notification.userInfo {
				let date = userInfo["date"] as? YearMonthDay
				
				homeMainVM.action(.reloadCalendar(date: date))
				
				if let date = date {
					calendarController.scrollTo(YearMonth(year: date.year, month: date.month))
				}
			}
		}
        .fullScreenCover(isPresented: $homeMainVM.state.isToDoSheetPresented, content: {
            ToDoEditView()
                .background(ClearBackground())
        })
		.navigationDestination(for: HomeNavigationType.self, destination: { type in
			switch type {
			case let .editDiaryView(memo, urls, info):
				EditDiaryView(isFromCalendar: true, memo: memo, urls: urls, info: info)
			}
			
		})
	}
	
	private var header: some View {
		HStack {
			Button(action: {
				withAnimation {
					AppState.shared.alertType = .alertWithContent(
						content: AnyView(datePicker),
						leftButtonTitle: "취소",
						leftButtonAction: {
							AppState.shared.alertType = nil
						},
						rightButtonTitle: "확인",
						rightButtonAction: {
							AppState.shared.alertType = nil
							// scroll이 dismiss된 이후에 동작해야 animation이 활성화됩니다.
							DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
								calendarController.scrollTo(YearMonth(year: homeMainVM.state.pickerCurrentYear, month: homeMainVM.state.pickerCurrentMonth))
							}
						}
					)
				}
			}, label: {
				HStack(spacing: 10) {
					Text(
						calendarController.yearMonth.formatYYYYMM()
					)
					.font(.pretendard(.bold, size: 22))
					
					Image(asset: CommonAsset.Assets.icChevronBottomBlack)
				}
			})
			.foregroundStyle(Color.black)

			Spacer()
			
			Text(Date().toDD())
				.font(.pretendard(.semibold, size: 16))
				.background(
					RoundedRectangle(cornerRadius: 5)
						.stroke(.black, lineWidth: 1.5)
						.frame(width: 25, height: 25)
				)
				.onTapGesture {
					if !homeMainVM.state.isScrolling {
						homeMainVM.state.isScrolling = true
						calendarController.scrollTo(YearMonth.current)
						DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
							self.homeMainVM.state.isScrolling = false
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
						.foregroundStyle(Color(asset: CommonAsset.Assets.textUnselected))
					
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
			let focusDate = homeMainVM.state.focusDate!
			Text(String(format: "%02d.%02d (%@)", focusDate.month, focusDate.day, focusDate.getShortWeekday()))
				.font(.pretendard(.bold, size: 22))
				.padding(.vertical, 20)
			
			
			
			ScrollView(.vertical, showsIndicators: false) {
				HStack {
					Text("개인 일정")
						.font(.pretendard(.bold, size: 15))
						.foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
						.padding(.bottom, 11)
						.padding(.leading, 3)
					
					Spacer()
				}
				
				if let schedules = homeMainVM.state.calendarSchedules[homeMainVM.state.focusDate!]?
					.compactMap(({$0.schedule}))
					.filter({!$0.moimSchedule}),
				   !schedules.isEmpty
				{
					ForEach(schedules, id: \.self) { schedule in
                        CalendarScheduleDetailItem(
							ymd: homeMainVM.state.focusDate!,
                            schedule: schedule,
							homeMainVM: homeMainVM
						)
					}
				} else {
					HStack(spacing: 12) {
						Rectangle()
							.fill(Color(asset: CommonAsset.Assets.textPlaceholder))
							.frame(width: 3, height: 21)
						
						Text("등록된 개인 일정이 없습니다.")
							.font(.pretendard(.medium, size: 14))
							.foregroundStyle(Color(asset: CommonAsset.Assets.textDisabled))
						
						Spacer()
					}
				}
				
				HStack {
					Text("모임 일정")
						.font(.pretendard(.bold, size: 15))
						.foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
						.padding(.top, 20)
						.padding(.bottom, 11)
						.padding(.leading, 3)
					
					Spacer()
				}
				
				if let schedules = homeMainVM.state.calendarSchedules[homeMainVM.state.focusDate!]?
					.compactMap({$0.schedule})
					.filter({$0.moimSchedule}),
				   !schedules.isEmpty
				{
					ForEach(schedules, id: \.self) { schedule in
						CalendarScheduleDetailItem(
							ymd: homeMainVM.state.focusDate!,
							schedule: schedule,
							homeMainVM: homeMainVM
						)
					}
				} else {
					HStack(spacing: 12) {
						Rectangle()
							.fill(Color(asset: CommonAsset.Assets.textPlaceholder))
							.frame(width: 3, height: 21)
						
						Text("등록된 모임 일정이 없습니다.")
							.font(.pretendard(.medium, size: 14))
							.foregroundStyle(Color(asset: CommonAsset.Assets.textDisabled))
						
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
				homeMainVM.action(.didTapAddScheduleButton)
            }, label: {
				Image(asset: CommonAsset.Assets.floatingAdd)
					.padding(.bottom, 37)
					.padding(.trailing, 25)
			})
		}
	}
	
	private var datePicker: some View {
		HStack(spacing: 0) {
			Picker("", selection: $homeMainVM.state.pickerCurrentYear) {
				ForEach(2000...2099, id: \.self) {
					Text("\(String($0))년")
						.font(.pretendard(.regular, size: 23))
				}
			}
			.pickerStyle(.inline)
			
			Picker("", selection: $homeMainVM.state.pickerCurrentMonth) {
				ForEach(1...12, id: \.self) {
					Text("\(String($0))월")
						.font(.pretendard(.regular, size: 23))
				}
			}
			.pickerStyle(.inline)
		}
		.frame(height: 154)
		.onAppear {
			homeMainVM.state.pickerCurrentYear = calendarController.yearMonth.year
			homeMainVM.state.pickerCurrentMonth = calendarController.yearMonth.month
		}
	}
	
	
}

#Preview {
	HomeMainView()
		.environmentObject(ScheduleState())
}
