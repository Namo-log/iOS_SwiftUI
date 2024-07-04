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
    case withdrawMemberKakao
    
    // 네이버 회원 탈퇴
    case withdrawMemberNaver
    
    // 애플 회원 탈퇴
    case withdrawMemberApple
    
    // 로그아웃
    case logout(serverAccessToken: LogoutRequestDTO)
    
    // 토큰 재발급
    case reissuanceToken(token: TokenReissuanceRequestDTO)
    
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
            
        case .withdrawMemberKakao:
            return "/kakao/delete"
            
        case .withdrawMemberNaver:
            return "/naver/delete"
            
        case .withdrawMemberApple:
            return "/apple/delete"
            
        case .logout(serverAccessToken: _):
            return "/logout"
            
        case .reissuanceToken:
            return "/reissuance"
        }
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .signInKakao, .signInNaver, .signInApple, .withdrawMemberKakao, .withdrawMemberNaver, .withdrawMemberApple, .logout, .reissuanceToken:
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
        case .withdrawMemberKakao:
            return .requestPlain
        case .withdrawMemberNaver:
            return .requestPlain
        case .withdrawMemberApple:
            return .requestPlain
        case .logout(serverAccessToken: let dto):
            return .authRequestJSONEncodable(parameters: dto)
        case .reissuanceToken(token: let dto):
            return .requestJSONEncodable(parameters: dto)
        }
    }
    
    var headers: HTTPHeaders? {
        
        switch self {
            
        case .withdrawMemberApple, .withdrawMemberKakao, .withdrawMemberNaver:
            return nil
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

