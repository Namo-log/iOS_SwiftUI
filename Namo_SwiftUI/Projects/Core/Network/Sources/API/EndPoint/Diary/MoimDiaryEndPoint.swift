//
//  MoimDiaryEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Alamofire
import Foundation

import SharedUtil

public enum MoimDiaryEndPoint {
    case createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO)
	case changeMoimDiaryPlace(activityId: Int, req: EditMoimDiaryPlaceReqDTO, deleteImageIds: [Int])
    case deleteMoimDiaryPlace(activityId: Int)
    case editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO)
    case deleteMoimDiary(moimScheduleId: Int)
    case getMonthMoimDiary(request: GetMonthMoimDiaryReqDTO)
    case getOneMoimDiary(moimScheduleId: Int)
    case getOneMoimDiaryDetail(moimScheduleId: Int)
    case deleteMoimDiaryOnPersonal(scheduleId: Int)
}

extension MoimDiaryEndPoint: EndPoint {
    public var baseURL: String {
        return "\(SecretConstants.baseURL)/group/diaries"
    }
    
    public var path: String {
        switch self {
        case .createMoimDiaryPlace(let moimScheduleId, _):
            return "/\(moimScheduleId)"
        case .changeMoimDiaryPlace(let activityId, _, _),
                .deleteMoimDiaryPlace(let activityId):
            return "/\(activityId)"
        case .getMonthMoimDiary(let req):
            return "/month/\(req.year),\(req.month)"
        case .getOneMoimDiary(let moimScheduleId):
            return "/\(moimScheduleId)"
        case .editMoimDiary(let scheduleId, _):
            return "/text/\(scheduleId)"
        case .deleteMoimDiary(let moimScheduleId):
            return "/all/\(moimScheduleId)"
        case .getOneMoimDiaryDetail(let moimScheduleId):
            return "/detail/\(moimScheduleId)"
        case .deleteMoimDiaryOnPersonal(scheduleId: let scheduleId):
            return "/person/\(scheduleId)"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .getMonthMoimDiary, .getOneMoimDiary, .getOneMoimDiaryDetail:
            return .get
        case .createMoimDiaryPlace:
            return .post
        case .changeMoimDiaryPlace, .editMoimDiary:
            return .patch
        case .deleteMoimDiaryPlace, .deleteMoimDiary, .deleteMoimDiaryOnPersonal:
            return .delete
        }
    }
    
    public var task: APITask {
        switch self {
        case .createMoimDiaryPlace(let moimScheduleId, let req):
			
            let params = [
				"moimScheduleId": moimScheduleId,
				"activityName": req.name,
				"activityMoney": req.money,
				"participantUserIds": req.participants
			] as [String : Any]
			return .uploadImagesWithParameter(imageDatas: req.imgs, parameters: params, imageKeyName: "createImages")
        case .changeMoimDiaryPlace(let activityId, let req, let deleteImageIds):
            let params = [
				"activityId": activityId,
				"deleteImageIds": deleteImageIds,
				"activityName": req.name,
				"activityMoney": req.money,
				"participantUserIds": req.participants
			] as [String : Any]
			return .uploadImagesWithParameter(imageDatas: req.imgs, parameters: params, imageKeyName: "createImages")
        case .editMoimDiary(_, let req):
            return .requestJSONEncodable(parameters: req)
        case .deleteMoimDiaryPlace, .deleteMoimDiary, .getOneMoimDiary, .getOneMoimDiaryDetail, .deleteMoimDiaryOnPersonal:
            return .requestPlain
        case .getMonthMoimDiary(let req):
            let params = ["page": req.page, "size": req.size]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .createMoimDiaryPlace, .changeMoimDiaryPlace:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
