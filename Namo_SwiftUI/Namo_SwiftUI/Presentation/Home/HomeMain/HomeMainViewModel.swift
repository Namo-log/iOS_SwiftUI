//
//  HomeMainViewModel.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import SwiftUICalendar

class HomeMainViewModel: ObservableObject {
	let MAX_SCHEDULE = 3 // 캘린더에 표시되는 최대 하루 일정 개수
	@Published var mySchedules: [YearMonthDay: [(position: Int, schedule: DummySchedule?)]] = [:]
	
	// YYYY.MM으로 변환 ex) 2024.02
	func formatYearMonth(year: Int, month: Int) -> String {
		return String(format: "%d.%02d", year, month)
	}
	
	// 오늘 day
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
	
	// date를 YMD로 변환
	func getYMD(_ date: Date) -> YearMonthDay {
		let calendar = Calendar.current
		
		return YearMonthDay(
			year: calendar.component(.year, from: date),
			month: calendar.component(.month, from: date),
			day: calendar.component(.day, from: date)
		)
	}
	
	func getSchedules() {
		// AF call via Repository
		let schedules = dummySchedules()
		
		
		// View에서 사용하는 Model로 Mapping
		let mappedSchedules = setSchedules(schedules)
		
		self.mySchedules = mappedSchedules
	}
	
	// MARK: Dummy
	func dummySchedules() -> [DummySchedule] {
		let schedules = [
			DummySchedule(scheduleId: 0, name: "테스트123", startDate: Date(timeIntervalSince1970: 1704023407), endDate: Date(timeIntervalSince1970: 1704196207), color: "#DA6022"),
			DummySchedule(scheduleId: 1, name: "UMC 운영진 회의", startDate: Date(timeIntervalSince1970: 1706182200), endDate: Date(timeIntervalSince1970: 1706185800), color: "#DA6022"),
			DummySchedule(scheduleId: 2, name: "따스알", startDate: Date(timeIntervalSince1970: 1706238000), endDate: Date(timeIntervalSince1970: 1706241600), color: "#DA6022"),
			DummySchedule(scheduleId: 3, name: "약속", startDate: Date(timeIntervalSince1970: 1706247000), endDate: Date(timeIntervalSince1970: 1706274000), color: "#DE8989"),
			DummySchedule(scheduleId: 4, name: "나모 iOS 회의", startDate: Date(timeIntervalSince1970: 1706247000), endDate: Date(timeIntervalSince1970: 1706250600), color: "#525241"),
//			DummySchedule(scheduleId: 5, name: "테스트용", startDate: Date(timeIntervalSince1970: 1706355607), endDate: Date(timeIntervalSince1970: 1706356207), color: "#5C8596"),
			DummySchedule(scheduleId: 5, name: "테스트22", startDate: Date(timeIntervalSince1970: 1706701807), endDate: Date(timeIntervalSince1970: 1706874607), color: "#5C8596"),
			DummySchedule(scheduleId: 5, name: "테스트999", startDate: Date(timeIntervalSince1970: 1706701807), endDate: Date(timeIntervalSince1970: 1707750000), color: "#666666"),
			DummySchedule(scheduleId: 5, name: "zzz", startDate: Date(timeIntervalSince1970: 1707078600), endDate: Date(timeIntervalSince1970: 1707093000), color: "#123123"),
			DummySchedule(scheduleId: 6, name: "설날 연휴", startDate: Date(timeIntervalSince1970: 1707404400), endDate: Date(timeIntervalSince1970: 1707750000), color: "#5C8596"),
			DummySchedule(scheduleId: 6, name: "ddd", startDate: Date(timeIntervalSince1970: 1707805800), endDate: Date(timeIntervalSince1970: 1707813000), color: "#333333"),
			
		]
		
		return schedules
	}
	
	func setSchedules(_ schedules: [DummySchedule]) -> [YearMonthDay: [(position: Int, schedule: DummySchedule?)]] {
		let calendar = Calendar.current
		var schedulesDict: [YearMonthDay: [(position: Int, schedule: DummySchedule?)]] = [:]
		
		schedules.forEach { schedule in
			let startDate = schedule.startDate
			let endDate = schedule.endDate
			
			let startYMD = YearMonthDay(
				year: calendar.component(.year, from: startDate),
				month: calendar.component(.month, from: startDate),
				day: calendar.component(.day, from: startDate)
			)
			
			let days = datesBetween(startDate: startDate, endDate: endDate)
			
			var currentPosition = findPostion(for: startYMD, in: schedulesDict[startYMD] ?? [])
//			print("\(schedule.name)의 currentPostion은 \(currentPosition)")
			
			// 일정 지속기간동안 매일
			days.forEach { day in
				let currentYMD = YearMonthDay(
					year: calendar.component(.year, from: day),
					month: calendar.component(.month, from: day),
					day: calendar.component(.day, from: day)
				)
				
				if schedulesDict[currentYMD] != nil {
					if let index = schedulesDict[currentYMD]!.firstIndex(where: {$0.position == currentPosition && $0.schedule == nil}) {
						schedulesDict[currentYMD]?.remove(at: index)
					}
					
					schedulesDict[currentYMD]?.append((position: currentPosition, schedule: schedule))
				} else {
					// 해당 날이 비어있다면 그냥 추가
					schedulesDict[currentYMD] = [(position: currentPosition, schedule: schedule)]
				}
				
//				print("\(currentYMD.month)/\(currentYMD.day)에 \(schedule.name)을 \(currentPosition)에 넣음!")
				
				// 아래는 캘린더 표시되기 위한 작업이므로 
				// max이상이거나 currentPostion이 -1이라면 다음 날로
				if currentPosition >= MAX_SCHEDULE || currentPosition < 0 { return }
				
				// 최고 포지션 밑에서 만약 스케쥴이 없다면 nil로 추가
				if let positions = schedulesDict[currentYMD]?.map({$0.position}) {
					
					var tempPostion = currentPosition
					
					while tempPostion >= 0 {
						if !positions.contains(tempPostion) {
							schedulesDict[currentYMD]?.append((position: tempPostion, schedule: nil))
//							print("\(currentYMD.month)/\(currentYMD.day)에 빈 스케쥴을 \(postion)에 넣음!")
						}
						
						tempPostion -= 1
					}
					
					schedulesDict[currentYMD]?.sort(by: {$0.position < $1.position})
				}
				
			}
			
			
			
		}
		return schedulesDict
	}
	
	func findPostion(for key: YearMonthDay, in schedules: [(position: Int, schedule: DummySchedule?)]) -> Int {
		if schedules.isEmpty {
			// positions가 비어있을 경우
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
	
}

// dummy
struct DummySchedule {
	let scheduleId: Int
	let name: String
	let startDate: Date
	let endDate: Date
	let color: String
}








