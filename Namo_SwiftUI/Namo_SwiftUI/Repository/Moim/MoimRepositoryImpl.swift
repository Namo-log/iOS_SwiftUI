//
//  MoimRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/17/24.
//

import Foundation

final class MoimRepositoryImpl: MoimRepository {
	func createMoim(groupName: String, image: Data?) async -> createMoimResponse? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.createMoim(groupName: groupName, image: image))
	}
	
	func getMoimList() async -> getMoimListResponse? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimList)
	}
	
	func changeMoimName(data: changeMoimNameRequest) async -> Bool {
		let response: BaseResponse<Int>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimEndPoint.changeMoimName(data: data))
		
		return response?.code == 200
	}
	
	func participateMoim(groupCode: String) async -> Bool {
		let response: BaseResponse<Int>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimEndPoint.participateMoim(groupCode: groupCode))
		
		return response?.code == 200
	}
	
	func withdrawMoim(moimId: Int) async -> Bool {
		// TODO: result가 아예 없어서 제네릭을 사용하기 위해 아무 Model 기입. 수정 필요
		let response: BaseResponse<Moim>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimEndPoint.withdrawMoim(moimId: moimId))
		
		return response?.code == 200
	}
	
	func getMoimSchedule(moimId: Int) async -> getMoimScheduleResponse? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimSchedule(moimId: moimId))
	}
	
    func postMoimSchedule(data: postMoimScheduleRequest) async -> Int? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.postMoimSchedule(data: data))
    }
    
    func patchMoimSchedule(scheduleId: Int, data: patchMoimScheduleRequest) async -> String? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.patchMoimSchedule(data: data))
    }
    
    func deleteMoimSchedule(scheduleId: Int) async -> String? {
        return await APIManager.shared.performRequest(endPoint: MoimEndPoint.deleteMoimSchedule(scheduleId: scheduleId))
    }
}
