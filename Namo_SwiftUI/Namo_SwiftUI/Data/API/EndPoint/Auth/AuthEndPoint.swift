//
//  AuthEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import Foundation
import Alamofire

enum AuthEndPoint {
    
    // 소셜 로그인 토큰을 이용해 나모 서버에게 토큰을 요청(카카오, 네이버)
    case fetchToken(socialAccessToken: SocialAccessToken, social: SocialType)
    
    // 애플 소셜 로그인
    case fetchTokenApple(appleAccessToken: AppleAccessToken)
    
    // 로그아웃
    case logout(serverAccessToken: ServerAccessToken)
}

enum SocialType {
    
    case kakao
    case naver
}

extension AuthEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)/auth"
    }
    
    var path: String {
        
        switch self {
        case .fetchToken(socialAccessToken: _, social: let social):
            
            switch social {
            case SocialType.kakao:
                return "/kakao/signup"
            case SocialType.naver:
                return "/naver/signup"
            }
            
        case .fetchTokenApple(appleAccessToken: _):
            return "/apple/signup"
            
        case .logout(serverAccessToken: _):
            return "/logout"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchToken, .fetchTokenApple, .logout:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
            
        case .fetchToken(socialAccessToken: let dto, social: _):
            return .authRequestJSONEncodable(parameters: dto)
        case .fetchTokenApple(appleAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .logout(serverAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        }
    }
}

