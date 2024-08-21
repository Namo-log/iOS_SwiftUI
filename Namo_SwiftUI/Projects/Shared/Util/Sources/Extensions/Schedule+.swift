//
//  Schedule+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/12/24.
//

import SwiftUICalendar

public extension Schedule {
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay) -> String {
		if self.startDate.toYMD() == self.endDate.adjustDateIfMidNight().toYMD() {
			// 같은 날이라면 그냥 시작시간-종료시간 표시
			return "\(self.startDate.toHHmm()) - \(self.endDate.adjustDateIfMidNight().toHHmm())"
		} else if currentYMD == self.startDate.toYMD() {
			// 여러 일 지속 스케쥴의 시작일이라면
			return "\(self.startDate.toHHmm()) - 23:59"
		} else if currentYMD == self.endDate.toYMD() {
			// 여러 일 지속 스케쥴의 종료일이라면
			return "00:00 - \(self.endDate.adjustDateIfMidNight().toHHmm())"
		} else {
			// 여러 일 지속 스케쥴의 중간이라면
			return "00:00 - 23:59"
		}
	}
}
