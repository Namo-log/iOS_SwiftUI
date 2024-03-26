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
	
	@Injected(\.scheduleInteractor) var scheduleInteractor
	@Injected(\.categoryInteractor) var categoryInteractor
	
	@Binding var isToDoSheetPresented: Bool
	
	var body: some View {
		if let paletteId = appState.categoryPalette[schedule.categoryId] {
			HStack(spacing: 15) {
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
				}
				
				Spacer()
                
                NavigationLink(destination: EditDiaryView(info: ScheduleInfo(scheduleName: schedule.name, date: schedule.startDate, place: schedule.locationName))) {
                    Image(schedule.hasDiary ? .btnAddRecordOrange : .btnAddRecord)
                        .resizable()
                        .frame(width: 34, height: 34)
                        .padding(.trailing, 11)
                }
                .simultaneousGesture(TapGesture().onEnded {
                    appState.isEditingDiary = false
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
}



