//
//  MoimDiaryEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Alamofire
import Foundation

enum MoimDiaryEndPoint {
    case createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO)
    case changeMoimDiaryPlace(activityId: Int, req: EditMoimDiaryPlaceReqDTO)
    case deleteMoimDiaryPlace(activityId: Int)
    case editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO)
    case deleteMoimDiary(moimScheduleId: Int)
    case getMonthMoimDiary(request: GetMonthMoimDiaryReqDTO)
    case getOneMoimDiary(moimScheduleId: Int)
    case getOneMoimDiaryDetail(moimScheduleId: Int)
}

extension MoimDiaryEndPoint: EndPoint {
    var baseURL: String {
        return "\(SecretConstants.baseURL)/group/diaries"
    }
    
    var path: String {
        switch self {
        case .createMoimDiaryPlace(let moimScheduleId, _):
            return "/\(moimScheduleId)"
        case .changeMoimDiaryPlace(let activityId, _),
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
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getMonthMoimDiary, .getOneMoimDiary, .getOneMoimDiaryDetail:
            return .get
        case .createMoimDiaryPlace:
            return .post
        case .changeMoimDiaryPlace, .editMoimDiary:
            return .patch
        case .deleteMoimDiaryPlace, .deleteMoimDiary:
            return .delete
        }
    }
    
    var task: APITask {
        switch self {
        case .createMoimDiaryPlace(_, let req):
            let body = ["name": req.name, "money": req.money, "participants": req.participants] as [String : Any]
            return .uploadImagesWithBody(imageDatas: req.imgs, body: body)
        case .changeMoimDiaryPlace(_, let req):
            let body = ["name": req.name, "money": req.money, "participants": req.participants] as [String : Any]
            return .uploadImagesWithBody(imageDatas: req.imgs, body: body)
        case .editMoimDiary(_, let req):
            return .requestJSONEncodable(parameters: req)
        case .deleteMoimDiaryPlace, .deleteMoimDiary, .getOneMoimDiary, .getOneMoimDiaryDetail:
            return .requestPlain
        case .getMonthMoimDiary(let req):
            let params = ["page": req.page, "size": req.size]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .createMoimDiaryPlace, .changeMoimDiaryPlace:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
