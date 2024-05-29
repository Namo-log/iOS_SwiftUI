//
//  AuthEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import Foundation
import Alamofire

enum AuthEndPoint {

    // 카카오 로그인
    case signInKakao(kakaoToken: SocialSignInRequestDTO)
    
    // 네이버 로그인
    case signInNaver(naverToken: SocialSignInRequestDTO)

    // 애플 로그인
    case signInApple(appleToken: AppleSignInRequestDTO)
    
    // 카카오 회원 탈퇴
    case withdrawMemberKakao(kakaoAccessToken: WithDrawKakakoNaverRequestDTO)
    
    // 네이버 회원 탈퇴
    case withdrawMemberNaver(naverAccessToken: WithDrawKakakoNaverRequestDTO)
    
    // 애플 회원 탈퇴
    case withdrawMemberApple(appleAuthorizationCode: WithDrawAppleRequestDTO)
    
    // 로그아웃
    case logout(serverAccessToken: LogoutRequestDTO)
}

extension AuthEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)/auths"
    }
    
    var path: String {
        
        switch self {
            
        case .signInKakao:
            return "/kakao/signup"
            
        case .signInNaver:
            return "/naver/signup"
            
        case .signInApple:
            return "/apple/signup"
            
        case .withdrawMemberKakao(kakaoAccessToken: _):
            return "/kakao/delete"
            
        case .withdrawMemberNaver(naverAccessToken: _):
            return "/naver/delete"
            
        case .withdrawMemberApple(appleAuthorizationCode: _):
            return "/apple/delete"
            
        case .logout(serverAccessToken: _):
            return "/logout"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signInKakao, .signInNaver, .signInApple, .withdrawMemberKakao, .withdrawMemberNaver, .withdrawMemberApple, .logout:
            return .post
        }
    }
    
    var task: APITask {
        switch self {
            
        case .signInKakao(kakaoToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .signInNaver(naverToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .signInApple(appleToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .withdrawMemberKakao(kakaoAccessToken: let dto):
            return .requestJSONEncodable(parameters: dto)
        case .withdrawMemberNaver(naverAccessToken: let dto):
            return .requestJSONEncodable(parameters: dto)
        case .withdrawMemberApple(appleAuthorizationCode: let dto):
            return .requestJSONEncodable(parameters: dto)
        case .logout(serverAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        }
    }
}

