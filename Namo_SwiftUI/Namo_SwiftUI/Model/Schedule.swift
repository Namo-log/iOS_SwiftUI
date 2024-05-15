//
//  Schedule.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/7/24.
//

import Foundation
import RealmSwift

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

extension Schedule {
	func toRealmSchedule() -> RealmSchedule {
		let realmSchedule = RealmSchedule()
		realmSchedule.scheduleId = scheduleId
		realmSchedule.name = name
		realmSchedule.startDate = startDate
		realmSchedule.endDate = endDate
		realmSchedule.interval = interval
		realmSchedule.x = x
		realmSchedule.y = y
		realmSchedule.locationName = locationName
		realmSchedule.categoryId = categoryId
		realmSchedule.hasDiary = hasDiary
		realmSchedule.moimSchedule = moimSchedule
		
		alarmDate.forEach({realmSchedule.alarmDate.append($0)})
		
		return realmSchedule
	}
}
