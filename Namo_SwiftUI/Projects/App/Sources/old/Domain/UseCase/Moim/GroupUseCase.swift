////
////  MoimUseCase.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 2/16/24.
////
//import Foundation
//import Factory
//import SwiftUICalendar
//
//import SharedUtil
//import CoreNetwork
//
//final class GroupUseCase {
//	static let shared = GroupUseCase()
////	@Injected(\.moimRepository) var moimRepository
//	@Injected(\.moimState) var moimState
//    @Injected(\.scheduleState) var scheduleState
//	
//	let MAX_SCHEDULE = screenHeight < 800 ? 3 : 4
//	
//	// 모임 리스트 가져오기
//	func getGroups() async -> [GroupInfo] {
//		return await moimRepository.getMoimList()?.result ?? []
//	}
//	
//	// 모임 이름 변경
//	func changeMoimName(moimId: Int, newName: String) async -> Bool {
//		return await moimRepository.changeMoimName(data: changeMoimNameRequest(groupId: moimId, groupName: newName))?.code == 200
//	}
//	
//	// 모임 탈퇴
//	func withdrawGroup(moimId: Int) async -> Bool {
//		return await moimRepository.withdrawMoim(moimId: moimId)?.code == 200
//	}
//	
//	// 모임 생성
//	func createGroup(groupName: String, image: Data?) async -> Bool {
//		return await moimRepository.createMoim(groupName: groupName, image: image)?.code == 200
//	}
//	
//	// 모임 참여
//	func participateGroup(groupCode: String) async -> Bool {
//		return await moimRepository.participateMoim(groupCode: groupCode)?.code == 200
//	}
//	
//	
//	func getMoimSchedule(moimId: Int) async {
//		let schedules = await moimRepository.getMoimSchedule(moimId: moimId)?.result ?? []
//		let mappedSchedules = setSchedule(schedules.map({$0.toMoimSchedule()}).sorted(by: {$0.startDate < $1.startDate}))
//		
//		await MainActor.run {
//			moimState.currentMoimSchedule = mappedSchedules
//		}
//	}
//	
//	func setSchedule(_ schedules: [MoimSchedule]) -> [YearMonthDay: [CalendarMoimSchedule]] {
//		var schedulesDict: [YearMonthDay: [CalendarMoimSchedule]] = [:]
//		
//		// 서버에서 받아온 스케쥴을 돌면서
//		schedules.forEach { schedule in
//			let startDate = schedule.startDate
//			let endDate = schedule.endDate.adjustDateIfMidNight()  // 종료일이 만약 자정이라면 -1초
//
//			let startYMD = startDate.toYMD()
//			
//			// 일정 지속기간 중 모든 day를 구함
//			let days = datesBetween(startDate: startDate, endDate: endDate)
//			
//			// 우선 시작날 캘린더에 표시될 postion을 구함
//			// 그 뒤 day들은 이 postion을 쭉 이어감. 단 주가 바뀌고 해당 postion의 위쪽이 비어있다면 올라감
//			var currentPosition = findPostion(schedulesDict[startYMD] ?? [])
//			
//			// 일정 지속기간동안 매일
//			days.forEach { day in
//				// 만약 주가 바뀌면(일요일) position 다시 계산
//				if day.isSunday() {
//					currentPosition = findPostion(schedulesDict[day.toYMD()] ?? [])
//				}
//				
//				
//				let currentYMD = day.toYMD()
//				
//				// schedulesDict에 해당 날짜에 data가 nil이 아니라면 = 해당 날짜에 이미 스케쥴이 있다면
//				if schedulesDict[currentYMD] != nil {
//					// 만약 현재 인덱스에 스케쥴이 nil인채로 있을 수 있음
//					// 그 nil인 스케쥴을 지우고
//					if let index = schedulesDict[currentYMD]!.firstIndex(where: {$0.position == currentPosition && $0.schedule == nil}) {
//						schedulesDict[currentYMD]?.remove(at: index)
//					}
//					// 그 자리에 스케쥴 추가
//					schedulesDict[currentYMD]?.append(CalendarMoimSchedule(position: currentPosition, schedule: schedule))
//				} else {
//					// schedulesDict에 해당 날짜에 data가 nil이라면 = 해당 날짜에 스케쥴이 없다면
//					// 그냥 현재 스케쥴을 추가함
//					schedulesDict[currentYMD] = [CalendarMoimSchedule(position: currentPosition, schedule: schedule)]
//				}
//				
//				// 아래는 캘린더 표시되기 위한 작업이므로
//				// max이상이거나 currentPostion이 0미만이라면 다음 날로
//				if currentPosition >= MAX_SCHEDULE || currentPosition < 0 { return }
//				
//				if let positions = schedulesDict[currentYMD]?.map({$0.position}) {
//					
//					var tempPostion = currentPosition
//					
//					while tempPostion >= 0 {
//						if !positions.contains(tempPostion) {
//							// 최고 포지션 밑에서 만약 스케쥴이 없다면 nil로 추가(캘린더에서 줄 맞춤을 위함)
//							schedulesDict[currentYMD]?.append(CalendarMoimSchedule(position: tempPostion, schedule: nil))
//						}
//						
//						tempPostion -= 1
//					}
//					
//					schedulesDict[currentYMD]?.sort(by: {$0.position < $1.position})
//				}
//				
//			}  //: days forEach
//		} //: schedules forEach
//		return schedulesDict
//	}
//	
//	// 시작일과 종료일 사이 Date 리턴
//	func datesBetween(startDate: Date, endDate: Date) -> [Date] {
//		var dates: [Date] = []
//		var currentYMD = startDate.toYMD()
//		let endYMD = endDate.toYMD()
//
//		while currentYMD <= endYMD {
//			dates.append(currentYMD.toDate())
//			currentYMD = currentYMD.addDay(value: 1)
//		}
//		
//		return dates
//	}
//	
//	// 현재 스케쥴들을 확인하고, 추가될 스케쥴의 포지션을 구함
//	func findPostion(_ schedules: [CalendarMoimSchedule]) -> Int {
//		
//		if schedules.isEmpty {
//			return 0
//		}
//		
//		// 스케쥴인 nil인 postion
//		let nilSchedulePositions = schedules.compactMap { $0.schedule == nil ? $0.position : nil }
//		 
//		if !nilSchedulePositions.isEmpty {
//			// nil인 포지션이 있다면 그 중 최소값을 찾음
//			return nilSchedulePositions.min()!
//		} else {
//			// nil인 포지션이 없다면, 마지막 postion의 다음 postion으로 지정
//			return schedules.last!.position + 1
//		}
//	}
//    
//    /// scheduleState.currentMoimSchedule의 내용을 추가하여 서버로 전송합니다.
//    func postNewMoimSchedule() async {
//        let temp = scheduleState.currentMoimSchedule
//        print("Current TEMPLATE: \(temp)")
//        
//        let calendar = Calendar.current
//        let startDate = temp.startDate
//        let endDate = temp.endDate
//
//        let interval = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
//        
//        guard let moimId = temp.moimId else {
//            print("moimId Required")
//            return
//        }
//        
//        let postSchedule = postMoimScheduleRequest(
//			groupId: moimId,
//            name: temp.name,
//            startDate: Int(startDate.timeIntervalSince1970),
//            endDate: Int(endDate.timeIntervalSince1970),
//            interval: interval,
//            x: temp.x,
//            y: temp.y,
//            locationName: temp.locationName,
//            users: temp.users.map{ $0.userId }
//        )
//        
//        let result = await moimRepository.postMoimSchedule(data: postSchedule)
//        print("API 요청 결과 : \(String(describing: result))")
//        
//        // TODO: 해당 부분 그룹 캘린더용으로 업데이트 필요
//        if result != nil {
//            DispatchQueue.main.async {
//				NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil, userInfo: ["date": temp.startDate.toYMD()])
//            }
//        }
//        
//    }
//    
//    /// scheduleState.currentSchedule의 내용을 추가하여 서버로 전송 - 기존 정보를 수정합니다.
//    func patchMoimSchedule() async {
//        let temp = scheduleState.currentMoimSchedule
//        
//        guard let scheduleId = temp.moimScheduleId else {
//            print("ScheduleID not included")
//            return
//        }
//        
//        let calendar = Calendar.current
//        let startDate = temp.startDate
//        let endDate = temp.endDate
//
//        let interval = calendar.dateComponents([.day], from: startDate, to: endDate).day ?? 0
//        
//        let patchSchedule = patchMoimScheduleRequest(
//            moimScheduleId: scheduleId,
//            name: temp.name,
//            startDate: Int(startDate.timeIntervalSince1970),
//            endDate: Int(endDate.timeIntervalSince1970),
//            interval: interval,
//            x: temp.x,
//            y: temp.y,
//            locationName: temp.locationName,
//            users: temp.users.map { $0.userId }
//        )
//        
//        let result = await moimRepository.patchMoimSchedule(scheduleId: scheduleId, data: patchSchedule)
//		if result != nil {
//			DispatchQueue.main.async {
//				NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil, userInfo: ["date": temp.startDate.toYMD()])
//			}
//		}
//		
//        print(String(describing: result))
//    }
//    
//    /// 현재 수정하고 있는 스케쥴을 서버로 삭제 요청합니다.
//    func deleteMoimSchedule() async {
//        let temp = scheduleState.currentMoimSchedule
//        
//        guard let scheduleId = temp.moimScheduleId else {
//            print("ScheduleID not included")
//            return
//        }
//        
//        let result = await moimRepository.deleteMoimSchedule(scheduleId: scheduleId)
//		await MainActor.run {
//			NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil)
//		}
//        print(String(describing: result))
//    }
//    
//    /// 지도에서 선택한 selectedPlace의 정보를 currentMoimSchedule에 저장합니다
//    func setPlaceToCurrentMoimSchedule() {
//		if let place = AppState.shared.placeState.selectedPlace {
//            scheduleState.currentMoimSchedule.locationName = place.name
//            scheduleState.currentMoimSchedule.x = place.x
//            scheduleState.currentMoimSchedule.y = place.y
//        }
//    }
//    
//    /// 홈 화면에서 선택한 Schedule을 Edit 화면에서 사용할 currentMoimSchedule로 저장합니다.
//    /// nil로 입력 받는 경우 모두 기본값으로 생성합니다.
//    func setScheduleToCurrentMoimSchedule(schedule: MoimSchedule?) {
//        
//        DispatchQueue.main.async {
//			self.scheduleState.currentMoimSchedule = MoimScheduleTemplate(
//                moimScheduleId: schedule?.moimScheduleId,
//                name: schedule?.name,
//                startDate: schedule?.startDate,
//                endDate: schedule?.endDate,
//                x: schedule?.x,
//                y: schedule?.y,
//                locationName: schedule?.locationName,
//                users: schedule?.users
//            )
//        }
//    }
//    
//    /// CheckParticipant에서 선택한 selectedUser들의 정보를 currentMoimSchedule에 저장합니다
//    func setSelectedUserListToCurrentMoimSchedule(list: [GroupUser]) {
//        scheduleState.currentMoimSchedule.users = list
//    }
//	
//	func hideToast() {
//		if moimState.showGroupWithdrawToast {
//			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//				self.moimState.showGroupWithdrawToast = false
//			}
//		}
//		
//		if moimState.showGroupCodeCopyToast {
//			DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//				self.moimState.showGroupCodeCopyToast = false
//			}
//		}
//	}
//    
//    func patchMoimScheduleCategory(date: Date) async {
//        guard let scheduleId = scheduleState.currentSchedule.scheduleId else {
//            print("currentSchedule.scheduleId nessesary")
//            return
//        }
//        
//        let result = await moimRepository.patchMoimScheduleCategory(data: .init(
//            moimScheduleId: scheduleId,
//            categoryId: scheduleState.currentSchedule.categoryId
//        ))
//        
//        DispatchQueue.main.async {
//            NotificationCenter.default.post(name: .reloadCalendarViaNetwork, object: nil, userInfo: ["date": date.toYMD()])
//        }
//    }
//}
