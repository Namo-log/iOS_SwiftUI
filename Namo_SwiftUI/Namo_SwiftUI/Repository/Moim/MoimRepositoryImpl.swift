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
	
	func changeMoimName(data: changeMoimNameRequest) async -> Int? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.changeMoimName(data: data))
	}
	
	func participateMoim(groupCode: String) async -> Int? {
		return await APIManager.shared.performRequest(endPoint: MoimEndPoint.participateMoim(groupCode: groupCode))
	}
	
	func withdrawMoim(moimId: Int) async -> Bool {
		// TODO: result가 아예 없어서 제네릭을 사용하기 위해 아무 Model 기입. 수정 필요
		let response: BaseResponse<Moim>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimEndPoint.withdrawMoim(moimId: moimId))
		
		return response?.code == 200 ? true : false
	}
	
	
	
}
