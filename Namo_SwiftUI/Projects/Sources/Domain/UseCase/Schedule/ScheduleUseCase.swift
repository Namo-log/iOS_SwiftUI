//
//  ScheduleUseCase.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import SwiftUICalendar
import SwiftUI
import Factory

final class ScheduleUseCase {
	static let shared = ScheduleUseCase()
	@Injected(\.scheduleState) private var scheduleState
	@Injected(\.scheduleRepository) private var scheduleRepository
	
	let MAX_SCHEDULE = screenHeight < 800 ? 3 : 4
	
	// 1: 캘린더 데이터를 세팅하기 위해 View에서 호출하는 함수
	func setCalendar() async -> [YearMonthDay: [CalendarSchedule]] {
		// 네트워크를 통해 데이터 가져오기
		let schedules = await getSchedulesViaNetwork()
		// 해당 데이터 매핑해서 state로
		let mappedSchedules = setSchedules(schedules.sorted(by: {$0.startDate < $1.startDate}))
		
		return mappedSchedules
	}
	
	// 2: 네트워크를 통해 일정 가져오기
	func getSchedulesViaNetwork() async -> [Schedule] {
		if let schedules = await scheduleRepository.getAllSchedule() {
			return schedules.map({ $0.toSchedule() })
		} else {
			return []
		}
	}
	
