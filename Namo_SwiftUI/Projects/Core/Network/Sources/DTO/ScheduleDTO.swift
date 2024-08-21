//
//  ScheduleDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Foundation

import SharedUtil

public struct postScheduleRequest: Codable {
	public init(name: String, startDate: Int, endDate: Int, interval: Int, alarmDate: [Int], x: Double?, y: Double?, locationName: String, categoryId: Int) {
		self.name = name
		self.startDate = startDate
		self.endDate = endDate
		self.interval = interval
		self.alarmDate = alarmDate
		self.x = x
		self.y = y
		self.locationName = locationName
		self.categoryId = categoryId
	}
	
	public let name: String
	public let startDate: Int
	public let endDate: Int
	public let interval: Int
	public let alarmDate: [Int]
	public let x: Double?
	public let y: Double?
	public let locationName: String
	public let categoryId: Int
}

public struct postScheduleResponse: Codable {
	public init(scheduleId: Int) {
		self.scheduleId = scheduleId
	}
	public let scheduleId: Int
}

public typealias getScheduleResponse = [ScheduleDTO]

public struct ScheduleDTO: Codable {
	public init(scheduleId: Int, name: String, startDate: Int, endDate: Int, alarmDate: [Int], interval: Int, x: Double?, y: Double?, locationName: String?, kakaoLocationId: Int?, categoryId: Int, hasDiary: Bool?, moimSchedule: Bool) {
		self.scheduleId = scheduleId
		self.name = name
		self.startDate = startDate
		self.endDate = endDate
		self.alarmDate = alarmDate
		self.interval = interval
		self.x = x
		self.y = y
		self.locationName = locationName
		self.kakaoLocationId = kakaoLocationId
		self.categoryId = categoryId
		self.hasDiary = hasDiary
		self.moimSchedule = moimSchedule
	}
	
	public let scheduleId: Int
	public let name: String
	public let startDate: Int
	public let endDate: Int
	public let alarmDate: [Int]
	public let interval: Int
	public let x: Double?
	public let y: Double?
	public let locationName: String?
	public let kakaoLocationId: Int?
	public let categoryId: Int
	public let hasDiary: Bool?
	public let moimSchedule: Bool
}

public extension ScheduleDTO {
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
            locationName: locationName ?? "",
			categoryId: categoryId,
			hasDiary: hasDiary,
			moimSchedule: moimSchedule
		)
	}
}
