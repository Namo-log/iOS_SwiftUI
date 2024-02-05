//
//  ScheduleInteractor.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/3/24.
//

import Foundation
import SwiftUICalendar
import SwiftUI
import Combine

struct DummySchedule: Hashable {
	let scheduleId: Int
	let name: String
	let startDate: Date
	let endDate: Date
	let color: String
}

struct CalendarSchedule {
	let position: Int
	let schedule: DummySchedule?
}

protocol ScheduleInteractor {
	func setCalendar(schedules: Binding<[YearMonthDay: [CalendarSchedule]]>)
	func getDummyData() -> [DummySchedule]
	func setSchedules(_ schedules: [DummySchedule]) -> [YearMonthDay: [CalendarSchedule]]
	func findPostion(_ schedules: [CalendarSchedule]) -> Int
	func formatYearMonth(_ ym: YearMonth) -> String
	func getCurrentDay() -> String
	func datesBetween(startDate: Date, endDate: Date) -> [Date]
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: DummySchedule) -> String
}

struct ScheduleInteractorImpl: ScheduleInteractor {
	
	// 1: 캘린더 데이터를 세팅하기 위해 View에서 호출하는 함수
	func setCalendar(schedules: Binding<[YearMonthDay: [CalendarSchedule]]>) {
		let dummySchedules = getDummyData()

		let mappedSchedules = setSchedules(dummySchedules)
		
		DispatchQueue.main.async {
			schedules.wrappedValue = mappedSchedules
		}
	}
	
	// 2: dummyData
	func getDummyData() -> [DummySchedule] {
		return [
			DummySchedule(scheduleId: 0, name: "테스트123", startDate: Date(timeIntervalSince1970: 1704023407), endDate: Date(timeIntervalSince1970: 1704196207), color: "#DA6022"),
			DummySchedule(scheduleId: 1, name: "UMC 운영진 회의", startDate: Date(timeIntervalSince1970: 1706182200), endDate: Date(timeIntervalSince1970: 1706185800), color: "#DA6022"),
			DummySchedule(scheduleId: 2, name: "따스알", startDate: Date(timeIntervalSince1970: 1706238000), endDate: Date(timeIntervalSince1970: 1706241600), color: "#DA6022"),
			DummySchedule(scheduleId: 3, name: "약속", startDate: Date(timeIntervalSince1970: 1706247000), endDate: Date(timeIntervalSince1970: 1706274000), color: "#DE8989"),
			DummySchedule(scheduleId: 4, name: "나모 iOS 회의", startDate: Date(timeIntervalSince1970: 1706247000), endDate: Date(timeIntervalSince1970: 1706250600), color: "#525241"),
			DummySchedule(scheduleId: 5, name: "테스트용", startDate: Date(timeIntervalSince1970: 1706355607), endDate: Date(timeIntervalSince1970: 1706356207), color: "#5C8596"),
			DummySchedule(scheduleId: 5, name: "테스트22", startDate: Date(timeIntervalSince1970: 1706701807), endDate: Date(timeIntervalSince1970: 1706874607), color: "#5C8596"),
			DummySchedule(scheduleId: 5, name: "테스트999", startDate: Date(timeIntervalSince1970: 1706701807), endDate: Date(timeIntervalSince1970: 1707740000), color: "#666666"),
			DummySchedule(scheduleId: 5, name: "zzz", startDate: Date(timeIntervalSince1970: 1707078600), endDate: Date(timeIntervalSince1970: 1707093000), color: "#123123"),
			DummySchedule(scheduleId: 6, name: "설날 연휴", startDate: Date(timeIntervalSince1970: 1707404400), endDate: Date(timeIntervalSince1970: 1707750000), color: "#5C8596"),
			DummySchedule(scheduleId: 6, name: "ddd", startDate: Date(timeIntervalSince1970: 1707805800), endDate: Date(timeIntervalSince1970: 1707813000), color: "#333333"),
			
		]
	}
	// 3: 서버에서 받아온 스케쥴들을 View의 Model로 매핑
	func setSchedules(_ schedules: [DummySchedule]) -> [YearMonthDay: [CalendarSchedule]] {
		var schedulesDict: [YearMonthDay: [CalendarSchedule]] = [:]
		
		// 서버에서 받아온 스케쥴을 돌면서
		schedules.forEach { schedule in
			let startDate = schedule.startDate
			let endDate = schedule.endDate.adjustDateIfMidNight()  // 종료일이 만약 자정이라면 -1초

			let startYMD = startDate.toYMD()
			
			// 일정 지속기간 중 모든 day를 구함
			let days = datesBetween(startDate: startDate, endDate: endDate)
			
			// 우선 시작날 캘린더에 표시될 postion을 구함(그 뒤 day들은 이 postion을 쭉 이어감)
			let currentPosition = findPostion(schedulesDict[startYMD] ?? [])
			
			// 일정 지속기간동안 매일
			days.forEach { day in
				let currentYMD = day.toYMD()
				
				// schedulesDict에 해당 날짜에 data가 nil이 아니라면 = 해당 날짜에 이미 스케쥴이 있다면
				if schedulesDict[currentYMD] != nil {
					// 만약 현재 인덱스에 스케쥴이 nil인채로 있을 수 있음
					// 그 nil인 스케쥴을 지우고
					if let index = schedulesDict[currentYMD]!.firstIndex(where: {$0.position == currentPosition && $0.schedule == nil}) {
						schedulesDict[currentYMD]?.remove(at: index)
					}
					// 그 자리에 스케쥴 추가
					schedulesDict[currentYMD]?.append(CalendarSchedule(position: currentPosition, schedule: schedule))
				} else {
					// schedulesDict에 해당 날짜에 data가 nil이라면 = 해당 날짜에 스케쥴이 없다면
					// 그냥 현재 스케쥴을 추가함
					schedulesDict[currentYMD] = [CalendarSchedule(position: currentPosition, schedule: schedule)]
				}
				
				// 아래는 캘린더 표시되기 위한 작업이므로
				// max이상이거나 currentPostion이 0미만이라면 다음 날로
				if currentPosition >= MAX_SCHEDULE || currentPosition < 0 { return }
				
				if let positions = schedulesDict[currentYMD]?.map({$0.position}) {
					
					var tempPostion = currentPosition
					
					while tempPostion >= 0 {
						if !positions.contains(tempPostion) {
							// 최고 포지션 밑에서 만약 스케쥴이 없다면 nil로 추가(캘린더에서 줄 맞춤을 위함)
							schedulesDict[currentYMD]?.append(CalendarSchedule(position: tempPostion, schedule: nil))
						}
						
						tempPostion -= 1
					}
					
					schedulesDict[currentYMD]?.sort(by: {$0.position < $1.position})
				}
				
			}  //: days forEach
		} //: schedules forEach
		return schedulesDict
	}
	
