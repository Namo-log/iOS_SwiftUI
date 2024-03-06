//
//  ScheduleInteractor.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/3/24.
//

import Foundation
import SwiftUICalendar
import SwiftUI

struct CalendarSchedule: Hashable {
	let position: Int
	let schedule: Schedule?
}

protocol ScheduleInteractor {
	func setCalendar() async -> [YearMonthDay: [CalendarSchedule]] 
	func getSchedules() async -> [Schedule]
	func setSchedules(_ schedules: [Schedule]) -> [YearMonthDay: [CalendarSchedule]]
	func findPostion(_ schedules: [CalendarSchedule]) -> Int
	func formatYearMonth(_ ym: YearMonth) -> String
	func getCurrentDay() -> String
	func datesBetween(startDate: Date, endDate: Date) -> [Date]
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: Schedule) -> String
    func setPlaceToScheduleTemp()
    func postNewSchedule() async
    func patchSchedule() async
    func deleteSchedule() async
    func setScheduleToTemplate(schedule: Schedule?)
}
