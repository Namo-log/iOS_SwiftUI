//
//  CategoryEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Alamofire

enum CategoryEndPoint {
	case postCategory(data: postCategoryRequest)
	case patchCategory(id: Int, data: postCategoryRequest)
	case getAllCategory
	case deleteCategory(id: Int)
}

extension CategoryEndPoint: EndPoint {
	
	var baseURL: String {
		return "\(SecretConstants.baseURL)/categories"
	}
	
	var path: String {
		switch self {
		case .postCategory:
			return ""
		case .patchCategory(let id, _):
			return "/\(id)"
		case .getAllCategory:
			return ""
		case .deleteCategory(let id):
			return "/\(id)"
		}
	}
	
	var method: Alamofire.HTTPMethod {
		switch self {
		case .postCategory:
			return .post
		case .patchCategory:
			return .patch
		case .getAllCategory:
			return .get
		case .deleteCategory:
			return .delete
		}
	}
	
	var task: APITask {
		switch self {
		case .postCategory(let data):
			return .requestJSONEncodable(parameters: data)
		case .patchCategory(_, let data):
			return .requestJSONEncodable(parameters: data)
		case .getAllCategory:
			return .requestPlain
		case .deleteCategory:
			return .requestPlain
		}
	}
	
	
}
