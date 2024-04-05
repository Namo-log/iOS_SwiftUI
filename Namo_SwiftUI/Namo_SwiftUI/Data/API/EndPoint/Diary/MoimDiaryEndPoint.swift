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
    case changeMoimDiaryPlace(moimLocationId: Int, req: EditMoimDiaryPlaceReqDTO)
    case deleteMoimDiaryPlace(moimLocationId: Int)
    case getMonthMoimDiary(request: GetMonthMoimDiaryReqDTO)
}

extension MoimDiaryEndPoint: EndPoint {
    var baseURL: String {
        return "\(SecretConstants.baseURL)/moims/schedule/memo"
    }
    
    var path: String {
        switch self {
        case .createMoimDiaryPlace(let moimScheduleId, _):
            return "/\(moimScheduleId)"
        case .changeMoimDiaryPlace(let moimLocationId, _),
                .deleteMoimDiaryPlace(let moimLocationId):
            return "/\(moimLocationId)"
        case .getMonthMoimDiary(let req):
            return "/\(req.year),\(req.month)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .createMoimDiaryPlace:
            return .post
        case .changeMoimDiaryPlace:
            return .patch
        case .deleteMoimDiaryPlace:
            return .delete
        case .getMonthMoimDiary:
            return .get
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
        case .deleteMoimDiaryPlace:
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
