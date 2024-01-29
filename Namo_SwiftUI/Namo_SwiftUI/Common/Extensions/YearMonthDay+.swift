//
//  YearMonthDay+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/24/24.
//

import Foundation
import SwiftUICalendar

extension YearMonthDay {
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
		var dateComponent = self.toDateComponents()
		
		return Calendar.current.date(from: dateComponent)!
	}
}
