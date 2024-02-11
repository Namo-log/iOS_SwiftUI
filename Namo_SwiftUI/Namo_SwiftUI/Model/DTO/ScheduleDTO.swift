//
//  ScheduleDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Foundation

struct postScheduleRequest: Codable {
	let name: String
	let startDate: Int
	let endDate: Int
	let interval: Int
	let alarmDate: [Int]
	let x: Double?
	let y: Double?
	let locationName: String
	let categoryId: Int
}

struct postScheduleResponse: Codable {
	let scheduleIdx: Int
}

typealias getScheduleResponse = [ScheduleDTO]

struct ScheduleDTO: Codable {
	let scheduleId: Int
	let name: String
	let startDate: Int
	let endDate: Int
	let alarmDate: [Int]
	let interval: Int
	let x: Double?
	let y: Double?
	let locationName: String
	let categoryId: Int
	let hasDiary: Bool
	let moimSchedule: Bool
}

extension ScheduleDTO {
	func toSchedule() -> Schedule {
		return Schedule(
			scheduleId: scheduleId,
			name: name,
			startDate: Date(timeIntervalSince1970: Double(startDate)),
			endDate: Date(timeIntervalSince1970: Double(endDate)),
			alarmDate: alarmDate,
			interval: interval,
			x: x,
			y: y,
			locationName: locationName,
			categoryId: categoryId,
			hasDiary: hasDiary,
			moimSchedule: moimSchedule
		)
	}
}
