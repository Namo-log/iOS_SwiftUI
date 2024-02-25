//
//  ScheduleRepository.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

protocol ScheduleRepository {
	func postSchedule(data: postScheduleRequest) async -> postScheduleResponse?
	func getAllSchedule() async -> getScheduleResponse?
    func patchSchedule(scheduleId: Int, data: postScheduleRequest) async -> postScheduleResponse?
}
