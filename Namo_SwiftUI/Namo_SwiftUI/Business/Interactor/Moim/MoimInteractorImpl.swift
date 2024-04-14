//
//  MoimInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//
import Foundation
import Factory
import SwiftUICalendar

struct MoimInteractorImpl: MoimInteractor {
	@Injected(\.moimRepository) var moimRepository
	@Injected(\.appState) var appState
	@Injected(\.moimState) var moimState
	
	let MAX_SCHEDULE = screenHeight < 800 ? 3 : 4
	
	// 모임 리스트 가져오기
	func getGroups() async {
		DispatchQueue.main.async {
			appState.isLoading = true
		}
		let moims = await moimRepository.getMoimList() ?? []
		
		DispatchQueue.main.async {
			moimState.moims = moims
			appState.isLoading = false
		}
	}
	
	// 모임 이름 변경
	func changeMoimName(moimId: Int, newName: String) async -> Bool {
		return await moimRepository.changeMoimName(data: changeMoimNameRequest(moimId: moimId, moimName: newName))
	}
	
	// 모임 탈퇴
	func withdrawGroup(moimId: Int) async -> Bool {
		return await moimRepository.withdrawMoim(moimId: moimId)
	}
	
	func getMoimSchedule(moimId: Int) async {
		let schedules = await moimRepository.getMoimSchedule(moimId: moimId) ?? []
		let mappedSchedules = setSchedule(schedules.map({$0.toMoimSchedule()}).sorted(by: {$0.startDate < $1.startDate}))
		
		await MainActor.run {
			moimState.currentMoimSchedule = mappedSchedules
		}
	}
	
	func setSchedule(_ schedules: [MoimSchedule]) -> [YearMonthDay: [CalendarMoimSchedule]] {
		var schedulesDict: [YearMonthDay: [CalendarMoimSchedule]] = [:]
		
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
					schedulesDict[currentYMD]?.append(CalendarMoimSchedule(position: currentPosition, schedule: schedule))
				} else {
					// schedulesDict에 해당 날짜에 data가 nil이라면 = 해당 날짜에 스케쥴이 없다면
					// 그냥 현재 스케쥴을 추가함
					schedulesDict[currentYMD] = [CalendarMoimSchedule(position: currentPosition, schedule: schedule)]
				}
				
				// 아래는 캘린더 표시되기 위한 작업이므로
				// max이상이거나 currentPostion이 0미만이라면 다음 날로
				if currentPosition >= MAX_SCHEDULE || currentPosition < 0 { return }
				
				if let positions = schedulesDict[currentYMD]?.map({$0.position}) {
					
					var tempPostion = currentPosition
					
					while tempPostion >= 0 {
						if !positions.contains(tempPostion) {
							// 최고 포지션 밑에서 만약 스케쥴이 없다면 nil로 추가(캘린더에서 줄 맞춤을 위함)
							schedulesDict[currentYMD]?.append(CalendarMoimSchedule(position: tempPostion, schedule: nil))
						}
						
						tempPostion -= 1
					}
					
					schedulesDict[currentYMD]?.sort(by: {$0.position < $1.position})
				}
				
			}  //: days forEach
		} //: schedules forEach
		return schedulesDict
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
	
	// 현재 스케쥴들을 확인하고, 추가될 스케쥴의 포지션을 구함
	func findPostion(_ schedules: [CalendarMoimSchedule]) -> Int {
		
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
}
