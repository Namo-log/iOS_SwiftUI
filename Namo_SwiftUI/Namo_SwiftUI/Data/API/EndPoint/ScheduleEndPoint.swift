//
//  ScheduleEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Alamofire

enum ScheduleEndPoint {
    case getAllSchedule
	case postSchedule(data: postScheduleRequest)
    case patchSchedule(scheduleId: Int, data: postScheduleRequest)
}

extension ScheduleEndPoint: EndPoint {
	var baseURL: String {
		return "\(SecretConstants.baseURL)/schedules"
	}
	
	var path: String {
		switch self {
        case .getAllSchedule:
            return "/all"
		case .postSchedule:
			return ""
        case let .patchSchedule(scheduleId, _):
            return "/\(scheduleId)"
		}
	}
	
	var method: HTTPMethod {
		switch self {
        case .getAllSchedule:
            return .get
		case .postSchedule:
			return .post
        case .patchSchedule:
            return .patch
		}
	}
	
	var task: APITask {
		switch self {
        case .getAllSchedule:
            return .requestPlain
        case let .postSchedule(data), let .patchSchedule(_, data):
			return .requestJSONEncodable(parameters: data)
		}
	}
	
	
}
