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
    case getPresignedUrl(prefix: String, filename: String)
}

extension MoimEndPoint: EndPoint {
    public var baseURL: String {
        return "\(SecretConstants.baseURL)"
    }
    
    public var path: String {
        switch self {
        case .getMoimList, .createMoim:
            return "/schedules/meeting"
        case .getPresignedUrl:
            return "/s3/generate-presigned-url"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getMoimList:
            return .get
        case .createMoim:
            return .post
        case .getPresignedUrl:
            return .get
        }
    }
    
    public var task: APITask {
        switch self {
        case .getMoimList:
               return .requestPlain
        case let .createMoim(moimDto):            
            return .requestJSONEncodable(parameters: moimDto)
        case let .getPresignedUrl(prefix, filename):
            let parameter: [String: String] = [
                "prefix": prefix,
                "fileName": filename
            ]
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
