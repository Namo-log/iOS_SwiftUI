//
//  MoimEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/17/24.
//

import Alamofire
import Foundation
import SharedUtil

public enum MoimEndPoint {
    case getMoimList
    case createMoim(MoimScheduleRequestDTO)
    case getMoimDetail(Int)
    case withdrawMoim(Int)
}

extension MoimEndPoint: EndPoint {
    public var baseURL: String {
        return "\(SecretConstants.baseURL)/schedules"
    }
    
    public var path: String {
        switch self {
        case .getMoimList, .createMoim:
            return "/meeting"
        case let .getMoimDetail(meetingScheduleId):
            return "/meeting/\(meetingScheduleId)"
        case let .withdrawMoim(meetingScheduleId):
            return "/meeting/\(meetingScheduleId)/withdraw"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getMoimList, .getMoimDetail(_):
            return .get
        case .createMoim:
            return .post
        case .withdrawMoim(_):
            return .delete
        }
    }
    
    public var task: APITask {
        switch self {
        case .getMoimList:
               return .requestPlain
        case let .getMoimDetail(meetingScheduleId):
            let parameter: [String: Any] = ["meetingScheduleId": meetingScheduleId]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        case let .createMoim(moimDto):
            return .requestJSONEncodable(parameters: moimDto)
        case let .withdrawMoim(meetingScheduleId):
            let parameter: [String: Any] = ["meetingScheduleId": meetingScheduleId]
            return .requestParameters(parameters: parameter, encoding: URLEncoding.default)
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
//        case .createMoim:
//            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
