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
    case editMoim(meetingScheduleId: Int, moimReqDto: MoimScheduleEditRequestDTO)
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
        case let .editMoim(meetingScheduleId, _):
            return "/meeting/\(meetingScheduleId)"
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
        case .editMoim(_, _):
            return .patch
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
        case let .editMoim(_, moimReqDto):            
            return .requestJSONEncodable(parameters: moimReqDto)
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
