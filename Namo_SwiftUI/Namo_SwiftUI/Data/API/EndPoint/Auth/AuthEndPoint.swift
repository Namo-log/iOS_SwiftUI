//
//  AuthEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import Foundation
import Alamofire

enum AuthEndPoint {
    
    // 소셜 로그인 토큰을 이용해 나모 서버에게 토큰을 요청
    case fetchTokenKakao(socialAccessToken: SocialAccessToken)
    
    // 로그아웃
    case logout(serverAccessToken: ServerAccessToken)
}

extension AuthEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)/auth"
    }
    
    var path: String {
        
        switch self {
        case .fetchTokenKakao(socialAccessToken: _):
            return "/kakao/signup"
        case .logout(serverAccessToken: _):
            return "/logout"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchTokenKakao, .logout:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
            
        case .fetchTokenKakao(socialAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .logout(serverAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        }
    }
}

