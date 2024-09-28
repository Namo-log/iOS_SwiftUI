//
//  YearMonth+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/11/24.
//

import Foundation

import SwiftUICalendar

public extension YearMonth {
	// YYYY.MM으로 변환 ex) 2024.02
	func formatYYYYMM() -> String {
		return String(format: "%d.%02d", self.year, self.month)
	}
	
	// 해당 월의 첫째날 리턴
	func getFirstDay() -> YearMonthDay {
		return YearMonthDay(year: year, month: month, day: 1)
	}
	
	// 해당 월의 마지막 날 리턴
	func getLastDay() -> YearMonthDay {
		var components = DateComponents()
		components.year = year
		components.month = month + 1
		components.day = 1
		
		// 다음 해로 넘어가는 경우를 처리
		if components.month == 13 {
			components.year! += 1
			components.month = 1
		}
		
		let nextMonth = Calendar.current.date(from: components)!
		let lastDate = Calendar.current.date(byAdding: .day, value: -1, to: nextMonth)!
		let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: lastDate)
		
		return YearMonthDay(year: dateComponents.year!, month: dateComponents.month!, day: dateComponents.day!)
	}
	
	// month를 더하거나 뺌
	func addMonth(_ monthsToAdd: Int) -> YearMonth {
		var components = DateComponents()
		components.year = year
		components.month = month
		
		// 현재 날짜에서 monthsToAdd를 더하거나 뺌
		let currentDate = Calendar.current.date(from: components)!
		let newDate = Calendar.current.date(byAdding: .month, value: monthsToAdd, to: currentDate)!
		let dateComponents = Calendar.current.dateComponents([.year, .month], from: newDate)
		
		return YearMonth(year: dateComponents.year!, month: dateComponents.month!)
	}
	
	static func < (lhs: Self, rhs: Self) -> Bool {
		if lhs.year != rhs.year {
			return lhs.year < rhs.year
		} else {
			return lhs.month < rhs.month
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
