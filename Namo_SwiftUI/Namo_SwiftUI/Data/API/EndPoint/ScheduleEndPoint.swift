//
//  ScheduleEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Alamofire

enum ScheduleEndPoint {
	case postScehdule(data: postScheduleRequest)
	case getAllSchedule
}

extension ScheduleEndPoint: EndPoint {
	var baseURL: String {
		return "\(SecretConstants.baseURL)/schedules"
	}
	
	var path: String {
		switch self {
		case .postScehdule(let data):
			return ""
		case .getAllSchedule:
			return "/all"
		}
	}
	
	var method: Alamofire.HTTPMethod {
		switch self {
		case .postScehdule(let data):
			return .post
		case .getAllSchedule:
			return .get
		}
	}
	
	var task: APITask {
		switch self {
		case .postScehdule(let data):
			return .requestJSONEncodable(parameters: data)
		case .getAllSchedule:
			return .requestPlain
		}
	}
	
	
}
