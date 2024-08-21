//
//  CalendarScheduleDetailItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/22/24.
//

import SwiftUI
import Factory
import SwiftUICalendar

import SharedDesignSystem
import SharedUtil
import CoreNetwork

struct CalendarScheduleDetailItem: View {
	let ymd: YearMonthDay
	let schedule: Schedule
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var scheduleState: ScheduleState
	@EnvironmentObject var diaryState: DiaryState
	@ObservedObject var homeMainVM: HomeMainViewModel
    let categoryUseCase = CategoryUseCase.shared
	
	var body: some View {
		if let paletteId = appState.categoryPalette[schedule.categoryId] {
			HStack(spacing: 5) {
				Rectangle()
					.fill(categoryUseCase.getColorWithPaletteId(id: paletteId))
					.frame(width: 30, height: 55)
					.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .bottomLeft]))
				
				VStack(alignment: .leading, spacing: 4) {
					Text(schedule.getScheduleTimeWithCurrentYMD(currentYMD: ymd))
						.font(.pretendard(.medium, size: 12))
						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
					
					Text(schedule.name)
						.font(.pretendard(.bold, size: 15))
						.lineLimit(1)
				}
				.padding(.leading, 10)
				
				Spacer()
                
                if let hasDiary = schedule.hasDiary {
					Button(action: {
						homeMainVM.action(.scheduleDiaryEditButtonTapped(schedule: schedule))
					}, label: {
						Image(asset: hasDiary ? SharedDesignSystemAsset.Assets.btnAddRecordOrange : SharedDesignSystemAsset.Assets.btnAddRecord)
							.resizable()
							.frame(width: 34, height: 34)
							.padding(.trailing, 11)
					})
                }
			}
			.frame(width: screenWidth-50, height: 55)
			.background(
				RoundedRectangle(cornerRadius: 15)
					.fill(Color(asset: SharedDesignSystemAsset.Assets.textBackground))
					.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
			)
			.onTapGesture {
				homeMainVM.action(.scheduleEditButtonTapped(schedule: schedule))
			}
        }
	}
}

struct CalendarMoimScheduleDetailItem: View {
	let ymd: YearMonthDay
	let schedule: MoimSchedule
	@EnvironmentObject var appState: AppState
	
	let scheduleUseCase = ScheduleUseCase.shared
	let categoryUseCase = CategoryUseCase.shared
    let moimUseCase = GroupUseCase.shared
	let moimDiaryUseCase = MoimDiaryUseCase.shared
	
	@Binding var isToDoSheetPresented: Bool
	
	var body: some View {
		let color = schedule.curMoimSchedule ?
		Color(asset: SharedDesignSystemAsset.Assets.mainOrange) :
		categoryUseCase.getColorWithPaletteId(id: schedule.users.first?.color ?? 0)
		HStack(spacing: 5) {
			Rectangle()
				.fill(color)
				.frame(width: 30, height: 55)
				.clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .bottomLeft]))
			
			VStack(alignment: .leading, spacing: 4) {
				Text(scheduleUseCase.getMoimScheduleTimeWithCurrentYMD(currentYMD: ymd, schedule: schedule))
					.font(.pretendard(.medium, size: 12))
					.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
				
				Text(schedule.name)
					.font(.pretendard(.bold, size: 15))
					.lineLimit(1)
			}
			.padding(.leading, 10)
			
			Spacer(minLength: 0)
			
			if schedule.curMoimSchedule {
                NavigationLink(destination: EditMoimDiaryView(info: ScheduleInfo(scheduleId: schedule.moimScheduleId ?? 0, scheduleName: schedule.name, date: schedule.startDate, place: schedule.locationName ?? "", categoryId: nil), moimUser: schedule.users)) {
					
					Image(asset: schedule.hasDiaryPlace ? SharedDesignSystemAsset.Assets.btnAddRecordOrange : SharedDesignSystemAsset.Assets.btnAddRecord)
                        .resizable()
                        .frame(width: 34, height: 34)
                        .padding(.trailing, 11)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    moimUseCase.setScheduleToCurrentMoimSchedule(schedule: self.schedule)
                    appState.isEditingDiary = schedule.hasDiaryPlace
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
				.fill(Color(asset: SharedDesignSystemAsset.Assets.textBackground))
				.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 0)
		)
		.onTapGesture {
			if self.schedule.curMoimSchedule {
				moimUseCase.setScheduleToCurrentMoimSchedule(schedule: self.schedule)
				self.isToDoSheetPresented = true
			}
		}
	}
}

