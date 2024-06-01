//
//  CalendarScheduleDetailItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/22/24.
//

import SwiftUI
import Factory
import SwiftUICalendar

struct CalendarScheduleDetailItem: View {
	let ymd: YearMonthDay
	let schedule: Schedule
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var scheduleState: ScheduleState
	@EnvironmentObject var diaryState: DiaryState
	
	@Injected(\.scheduleInteractor) var scheduleInteractor
    @Injected(\.categoryInteractor) var categoryInteractor
	@Injected(\.diaryInteractor) var diaryInteractor
	
	@Binding var isToDoSheetPresented: Bool
	
	var body: some View {
		if let paletteId = appState.categoryPalette[schedule.categoryId] {
			HStack(spacing: 5) {
				Rectangle()
					.fill(categoryInteractor.getColorWithPaletteId(id: paletteId))
					.frame(width: 30, height: 55)
					.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .bottomLeft]))
				
				VStack(alignment: .leading, spacing: 4) {
					Text(scheduleInteractor.getScheduleTimeWithCurrentYMD(currentYMD: ymd, schedule: schedule))
						.font(.pretendard(.medium, size: 12))
						.foregroundStyle(Color(.mainText))
					
					Text(schedule.name)
						.font(.pretendard(.bold, size: 15))
						.lineLimit(1)
				}
				.padding(.leading, 10)
				
				Spacer()
                
                if let hasDiary = schedule.hasDiary {
                    NavigationLink(destination: EditDiaryView(memo: diaryState.currentDiary.contents ?? "", urls: [], info: ScheduleInfo(scheduleId: schedule.scheduleId, scheduleName: schedule.name, date: schedule.startDate, place: schedule.locationName, categoryId: schedule.categoryId))) {
                        Image(hasDiary ? .btnAddRecordOrange : .btnAddRecord)
                            .resizable()
                            .frame(width: 34, height: 34)
                            .padding(.trailing, 11)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        scheduleInteractor.setScheduleToCurrentSchedule(schedule: schedule)
                        appState.isEditingDiary = false
                    })
                }
			}
			.frame(width: screenWidth-50, height: 55)
			.background(
				RoundedRectangle(cornerRadius: 15)
					.fill(Color(.textBackground))
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
			)
			.onTapGesture {
				scheduleInteractor.setScheduleToCurrentSchedule(schedule: self.schedule)
                scheduleState.isGroup = schedule.moimSchedule
				self.isToDoSheetPresented = true
			}
        }
	}
}

struct CalendarMoimScheduleDetailItem: View {
	let ymd: YearMonthDay
	let schedule: MoimSchedule
	@EnvironmentObject var appState: AppState
	
	@Injected(\.scheduleInteractor) var scheduleInteractor
	@Injected(\.categoryInteractor) var categoryInteractor
    @Injected(\.moimInteractor) var moimInteractor
	@Injected(\.moimDiaryInteractor) var moimDiaryInteractor
	
	@Binding var isToDoSheetPresented: Bool
	
	var body: some View {
		let color = schedule.curMoimSchedule ?
		Color.mainOrange :
		categoryInteractor.getColorWithPaletteId(id: schedule.users.first?.color ?? 0)
		HStack(spacing: 5) {
			Rectangle()
				.fill(color)
				.frame(width: 30, height: 55)
				.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .bottomLeft]))
			
			VStack(alignment: .leading, spacing: 4) {
				Text(scheduleInteractor.getMoimScheduleTimeWithCurrentYMD(currentYMD: ymd, schedule: schedule))
					.font(.pretendard(.medium, size: 12))
					.foregroundStyle(Color(.mainText))
				
				Text(schedule.name)
					.font(.pretendard(.bold, size: 15))
					.lineLimit(1)
			}
			.padding(.leading, 10)
			
			Spacer(minLength: 0)
			
			if schedule.curMoimSchedule {
                NavigationLink(destination: EditMoimDiaryView(info: ScheduleInfo(scheduleId: schedule.moimScheduleId ?? 0, scheduleName: schedule.name, date: schedule.startDate, place: schedule.locationName ?? "", categoryId: nil), moimUser: schedule.users)) {
                    Image(schedule.hasDiaryPlace ? .btnAddRecordOrange : .btnAddRecord)
                        .resizable()
                        .frame(width: 34, height: 34)
                        .padding(.trailing, 11)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    moimInteractor.setScheduleToCurrentMoimSchedule(schedule: self.schedule)
                    appState.isEditingDiary = schedule.hasDiaryPlace
					Task {
						await moimDiaryInteractor.getOneMoimDiary(moimScheduleId: schedule.moimScheduleId ?? 0)
					}
                })
			} else {
				Text(schedule.users.count == 1 ? schedule.users.first!.userName : "\(schedule.users.count)명")
					.frame(width: 30, height: 30)
					.overlay(
						Circle()
							.stroke(Color(hex: 0xCCCCCC), lineWidth: 2)
					)
					.font(.pretendard(.bold, size: 10))
					.foregroundStyle(Color(hex: 0xBBBBBB))
					.padding(.trailing, 14)
			}
			
		}
		.frame(width: screenWidth-50, height: 55)
		.background(
			RoundedRectangle(cornerRadius: 15)
				.fill(Color(.textBackground))
				.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
		)
		.onTapGesture {
			if self.schedule.curMoimSchedule {
				moimInteractor.setScheduleToCurrentMoimSchedule(schedule: self.schedule)
				self.isToDoSheetPresented = true
			}
		}
	}
}

