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
	func setCalendar(date: Date) async
	func getSchedulesViaNetwork() async -> [Schedule]
	func setSchedules(_ schedules: [Schedule], calculatedSchedules: [YearMonthDay: [CalendarSchedule]]) -> [YearMonthDay: [CalendarSchedule]]
	func calendarScrollForward(_ to: YearMonth)
	func calendarScrollBackward(_ to: YearMonth)
	func calculateSchedules(_ yearMonth: YearMonth)
	func findPostion(_ schedules: [CalendarSchedule]) -> Int
	func formatYearMonth(_ ym: YearMonth) -> String
	func getCurrentDay() -> String
	func datesBetween(startDate: Date, endDate: Date) -> [Date]
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: Schedule) -> String
	func getMoimScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: MoimSchedule) -> String
    func setPlaceToCurrentSchedule()
    func postNewSchedule() async
    func patchSchedule() async
    func deleteSchedule() async
    func setScheduleToCurrentSchedule(schedule: Schedule?)
	func yearMonthBetween(start: Date, end: Date) -> [YearMonth]
}
