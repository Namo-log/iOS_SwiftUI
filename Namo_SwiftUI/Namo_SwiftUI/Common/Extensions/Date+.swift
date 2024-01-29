//
//  Date+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/24/24.
//

import Foundation

extension Date {
	// 만약 input이 자정이라면, 전날 23:59:59으로 return
	func adjustDateIfMidNight() -> Date {
		let calendar = Calendar.current
		let midnight = calendar.startOfDay(for: self)
		
		if self == midnight {
			return calendar.date(byAdding: .second, value: -1, to: midnight) ?? self
		} else {
			return self
		}
	}
}
