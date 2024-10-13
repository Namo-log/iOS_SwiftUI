//
//  ScheduleEdit.swift
//  DomainSchedule
//
//  Created by 정현우 on 10/3/24.
//

import Foundation

import DomainCategoryInterface

public struct ScheduleEdit: Encodable, Equatable {
	public var title: String
	public var category: ScheduleCategory
	public var period: SchedulePeriod
	public var location: ScheduleLocation?
	public var reminderTrigger: [String]?
	
	public init(
		title: String = "",
		category: ScheduleCategory = .init(categoryId: -1, colorId: -1, name: "", isShared: false),
		period: SchedulePeriod,
		location: ScheduleLocation? = nil,
		reminderTrigger: [String]? = nil
	) {
		self.title = title
		self.category = category
		self.period = period
		self.location = location
		self.reminderTrigger = reminderTrigger
	}
	
	
}

public struct SchedulePeriod: Encodable, Equatable  {
	public var startDate: Date
	public var endDate: Date
	
	public init(
		startDate: Date,
		endDate: Date
	) {
		self.startDate = startDate
		self.endDate = endDate
	}
}
