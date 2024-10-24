//
//  DiaryEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Alamofire
import Foundation

import SharedUtil

public enum DiaryEndPoint {
    case createDiary(scheduleId: Int, content: String, images: [Data?])
    case getMonthDiary(request: GetDiaryRequestDTO)
    case getOneDiary(scheduleId: Int)
	case changeDiary(scheduleId: Int, content: String, images: [Data?], deleteImageIds: [Int])
    case deleteDiary(diaryId: Int)
}

extension DiaryEndPoint: EndPoint {
    public var baseURL: String {
        return "\(SecretConstants.baseURL)/diaries"
    }
    
    public var path: String {
        switch self {
        case .createDiary(_, _, _):
            return ""
        case .getMonthDiary(let req):
            return "/month/\(req.year),\(req.month)"
        case .getOneDiary(let scheduleId):
            return "/\(scheduleId)"
        case .changeDiary:
            return ""
        case .deleteDiary(let diaryId):
            return "/\(diaryId)"
        }
    }
    
    public var method: Alamofire.HTTPMethod {
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
    
    public var task: APITask {
        switch self {
		case .createDiary(let scheduleId, let content, let images):
			let body = ["scheduleId": scheduleId, "content": content] as [String : Any]
			return .uploadImagesWithBody(imageDatas: images, body: body)
		case .changeDiary(let scheduleId, let content, let images, let deleteImageIds):
			let params = ["scheduleId": scheduleId, "content": content, "deleteImageIds": deleteImageIds] as [String : Any]
			return .uploadImagesWithParameter(imageDatas: images, parameters: params, imageKeyName: "createImages")
        case .getMonthDiary(let req):
            let params = ["page": req.page, "size": req.size]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .deleteDiary, .getOneDiary:
            return .requestPlain
        }
    }
    
    public var headers: HTTPHeaders? {
        switch self {
        case .createDiary, .changeDiary:
            return ["Content-Type": "multipart/form-data"]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
