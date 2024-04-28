//
//  MoimDiaryRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import SwiftUI
import Alamofire

/// 모임 기록 API
final class MoimDiaryRepositoryImpl: MoimDiaryRepository {
    func createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimDiaryEndPoint.createMoimDiaryPlace(moimScheduleId: moimScheduleId, req: req))
        return response?.code == 200
    }
    
    func changeMoimDiaryPlace(moimLocationId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimDiaryEndPoint.changeMoimDiaryPlace(moimLocationId: moimLocationId, req: req))
        return response?.code == 200
    }
    
    func deleteMoimDiaryPlace(moimLocationId: Int) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimDiaryEndPoint.deleteMoimDiaryPlace(moimLocationId: moimLocationId))
        return response?.code == 200
    }
    
    func editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimDiaryEndPoint.editMoimDiary(scheduleId: scheduleId, req: req))
        return response?.code == 200
    }
    
    func deleteMoimDiary(moimMemoId: Int) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: MoimDiaryEndPoint.deleteMoimDiary(moimMemoId: moimMemoId))
        print("모임 기록 삭제 완료")
        print(response)
        return response?.code == 200
    }
    
    func getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO) async -> GetMoimDiaryResDTO? {
        return await APIManager.shared.performRequest(endPoint: MoimDiaryEndPoint.getMonthMoimDiary(request: req))
    }
}