	// 4: 서버에서 받아온 스케쥴들을 View의 Model로 매핑
	func setSchedules(_ schedules: [Schedule], calculatedSchedules: [YearMonthDay: [CalendarSchedule]] = [:]) -> [YearMonthDay: [CalendarSchedule]] {
		var schedulesDict: [YearMonthDay: [CalendarSchedule]] = calculatedSchedules
		
		// 서버에서 받아온 스케쥴을 돌면서
		schedules.forEach { schedule in
			let startDate = schedule.startDate
			let endDate = schedule.endDate.adjustDateIfMidNight()  // 종료일이 만약 자정이라면 -1초

			let startYMD = startDate.toYMD()
			
			// 일정 지속기간 중 모든 day를 구함
			let days = datesBetween(startDate: startDate, endDate: endDate)
			
			// 우선 시작날 캘린더에 표시될 postion을 구함
			// 그 뒤 day들은 이 postion을 쭉 이어감. 단 주가 바뀌고 해당 postion의 위쪽이 비어있다면 올라감
			var currentPosition = findPostion(schedulesDict[startYMD] ?? [])
			
			// 일정 지속기간동안 매일
			days.forEach { day in
				// 만약 주가 바뀌면(일요일) position 다시 계산
				if day.isSunday() {
					currentPosition = findPostion(schedulesDict[day.toYMD()] ?? [])
				}
				
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
		var currentYMD = startDate.toYMD()
		let endYMD = endDate.toYMD()
		
		while currentYMD <= endYMD {
			dates.append(currentYMD.toDate())
			currentYMD = currentYMD.addDay(value: 1)
		}
		
		return dates
	}
	
	func getScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: Schedule) -> String {
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
	
	func getMoimScheduleTimeWithCurrentYMD(currentYMD: YearMonthDay, schedule: MoimSchedule) -> String {
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
	
    /// 지도에서 선택한 selectedPlace의 정보를 currentSchedule에 저장합니다
    func setPlaceToCurrentSchedule() {
		if let place = AppState.shared.placeState.selectedPlace {
            scheduleState.currentSchedule.locationName = place.name
            scheduleState.currentSchedule.x = place.x
            scheduleState.currentSchedule.y = place.y
        }
    }
    
    /// scheduleState.currentSchedule의 내용을 추가하여 서버로 전송합니다.
    func postNewSchedule() async {
        let temp = scheduleState.currentSchedule
        
        let calendar = Calendar.current
        let startDate = temp.startDate
        let endDate = temp.endDate

        let interval = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        
        let postSchedule = postScheduleRequest(
            name: temp.name,
            startDate: Int(startDate.timeIntervalSince1970),
            endDate: Int(endDate.timeIntervalSince1970),
            interval: interval,
            alarmDate: temp.alarmDate,
            x: temp.x,
            y: temp.y,
            locationName: temp.locationName,
            categoryId: temp.categoryId
        )
        
        let result = await scheduleRepository.postSchedule(data: postSchedule)
		if result != nil {	
			DispatchQueue.main.async {
				NotificationCenter.default.post(name: .reloadCalendarViaNetwork, object: nil, userInfo: ["date": temp.startDate.toYMD()])
			}
		}
        print(String(describing: result))
    }
    
    /// scheduleState.currentSchedule의 내용을 추가하여 서버로 전송 - 기존 정보를 수정합니다.
    func patchSchedule() async {
        let temp = scheduleState.currentSchedule
        
        guard let scheduleId = temp.scheduleId else {
            print("ScheduleID not included")
            return
        }
        
        let calendar = Calendar.current
        let startDate = temp.startDate
        let endDate = temp.endDate

        let interval = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
        
        let postSchedule = postScheduleRequest(
            name: temp.name,
            startDate: Int(startDate.timeIntervalSince1970),
            endDate: Int(endDate.timeIntervalSince1970),
            interval: interval,
            alarmDate: temp.alarmDate,
            x: temp.x,
            y: temp.y,
            locationName: temp.locationName,
            categoryId: temp.categoryId
        )
        
        let result = await scheduleRepository.patchSchedule(scheduleId: scheduleId, data: postSchedule)
		if result != nil {
			DispatchQueue.main.async {
				NotificationCenter.default.post(name: .reloadCalendarViaNetwork, object: nil, userInfo: ["date": temp.startDate.toYMD()])
			}
		}
        print(String(describing: result))
    }
    
    /// 현재 수정하고 있는 스케쥴을 서버로 삭제 요청합니다.
	func deleteSchedule(isMoim: Bool) async {
        let temp = scheduleState.currentSchedule
        
        guard let scheduleId = temp.scheduleId else {
            print("ScheduleID not included")
            return
        }
        
        let result = await scheduleRepository.deleteSchedule(scheduleId: scheduleId, isMoim: isMoim)
		await MainActor.run {
			NotificationCenter.default.post(name: .reloadCalendarViaNetwork, object: nil)
		}
        print(String(describing: result))
    }
    
    /// 홈 화면에서 선택한 Schedule을 Edit 화면에서 사용할 currentSchedule로 저장합니다.
    /// nil로 입력 받는 경우 모두 기본값으로 생성합니다.
    func setScheduleToCurrentSchedule(schedule: Schedule?) {
        DispatchQueue.main.async {
			self.scheduleState.currentSchedule = ScheduleTemplate(
                scheduleId: schedule?.scheduleId,
                name: schedule?.name,
                categoryId: schedule?.categoryId,
                startDate: schedule?.startDate,
                endDate: schedule?.endDate,
                alarmDate: schedule?.alarmDate,
                x: schedule?.x,
                y: schedule?.y,
                locationName: schedule?.locationName
            )
			self.scheduleState.isCurrentScheduleIsGroup = schedule?.moimSchedule ?? false
        }
    }
    
    /// MoimSchedule을 currentMoimSchedule로 저장합니다.
    /// nil로 입력 받는 경우 모두 기본값으로 생성합니다.
    func setScheduleToCurrentMoimSchedule(schedule: Schedule?, users: [GroupUser]?) {
        DispatchQueue.main.async {
			self.scheduleState.currentMoimSchedule = .init(
                moimScheduleId: schedule?.scheduleId,
                name: schedule?.name,
                startDate: schedule?.startDate,
                endDate: schedule?.endDate,
                x: schedule?.x,
                y: schedule?.y,
                locationName: schedule?.locationName,
                users: users
            )
        }
    }
	
	/// 두 Date사이의 모든 YearMonth를 구합니다.
	func yearMonthBetween(start: Date, end: Date) -> [YearMonth] {
		var result: [YearMonth] = []
		let calendar = Calendar.current
		
		var currentDate = start
		while currentDate <= end {
			let yearMonth = currentDate.toYM()
			result.append(yearMonth)
			currentDate = calendar.date(byAdding: .month, value: 1, to: currentDate)!
		}
		
		return result
	}
    
    /// 현재 focusDate를 기준으로 생성할 일정의 startDate와 endDate 반환
	func newScheduleDate(focusDate: YearMonthDay?) -> (Date, Date)? {
        if let focusDate = focusDate?.toDate() {
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: focusDate)
            
            dateComponents.hour = 8
            let startDate = calendar.date(from: dateComponents) ?? focusDate
            
            dateComponents.hour = 9
            let endDate = calendar.date(from: dateComponents) ?? focusDate
			
			return (startDate, endDate)
		} else {
			return nil
		}
    }
    
    
    /// 현재 focusDate를 추가하는 모임 일정 템플릿의 날짜로 설정합니다
    func setDateAndTimesToCurrentMoimSchedule(focusDate: YearMonthDay?) {
        if let focusDate = focusDate?.toDate() {
            let calendar = Calendar.current
            var dateComponents = calendar.dateComponents([.year, .month, .day], from: focusDate)
            
            dateComponents.hour = 8
            let startDate = calendar.date(from: dateComponents)
            
            dateComponents.hour = 9
            let endDate = calendar.date(from: dateComponents)
            scheduleState.currentMoimSchedule.startDate = startDate ?? focusDate
            scheduleState.currentMoimSchedule.endDate = endDate ?? focusDate
        }
    }
}
