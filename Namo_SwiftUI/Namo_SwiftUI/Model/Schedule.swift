//
//  Schedule.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/7/24.
//

import Foundation

struct Schedule: Hashable {
	let scheduleId: Int
	let name: String
	let startDate: Date
	let endDate: Date
	let alarmDate: [Int]
	let interval: Int
	let x: Double?
	let y: Double?
	let locationName: String
	let categoryId: Int
	let hasDiary: Bool?
	let moimSchedule: Bool
}
