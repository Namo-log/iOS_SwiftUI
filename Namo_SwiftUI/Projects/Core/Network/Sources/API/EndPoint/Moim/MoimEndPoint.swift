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
	case createMoim(groupName: String, image: Data?)
	case getMoimList
	case changeMoimName(data: changeMoimNameRequest)
	case participateMoim(groupCode: String)
	case withdrawMoim(moimId: Int)
	case getMoimSchedule(moimId: Int)
    // Schedule
    case postMoimSchedule(data: postMoimScheduleRequest)
    case patchMoimSchedule(data: patchMoimScheduleRequest)
    case deleteMoimSchedule(scheduleId: Int)
    case patchMoimScheduleCategory(data: patchMoimScheduleCategoryRequest)
}

extension MoimEndPoint: EndPoint {
	public var baseURL: String {
		return "\(SecretConstants.baseURL)"
	}
	
	public var path: String {
		switch self {
		case .createMoim:
			return "/groups"
		case .getMoimList:
			return "/groups"
		case .changeMoimName:
			return "/groups/name"
		case .participateMoim(let groupCode):
			return "/groups/participate/\(groupCode)"
		case .withdrawMoim(let moimId):
			return "/groups/withdraw/\(moimId)"
		case .getMoimSchedule(let moimId):
			return "/group/schedules/\(moimId)/all"
        case .postMoimSchedule, .patchMoimSchedule:
            return "/group/schedules"
        case .patchMoimScheduleCategory:
            return "/group/schedules/category"
        case .deleteMoimSchedule(scheduleId: let scheduleId):
            return "/group/schedules/\(scheduleId)"
		}
	}
	
	public var method: Alamofire.HTTPMethod {
		switch self {
		case .createMoim:
			return .post
		case .getMoimList:
			return .get
		case .changeMoimName:
			return .patch
		case .participateMoim:
			return .patch
		case .withdrawMoim:
			return .delete
		case .getMoimSchedule:
			return .get
        case .postMoimSchedule:
            return .post
        case .patchMoimSchedule:
            return .patch
        case .patchMoimScheduleCategory:
            return .patch
        case .deleteMoimSchedule:
            return .delete
        }
	}
	
	public var task: APITask {
		switch self {
		case .createMoim(let groupName, let image):
			return .uploadImagesWithBody(imageDatas: [image], body: ["groupName": groupName], imageKeyName: "img")
		case .getMoimList:
			return .requestPlain
		case .changeMoimName(let data):
			return .requestJSONEncodable(parameters: data)
		case .participateMoim:
			return .requestPlain
		case .withdrawMoim:
			return .requestPlain
		case .getMoimSchedule:
			return .requestPlain
        case .postMoimSchedule(data: let data):
            return .requestJSONEncodable(parameters: data)
        case .patchMoimSchedule(data: let data):
            return .requestJSONEncodable(parameters: data)
        case .patchMoimScheduleCategory(data: let data):
            return .requestJSONEncodable(parameters: data)
        case .deleteMoimSchedule:
            return .requestPlain
		}
	}
	
	public var headers: HTTPHeaders? {
		switch self {
		case .createMoim:
			return ["Content-Type": "multipart/form-data"]
		default:
			return ["Content-Type": "application/json"]
		}
	}
	
	
}
