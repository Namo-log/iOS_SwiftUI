//
//  ScheduleEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/5/24.
//

import Alamofire

import SharedUtil

public enum ScheduleEndPoint {
    case getAllSchedule
	case postSchedule(data: postScheduleRequest)
    case patchSchedule(scheduleId: Int, data: postScheduleRequest)
    case deleteSchedule(scheduleId: Int, isMoim: Bool)
}

extension ScheduleEndPoint: EndPoint {
	public var baseURL: String {
		return "\(SecretConstants.baseURL)/schedules"
	}
	
	public var path: String {
		switch self {
        case .getAllSchedule:
            return "/all"
		case .postSchedule:
			return ""
        case let .patchSchedule(scheduleId, _):
            return "/\(scheduleId)"
        case let .deleteSchedule(scheduleId, isMoim):
            return "/\(scheduleId)/\(isMoim ? 1 : 0)"
		}
	}
	
	public var method: HTTPMethod {
		switch self {
        case .getAllSchedule:
            return .get
		case .postSchedule:
			return .post
        case .patchSchedule:
            return .patch
        case .deleteSchedule:
            return .delete
		}
	}
	
	public var task: APITask {
        switch self {
        case .getAllSchedule, .deleteSchedule:
            return .requestPlain
        case let .postSchedule(data), let .patchSchedule(_, data):
            return .requestJSONEncodable(parameters: data)
        }
	}
	
	
}
