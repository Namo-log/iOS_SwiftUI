//
//  RealmSchedule.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 3/15/24.
//

import Foundation
import RealmSwift

class RealmSchedule: Object {
	@Persisted(primaryKey: true) var scheduleId: Int
	@Persisted var name: String
	@Persisted var startDate: Date
	@Persisted var endDate: Date
	@Persisted var alarmDate: List<Int>
	@Persisted var interval: Int
	@Persisted var x: Double?
	@Persisted var y: Double?
	@Persisted var locationName: String
	@Persisted var categoryId: Int
	@Persisted var hasDiary: Bool?
	@Persisted var moimSchedule: Bool
}

extension RealmSchedule {
	func toSchedule() -> Schedule {
		return Schedule(
			scheduleId: self.scheduleId,
			name: self.name,
			startDate: self.startDate,
			endDate: self.endDate,
			alarmDate: self.alarmDate.toArray(),
			interval: self.interval,
			x: self.x,
			y: self.y,
			locationName: self.locationName,
			categoryId: self.categoryId,
			hasDiary: self.hasDiary,
			moimSchedule: self.moimSchedule
		)
	}
}
