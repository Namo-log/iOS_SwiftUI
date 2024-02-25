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
    case patchSchedule(scheduleId: Int, data: postScheduleRequest)
}

extension ScheduleEndPoint: EndPoint {
	var baseURL: String {
		return "\(SecretConstants.baseURL)/schedules"
	}
	
	var path: String {
		switch self {
		case .postScehdule:
			return ""
		case .getAllSchedule:
			return "/all"
        case let .patchSchedule(scheduleId, _):
            return "/\(scheduleId)"
		}
	}
	
	var method: HTTPMethod {
		switch self {
		case .postScehdule:
			return .post
		case .getAllSchedule:
			return .get
        case .patchSchedule:
            return .patch
		}
	}
	
	var task: APITask {
		switch self {
        case let .postScehdule(data), let .patchSchedule(_, data):
			return .requestJSONEncodable(parameters: data)
		case .getAllSchedule:
			return .requestPlain
		}
	}
	
	
}
