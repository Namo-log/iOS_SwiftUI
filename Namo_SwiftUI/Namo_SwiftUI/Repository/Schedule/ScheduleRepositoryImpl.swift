//
//  ScheduleRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import Foundation
import Alamofire

/// `ScheduleRepository의 Implement Class` 입니다.
final class ScheduleRepositoryImpl: ScheduleRepository {
    
    func fetchSchedule(id: Int) async -> testGetDeDTO? {
        return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.getSchedule(id: id))
    }
    
    func postSchedule(data: testEnDTO) async -> testDeDTO? {
        return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.postScehdule(dto: data))
    }
    
    func test() async -> testDecodeDTO? {
        return await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.test)
    }
}

/// `ScheduleRepository의 Test용 Implement Class` 입니다.
final class ScheduleRepositoryTest: ScheduleRepository {
    
    func fetchSchedule(id: Int) async -> testGetDeDTO? {
        // 테스트용 구현: 임의의 값을 반환
        return testGetDeDTO(asdfasdfasdfasd: "Test Fetch Schedule")
    }
    
    func postSchedule(data: testEnDTO) async -> testDeDTO? {
        // 테스트용 구현: 임의의 값을 반환
        let testItem = testDeDTOItem(asdf: "Test Post Schedule", test: 42)
        return [testItem]
    }
    
    func test() async -> testDecodeDTO? {
        // 테스트용 구현: 임의의 값을 반환
        let testItem = testDecodeDTOItem(status: Status(verified: true, sentCount: 2),
                                         id: "123456789",
                                         user: "testUser",
                                         text: "Test Text",
                                         v: 1,
                                         source: "Test Source",
                                         updatedAt: "2024-02-01T12:34:56Z",
                                         type: "Test Type",
                                         createdAt: "2024-02-01T12:34:56Z",
                                         deleted: false,
                                         used: true)
        return [testItem]
    }
}


