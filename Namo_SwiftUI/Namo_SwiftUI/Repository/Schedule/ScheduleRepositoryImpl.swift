//
//  ScheduleRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Alamofire

final class ScheduleRepositoryImpl: ScheduleRepository {
	func postSchedule(data: postScheduleRequest) async -> postScheduleResponse? {
		return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.postSchedule(data: data))
	}
	
	func getAllSchedule() async -> getScheduleResponse? {
		return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.getAllSchedule)
	}
    /// 유저의 개인 일정을 수정합니다
    func patchSchedule(scheduleId: Int, data: postScheduleRequest) async -> postScheduleResponse? {
        return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.patchSchedule(scheduleId: scheduleId, data: data))
    }
    
    /// 유저의 일정을 삭제합니다
    /// 모임 일정인 경우 isMoim에 true 체크
    func deleteSchedule(scheduleId: Int, isMoim: Bool) async -> String? {
        return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.deleteSchedule(scheduleId: scheduleId, isMoim: isMoim))
    }
}
