//
//  ScheduleEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Alamofire

import SharedUtil

public enum ScheduleEndPoint {
	case getSchedule(startDate: String, endDate: String)
}

extension ScheduleEndPoint: EndPoint {
	public var baseURL: String {
		return "\(SecretConstants.baseURL)/schedules"
	}
	
	public var path: String {
		switch self {
		case .getSchedule:
			return "/calendar"
		}
	}
	
	public var method: HTTPMethod {
		switch self {
		case .getSchedule:
			return .get
		}
	}
	
	public var task: APITask {
        switch self {
		case let .getSchedule(startDate, endDate):
			var parameters: [String: Any] = [
				"startDate": startDate,
				"endDate": endDate
			]
			return .requestParameters(
				parameters: parameters,
				encoding: URLEncoding.default
			)
        }
	}
	
	
}
