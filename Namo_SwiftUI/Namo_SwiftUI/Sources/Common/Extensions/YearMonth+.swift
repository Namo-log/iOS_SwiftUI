//
//  YearMonth+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/11/24.
//

import SwiftUICalendar

extension YearMonth {
	// YYYY.MM으로 변환 ex) 2024.02
	func formatYYYYMM() -> String {
		return String(format: "%d.%02d", self.year, self.month)
	}
}
