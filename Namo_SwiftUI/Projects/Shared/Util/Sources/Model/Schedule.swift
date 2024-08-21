//
//  Schedule.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/7/24.
//

import Foundation

public struct Schedule: Hashable {
	public init(scheduleId: Int, name: String, startDate: Date, endDate: Date, alarmDate: [Int], interval: Int, x: Double?, y: Double?, locationName: String, categoryId: Int, hasDiary: Bool?, moimSchedule: Bool) {
		self.scheduleId = scheduleId
		self.name = name
		self.startDate = startDate
		self.endDate = endDate
		self.alarmDate = alarmDate
		self.interval = interval
		self.x = x
		self.y = y
		self.locationName = locationName
		self.categoryId = categoryId
		self.hasDiary = hasDiary
		self.moimSchedule = moimSchedule
	}
	
	public let scheduleId: Int
	public let name: String
	public let startDate: Date
	public let endDate: Date
	public let alarmDate: [Int]
	public let interval: Int
	public let x: Double?
	public let y: Double?
	public let locationName: String
	public let categoryId: Int
	public let hasDiary: Bool?
	public let moimSchedule: Bool
}

public struct CalendarSchedule: Hashable {
	public init(position: Int, schedule: Schedule?) {
		self.position = position
		self.schedule = schedule
	}
	
	public let position: Int
	public let schedule: Schedule?
}
