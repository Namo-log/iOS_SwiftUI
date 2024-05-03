//
//  DiaryEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Alamofire
import Foundation

enum DiaryEndPoint {
    case createDiary(scheduleId: Int, content: String, images: [Data?])
    case getMonthDiary(request: GetDiaryRequestDTO)
    case getOneDiary(scheduleId: Int)
    case changeDiary(scheduleId: Int, content: String, images: [Data?])
    case deleteDiary(diaryId: Int)
}

extension DiaryEndPoint: EndPoint {
    var baseURL: String {
        return "\(SecretConstants.baseURL)/schedules/diary"
    }
    
    var path: String {
        switch self {
        case .createDiary(_, _, _):
            return ""
        case .getMonthDiary(let req):
            return "/\(req.year),\(req.month)"
        case .getOneDiary(let scheduleId):
            return "/day/\(scheduleId)"
        case .changeDiary:
            return ""
        case .deleteDiary(let diaryId):
            return "/\(diaryId)"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .createDiary:
            return .post
        case .getMonthDiary, .getOneDiary:
            return .get
        case .changeDiary:
            return .patch
        case .deleteDiary:
            return .delete
        }
    }
    
    var task: APITask {
        switch self {
        case .createDiary(let scheduleId, let content, let images),
             .changeDiary(let scheduleId, let content, let images):
            let body = ["scheduleId": scheduleId, "content": content] as [String : Any]
            return .uploadImagesWithBody(imageDatas: images, body: body)
        case .getMonthDiary(let req):
            let params = ["page": req.page, "size": req.size]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .deleteDiary, .getOneDiary:
            return .requestPlain
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .createDiary, .changeDiary:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
