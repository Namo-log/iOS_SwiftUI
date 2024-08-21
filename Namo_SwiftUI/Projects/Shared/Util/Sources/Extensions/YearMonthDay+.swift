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