	// 현재 스케쥴들을 확인하고, 추가될 스케쥴의 포지션을 구함
	func findPostion(_ schedules: [CalendarSchedule]) -> Int {
		
		if schedules.isEmpty {
			return 0
		}
		
		// 스케쥴인 nil인 postion
		let nilSchedulePositions = schedules.compactMap { $0.schedule == nil ? $0.position : nil }
		 
		if !nilSchedulePositions.isEmpty {
			// nil인 포지션이 있다면 그 중 최소값을 찾음
			return nilSchedulePositions.min()!
		} else {
			// nil인 포지션이 없다면, 마지막 postion의 다음 postion으로 지정
			return schedules.last!.position + 1
		}
	}
	
	// YYYY.MM으로 변환 ex) 2024.02
	func formatYearMonth(_ ym: YearMonth) -> String {
		return String(format: "%d.%02d", ym.year, ym.month)
	}
	
	// 오늘 day 2글자 ex) 3일 -> 03
	func getCurrentDay() -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "dd"
		
		return dateFormatter.string(from: Date())
	}
	
	// 시작일과 종료일 사이 Date 리턴
	func datesBetween(startDate: Date, endDate: Date) -> [Date] {
		var dates: [Date] = []
		var currentDate = startDate

		let calendar = Calendar.current
		while currentDate <= endDate {
			dates.append(currentDate)
			currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
		}
		return dates
	}
	
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: DummySchedule) -> String {
		if schedule.startDate.toYMD() == schedule.endDate.adjustDateIfMidNight().toYMD() {
			// 같은 날이라면 그냥 시작시간-종료시간 표시
			return "\(schedule.startDate.toHHmm()) - \(schedule.endDate.adjustDateIfMidNight().toHHmm())"
		} else if currentYMD == schedule.startDate.toYMD() {
			// 여러 일 지속 스케쥴의 시작일이라면
			return "\(schedule.startDate.toHHmm()) - 23:59"
		} else if currentYMD == schedule.endDate.toYMD() {
			// 여러 일 지속 스케쥴의 종료일이라면
			return "00:00 - \(schedule.endDate.adjustDateIfMidNight().toHHmm())"
		} else {
			// 여러 일 지속 스케쥴의 중간이라면
			return "00:00 - 23:59"
		}
	}
	
	
	
	
	
	
}
