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
        return await performRequest(endPoint: ScheduleEndPoint.getSchedule(id: id))
    }
    
    func postSchedule(data: testEnDTO) async -> testDeDTO? {
        return await performRequest(endPoint: ScheduleEndPoint.postScehdule(dto: data))
    }
    
    func test() async -> testDecodeDTO? {
        return await performRequest(endPoint: ScheduleEndPoint.test)
    }
}


