//
//  MoimEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/17/24.
//

import Alamofire
import Foundation

enum MoimEndPoint {
	case createMoim(groupName: String, image: Data?)
	case getMoimList
	case changeMoimName(data: changeMoimNameRequest)
	case participateMoim(groupCode: String)
	case withdrawMoim(moimId: Int)
}

extension MoimEndPoint: EndPoint {
	var baseURL: String {
		return "\(SecretConstants.baseURL)/moims"
	}
	
	var path: String {
		switch self {
		case .createMoim:
			return ""
		case .getMoimList:
			return ""
		case .changeMoimName:
			return "/name"
		case .participateMoim(let groupCode):
			return "/participate/\(groupCode)"
		case .withdrawMoim(let moimId):
			return "/withdraw/\(moimId)"
		}
	}
	
	var method: Alamofire.HTTPMethod {
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
		}
	}
	
	var task: APITask {
		switch self {
		case .createMoim(let groupName, let image):
			return .uploadImagesWithBody(imageDatas: [image], body: ["groupName": groupName])
		case .getMoimList:
			return .requestPlain
		case .changeMoimName(let data):
			return .requestJSONEncodable(parameters: data)
		case .participateMoim:
			return .requestPlain
		case .withdrawMoim:
			return .requestPlain
		}
	}
	
	var headers: HTTPHeaders? {
		switch self {
		case .createMoim:
			return ["Content-Type": "multipart/form-data"]
		default:
			return ["Content-Type": "application/json"]
		}
	}
	
	
}
