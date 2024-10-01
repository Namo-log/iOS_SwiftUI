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
}

extension MoimEndPoint: EndPoint {
	public var baseURL: String {
		return "\(SecretConstants.baseURL)"
	}
	
	public var path: String {
		switch self {
        case .getMoimList:
            return "/schedules/meeting"
		}
	}
	
	public var method: Alamofire.HTTPMethod {
		switch self {
        case .getMoimList:
            return .get
        }
	}
	
	public var task: APITask {
		switch self {
        case .getMoimList:
                .requestPlain
		}
	}
	
	public var headers: HTTPHeaders? {
		switch self {
		default:
			return ["Content-Type": "application/json"]
		}
	}
}
