//
//  YearMonthDay+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/24/24.
//

import Foundation
import SwiftUICalendar

public extension YearMonthDay {
	func diffDayBetween(value: YearMonthDay) -> Int {
		var origin = self.toDateComponents()
		origin.hour = 0
		origin.minute = 0
		origin.second = 0
		var new = value.toDateComponents()
		new.hour = 0
		new.minute = 0
		new.second = 0
		return Calendar.current.dateComponents([.day], from: origin, to: new).day ?? 0
	}
	
	func toDate() -> Date {
		let dateComponent = self.toDateComponents()
		
		return Calendar.current.date(from: dateComponent)!
	}
	
	func getShortWeekday() -> String {
		switch self.dayOfWeek {
		case .sun:
			return "일"
		case .mon:
			return "월"
		case .tue:
			return "화"
		case .wed:
			return "수"
		case .thu:
			return "목"
		case .fri:
			return "금"
		case .sat:
			return "토"
		}
	}
	
	// 특정 시간 Date리턴
	func toDateWithTime(hour: Int = 0, min: Int = 0, second: Int = 0) -> Date {
		var dateComponents = DateComponents()
		dateComponents.year = self.year
		dateComponents.month = self.month
		dateComponents.day = self.day
		dateComponents.hour = hour // 오전 8시
		dateComponents.minute = min
		dateComponents.second = second
		
		let calendar = Calendar.current
		return calendar.date(from: dateComponents)!
	}
	
	static func < (lhs: Self, rhs: Self) -> Bool {
		if lhs.year != rhs.year {
			return lhs.year < rhs.year
		} else if lhs.month != rhs.month {
			return lhs.month < rhs.month
		} else {
			return lhs.day < rhs.day
		}
	}
	
	static func <= (lhs: Self, rhs: Self) -> Bool {
		return lhs < rhs || lhs == rhs
	}
	
	static func > (lhs: Self, rhs: Self) -> Bool {
		return !(lhs <= rhs)
	}
	
	static func >= (lhs: Self, rhs: Self) -> Bool {
		return !(lhs < rhs)
	}
}
