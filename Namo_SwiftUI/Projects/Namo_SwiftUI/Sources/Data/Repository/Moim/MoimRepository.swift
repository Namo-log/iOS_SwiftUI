//
//  MoimRepository.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/17/24.
//

import Foundation
import Networks

protocol MoimRepository {
	func createMoim(groupName: String, image: Data?) async -> BaseResponse<createMoimResponse>?
	func getMoimList() async -> BaseResponse<getMoimListResponse>?
	func changeMoimName(data: changeMoimNameRequest) async -> BaseResponse<Int>?
	func participateMoim(groupCode: String) async -> BaseResponse<paricipateGroupResponse>?
	func withdrawMoim(moimId: Int) async -> BaseResponse<EmptyResponse>?
	func getMoimSchedule(moimId: Int) async -> BaseResponse<getMoimScheduleResponse>?
    func postMoimSchedule(data: postMoimScheduleRequest) async -> BaseResponse<Int>?
    func patchMoimSchedule(scheduleId: Int, data: patchMoimScheduleRequest) async -> BaseResponse<Int>?
    func patchMoimScheduleCategory(data: patchMoimScheduleCategoryRequest) async -> BaseResponse<Int>?
    func deleteMoimSchedule(scheduleId: Int) async -> BaseResponse<Int>?
}
