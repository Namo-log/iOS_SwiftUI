//
//  PlaceEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

import Alamofire

enum PlaceEndPoint {
    case getKakaoMapAPIRequest(query: String, x: Double?=nil, y: Double?=nil, radius: Int?=nil, page: Int?=nil, size: Int?=nil)
}

extension PlaceEndPoint: EndPoint {
    
    var baseURL: String {
        return "https://dapi.kakao.com/v2/local/search/keyword.json"
    }
    
    var path: String {
        switch self {
        case .getKakaoMapAPIRequest:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .getKakaoMapAPIRequest:
            return .get
        }
    }
    
    var headers: HTTPHeaders? {
        switch self {
        case .getKakaoMapAPIRequest:
            return [ "Authorization" : "KakaoAK \(SecretConstants.kakaoMapRESTAPIKey)"]
        }
    }
    
    var task: APITask {
        switch self {
        case let .getKakaoMapAPIRequest(query, x, y, radius, page, size):
            var params: Parameters = [ "query" : query ]
            
            if let x = x { params["x"] = String(x) }
            if let y = y { params["y"] = String(y) }
            if let radius = radius { params["radius"] = radius }
            if let page = page { params["page"] = page }
            if let size = size { params["size"] = size }
            
            return .requestParametersExAPI(
                parameters: params,
                encoding: URLEncoding.default
            )
        }
    }
}
