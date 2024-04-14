//
//  DiaryRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import SwiftUI
import Alamofire

final class DiaryRepositoryImpl: DiaryRepository {
    func createDiary(scheduleId: Int, content: String, images: [Data?]) async -> CreateDiaryResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: DiaryEndPoint.createDiary(scheduleId: scheduleId, content: content, images: images))
    }
    
    func getMonthDiary(request: GetDiaryRequestDTO) async -> GetDiaryResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: DiaryEndPoint.getMonthDiary(request: request))
    }
    
    func changeDiary(scheduleId: Int, content: String, images: [Data?]) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: DiaryEndPoint.changeDiary(scheduleId: scheduleId, content: content, images: images))
        return response?.code == 200
    }
    
    func deleteDiary(scheduleId: Int) async -> Bool {
        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: DiaryEndPoint.deleteDiary(diaryId: scheduleId))
        return response?.code == 200
    }
}

//
//final class DiaryRepositoryImplTest: DiaryRepository {
//    func createDiary(scheduleId: Int, content: String, images: [Data?]) async -> CreateDiaryResponseDTO? {
////        return await APIManager.shared.performRequest(endPoint: DiaryEndPoint.createDiary(scheduleId: scheduleId, content: content, images: images))
//        return CreateDiaryResponseDTO(scheduleId: 468)
//    }
//    
//    func getMonthDiary(request: GetDiaryRequestDTO) async -> GetDiaryResponseDTO? {
////        return await APIManager.shared.performRequest(endPoint: DiaryEndPoint.getMonthDiary(request: request))
//        return GetDiaryResponseDTO(content: [Diary(scheduleId: 1, name: "test", startDate: 0, contents: "eewfewfsdfsdiufhdshkdshfkdjdfjhkfjdhkjdjfshjkdljfhjk", urls: ["https://www.juso.go.kr/img/content/know_addr_4.png", "https://i.pinimg.com/236x/c3/56/b9/c356b9bfff383d3dfd12066dc3220fa0.jpg"], color: 1)], currentPage: 0, size: 5, first: true, last: true)
//    }
//    
//    func changeDiary(scheduleId: Int, content: String, images: [Data?]) async -> Bool {
//        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: DiaryEndPoint.changeDiary(scheduleId: scheduleId, content: content, images: images))
//        return response?.code == 200
//    }
//    
//    func deleteDiary(diaryId: Int) async -> Bool {
//        let response: BaseResponse<String>? = await APIManager.shared.performRequestBaseResponse(endPoint: DiaryEndPoint.deleteDiary(diaryId: diaryId))
//        return response?.code == 200
//    }
//}
