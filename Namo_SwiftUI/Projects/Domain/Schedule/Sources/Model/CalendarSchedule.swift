//
//  CalendarSchedule.swift
//  DomainSchedule
//
//  Created by 정현우 on 9/24/24.
//

public struct CalendarSchedule: Hashable {
	public init(position: Int, schedule: Schedule?) {
		self.position = position
		self.schedule = schedule
	}
	
	public let position: Int
	public let schedule: Schedule?
}
