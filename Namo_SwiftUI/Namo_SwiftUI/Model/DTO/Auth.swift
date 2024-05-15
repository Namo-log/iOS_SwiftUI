//
//  Auth.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation

struct ServerTokenResponse: Codable {
    let accessToken: String
    let refreshToken: String
    let newUser: Bool
}

struct SocialAccessToken: Encodable {
    
    let accessToken: String
}

struct ServerAccessToken: Encodable {
    
    let accessToken: String
}

struct AppleAccessToken: Codable {
    
    let identityToken: String
    let username: String
    let email: String
}

struct TermRequest: Codable {
    
    let isCheckTermOfUse: Bool
    let isCheckPersonalInformationCollection: Bool
}

enum SocialLogin {
    case kakao
    case naver
    case apple
}

// 카카오 및 네이버 탈퇴 요청 DTO
struct WithDrawKakakoNaverRequestDTO: Encodable {
    
    let accessToken: String
}

// 애플 탈퇴 요청 DTO
struct WithDrawAppleRequestDTO: Encodable {
    
    let authorizationCode: String
}
