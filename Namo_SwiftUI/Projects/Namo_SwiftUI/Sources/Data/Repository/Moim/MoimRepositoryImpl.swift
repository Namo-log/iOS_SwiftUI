//
//  MoimRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/17/24.
//

import Foundation
import Networks

final class MoimRepositoryImpl: MoimRepository {
	func createMoim(groupName: String, image: Data?) async -> BaseResponse<createMoimResponse>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.createMoim(groupName: groupName, image: image))
	}
	
	func getMoimList() async -> BaseResponse<getMoimListResponse>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimList)
	}
	
	func changeMoimName(data: changeMoimNameRequest) async -> BaseResponse<Int>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.changeMoimName(data: data))
	}
	
	func participateMoim(groupCode: String) async -> BaseResponse<paricipateGroupResponse>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.participateMoim(groupCode: groupCode))
	}
	
	func withdrawMoim(moimId: Int) async -> BaseResponse<EmptyResponse>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.withdrawMoim(moimId: moimId))
	}
	
	func getMoimSchedule(moimId: Int) async -> BaseResponse<getMoimScheduleResponse>? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimSchedule(moimId: moimId))
	}
	
    func postMoimSchedule(data: postMoimScheduleRequest) async -> BaseResponse<Int>? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.postMoimSchedule(data: data))
    }
    
    func patchMoimSchedule(scheduleId: Int, data: patchMoimScheduleRequest) async -> BaseResponse<Int>? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.patchMoimSchedule(data: data))
    }
    
    func deleteMoimSchedule(scheduleId: Int) async -> BaseResponse<Int>? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.deleteMoimSchedule(scheduleId: scheduleId))
    }
    
    func patchMoimScheduleCategory(data: patchMoimScheduleCategoryRequest) async -> BaseResponse<Int>? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.patchMoimScheduleCategory(data: data))
    }
}
