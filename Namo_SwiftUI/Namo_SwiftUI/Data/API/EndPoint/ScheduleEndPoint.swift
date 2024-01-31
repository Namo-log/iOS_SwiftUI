//
//  ScheduleEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/30/24.
//

import Alamofire
import Foundation

/// Schedule 관련 네트워크 요청 시 사용하는 통신 케이스를 정의한 열거형입니다.
enum ScheduleEndPoint {
    /// 지정된 ID에 해당하는 스케줄 데이터를 가져옵니다.
    case getSchedule(id: Int)
    /// 주어진 데이터를 사용하여 새로운 스케줄을 서버에 등록하고, 등록 결과를 가져옵니다.
    case postScehdule(dto: testEnDTO)
    /// 서버에서 특정 테스트 데이터를 가져옵니다.
    case test
}

extension ScheduleEndPoint: EndPoint {
    
    var baseURL: String {
//        return "\(SecretConstants.baseURL)/api/schedule"
//        return "http://192.168.35.211:8080"
        return "https://cat-fact.herokuapp.com"
    }
    
    var path: String {
        switch self {
        case .getSchedule(id: let id):
            return "?scheduleId=\(id)"
        case .test:
//            return "/test/get"
            return "/facts"
        default:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getSchedule, .test:
            return .get
        case .postScehdule:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
        case .getSchedule, .test:
            return .requestPlain
        case .postScehdule(dto: let dto):
            return .requestJSONEncodable(parameters: dto)
        }
    }
}
