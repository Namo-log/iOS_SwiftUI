//
//  AuthEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import Foundation
import Alamofire

import SharedUtil

public enum AuthEndPoint {

    // 카카오 로그인
	case signInKakao(kakaoToken: SocialSignInRequestDTO)
    
    // 네이버 로그인
    case signInNaver(naverToken: SocialSignInRequestDTO)

    // 애플 로그인
    case signInApple(appleToken: AppleSignInRequestDTO)
    
    // 카카오 회원 탈퇴
    case withdrawMemberKakao(refreshToken: LogoutRequestDTO)
    
    // 네이버 회원 탈퇴
    case withdrawMemberNaver(refreshToken: LogoutRequestDTO)
    
    // 애플 회원 탈퇴
    case withdrawMemberApple(refreshToken: LogoutRequestDTO)
    
    // 로그아웃
    case logout(refreshToken: LogoutRequestDTO)
    
    // 토큰 재발급
    case reissuanceToken(token: TokenReissuanceRequestDTO)
    
    // 회원 가입 완료
    case signUpComplete(signUpInfo: SignUpCompleteRequestDTO)
}

extension AuthEndPoint: EndPoint {
    
	public var baseURL: String {
        return "\(SecretConstants.baseURL)/auths"
    }
    
	public var path: String {
        
        switch self {
            
        case .signInKakao:
            return "/signup/KAKAO"
            
        case .signInNaver:
            return "/signup/NAVER"
            
        case .signInApple:
            return "/signup/apple"
            
        case .withdrawMemberKakao:
            return "/delete/kakao"
            
        case .withdrawMemberNaver:
            return "/delete/naver"
            
        case .withdrawMemberApple:
            return "/delete/apple"
            
        case .logout:
            return "/logout"
            
        case .reissuanceToken:
            return "/reissuance"
            
        case .signUpComplete:
            return "/signup/complete"
        }
    }
    
	public var method: Alamofire.HTTPMethod {
        switch self {
        case .signInKakao, .signInNaver, .signInApple, .withdrawMemberKakao, .withdrawMemberNaver, .withdrawMemberApple, .logout, .reissuanceToken, .signUpComplete:
            return .post
        }
    }
    
	public var task: APITask {
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
        case .logout:
            return .requestPlain
        case .reissuanceToken:
            return .authRequestPlain
        case .signUpComplete(signUpInfo: let dto):
            return .requestJSONEncodable(parameters: dto)
        }
    }
    
	public var headers: HTTPHeaders? {
        
        switch self {
            
		case let .withdrawMemberApple(dto), let .withdrawMemberKakao(dto), let .withdrawMemberNaver(dto), let .logout(dto):
			return ["refreshToken": dto.refreshToken]
			
		case .reissuanceToken(let dto):
			return ["refreshToken": dto.refreshToken]
            
        case .signUpComplete:
            do {
                let accessToken = try KeyChainManager.readItem(key: "accessToken")
                let refreshToken = try KeyChainManager.readItem(key: "refreshToken")
                return [
                    "Authorization": "Bearer \(accessToken)",
                    "refreshToken": refreshToken
                ]
            } catch {
                return ["Content-Type": "application/json"]
            }
            
        default:
            return ["Content-Type": "application/json"]
        }
    }
}

