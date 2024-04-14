//
//  GroupCalendarView.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/19/24.
//

import SwiftUI
import Factory
import SwiftUICalendar

struct GroupCalendarView: View {
	@Injected(\.scheduleInteractor) var scheduleInteractor
	@Injected(\.categoryInteractor) var categoryInteractor
	@Injected(\.moimInteractor) var moimInteractor
	@StateObject var calendarController = CalendarController()
	@EnvironmentObject var appState: AppState
	@EnvironmentObject var moimState: MoimState
	@Environment(\.dismiss) var dismiss
	
//	let moim: Moim
	
	// datePicker
	@State var showDatePicker: Bool = false
	@State var datePickerCurrentDate: Date = Date()
	@State var pickerCurrentYear: Int = Date().toYMD().year
	@State var pickerCurrentMonth: Int = Date().toYMD().month
	
	// groupInfo
	@State var showGroupInfo: Bool = false
	@State var showWithdrawConfirm: Bool = false
	@State var groupName: String = ""
	@State var newGroupName: String = ""
	@FocusState var isGroupNameFoused: Bool
	@State var textOffset: CGFloat = 300
	let gridColumn: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
	
	// calendar
	@State var focusDate: YearMonthDay? = nil
//	@State var calendarSchedule: [YearMonthDay: [CalendarSchedule]] = [:]
	@State var isToDoSheetPresented: Bool = false
	
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
									CalendarItem(date: date, isMoimCalendar: true, focusDate: $focusDate)
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
				} else {
					Spacer(minLength: 0)
						.frame(height: tabBarHeight)
				}
				
			}
			
			if showDatePicker {
				datePicker
			}
			
			if showGroupInfo {
				groupInfo
				
				if showWithdrawConfirm {
					withdrawConfirm
				}
			}
            
            
            if isToDoSheetPresented {
                Color.black.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
            }
		}
		.ignoresSafeArea(edges: .bottom)
		.toolbar(.hidden, for: .navigationBar)
		.onAppear {
			groupName = moimState.currentMoim.groupName ?? ""
		}
        .fullScreenCover(isPresented: $isToDoSheetPresented, content: {
            GroupToDoEditView()
                .background(ClearBackground())
        })
    }
	
	private var header: some View {
		HStack {
			Button(action: {
				appState.isTabbarHidden = false
				dismiss()
			}, label: {
				Image(.icBackArrowOrange)
			})
			.foregroundStyle(Color.black)
			
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
			
			Text("\(groupName)")
				.font(.pretendard(.bold, size: 20))
			
			Button(action: {
				withAnimation {
					showGroupInfo = true
				}
			}, label: {
				Image(.icMoreVertical)
			})
		}
		.padding(.top, 15)
		.padding(.leading, 20)
		.padding(.trailing, 8)
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
			
			ScrollView(.vertical, showsIndicators: false) {
				HStack {
					Text("개인 일정")
						.font(.pretendard(.bold, size: 15))
						.foregroundStyle(Color(.mainText))
						.padding(.bottom, 11)
						.padding(.leading, 3)
					
					Spacer()
				}
				
				if let schedules = moimState.currentMoimSchedule[focusDate!]?
					.compactMap(({$0.schedule}))
					.filter({!$0.curMoimSchedule})
				{
					ForEach(schedules, id: \.id) {schedule in
						CalendarMoimScheduleDetailItem(ymd: focusDate!, schedule: schedule, isToDoSheetPresented: self.$isToDoSheetPresented)
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
				
				if let schedules = moimState.currentMoimSchedule[focusDate!]?
					.compactMap({$0.schedule})
					.filter({$0.curMoimSchedule})
				{
					ForEach(schedules, id: \.id) { schedule in
						CalendarMoimScheduleDetailItem(ymd: focusDate!, schedule: schedule, isToDoSheetPresented: self.$isToDoSheetPresented)
					}
				} else {
					Text("등록된 모임 일정이 없습니다.")
						.font(.pretendard(.medium, size: 14))
						.foregroundStyle(Color(.mainText))
				}
				
				Spacer()
					.frame(height: 100)
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
	
	private var groupInfo: some View {
		NamoAlertViewWithTopButton(
			showAlert: $showGroupInfo,
			title: "그룹 정보",
			leftButtonTitle: "닫기",
			leftButtonAction: {},
			rightButtonTitle: "저장",
			rightButtonAction: {
				let result = await moimInteractor.changeMoimName(moimId: moimState.currentMoim.groupId, newName: newGroupName)
				// 변경 성공 시
				if result {
					groupName = newGroupName
					return true
				}
				
				return false
			},
			content: AnyView(
				VStack(spacing: 0) {
					HStack {
						Text("그룹명")
							.font(.pretendard(.bold, size: 15))
						
						Spacer()
						
						TextField("", text: $newGroupName)
							.font(.pretendard(.regular, size: 15))
							.foregroundStyle(Color(.mainText))
							.multilineTextAlignment(.trailing)
							.focused($isGroupNameFoused)
						
						Button(action: {
							isGroupNameFoused = true
						}, label: {
							Image(.icPencil)
						})
					}
					.padding(.bottom, 20)
					
					HStack {
						Text("그룹원")
							.font(.pretendard(.bold, size: 15))
						
						Spacer()
						
						Text("\(moimState.currentMoim.moimUsers.count) 명")
							.font(.pretendard(.regular, size: 15))
							.foregroundStyle(Color(.mainText))
					}
					.padding(.bottom, 30)
					
					LazyVGrid(columns: gridColumn) {
						ForEach(moimState.currentMoim.moimUsers, id: \.userId) { user in
							HStack(spacing: 20) {
								Circle()
									.fill(categoryInteractor.getColorWithPaletteId(id: user.color))
									.frame(width: 20, height: 20)
								
								Text("\(user.userName)")
									.font(.pretendard(.regular, size: 15))
									.foregroundStyle(Color(.mainText))
								
								Spacer(minLength: 0)
							}
						}
					}
					.padding(.bottom, 25)
					
					HStack(spacing: 0) {
						Text("그룹 코드")
							.font(.pretendard(.bold, size: 15))
							.padding(.leading, 29)
							.padding(.horizontal, 12)
						
						Color.clear
							.frame(maxWidth: .infinity)
							.overlay {
								Text("\(moimState.currentMoim.groupCode)")
									.font(.pretendard(.regular, size: 15))
									.foregroundStyle(Color(.mainText))
									.kerning(3)
									.fixedSize()
									.offset(x: textOffset, y: 0)
							}
							.animation(.linear(duration: 10)
								.repeatForever(autoreverses: false), value: textOffset)
							.clipped()
							.onAppear {
								textOffset = -300.0
							}
						
						Button(action: {
							UIPasteboard.general.string = moimState.currentMoim.groupCode
						}, label: {
							Image(.btnCopy)
						})
						.padding(.horizontal, 12)
					}
					.frame(height: 40)
					.frame(maxWidth: .infinity)
					.background(Color(.mainGray))
					.cornerRadius(5)
					.padding(.bottom, 31)
					
					Button(action: {
						showWithdrawConfirm = true
					}, label: {
						Text("탈퇴하기")
							.font(.pretendard(.regular, size: 15))
							.padding(.horizontal, 44)
							.padding(.vertical, 11)
							.overlay(
								RoundedRectangle(cornerRadius: 20)
									.inset(by: 0.5)
									.stroke(.black, lineWidth: 1)
							)
					})
					.tint(.black)
					.padding(.bottom, 30)
				}
					.padding(.top, 25)
			)
		)
		.onAppear {
			newGroupName = groupName
		}
		.onDisappear {
			newGroupName = groupName
		}
	}
	
	private var withdrawConfirm: some View {
		NamoAlertViewWithTitle(
			showAlert: $showWithdrawConfirm,
			title: "정말 그룹에서 탈퇴하시겠어요?",
			message: "탈퇴하더라도\n이전 모임 일정은 사라지지 않습니다.",
			rightButtonTitle: "확인",
			rightButtonAction: {
				Task {
					let result = await moimInteractor.withdrawGroup(moimId: moimState.currentMoim.groupId)
					// 탈퇴 성공시 dismiss
					if result {
						appState.isTabbarOpaque = false
						dismiss()
					}
				}
			}
		)
	}
	
}

#Preview {
	GroupCalendarView()
}
