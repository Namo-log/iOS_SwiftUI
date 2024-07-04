//
//  Auth.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation


/// 약관동의 여부 구조체
struct TermDTO: Decodable {
    
    let content: String
    let check: Bool
}

/// 로그인 응답 DTO
struct SignInResponseDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let newUser: Bool
    let terms: [TermDTO]
}

// 카카오, 네이버 로그인 요청 DTO
struct SocialSignInRequestDTO: Encodable {
    
    let accessToken: String
    let socialRefreshToken: String
}

// 로그아웃 요청 DTO
struct LogoutRequestDTO: Encodable {
    
    let accessToken: String
}

// 애플 로그인 요청 DTO
struct AppleSignInRequestDTO: Codable {
    
    let identityToken: String
    let authorizationCode: String
    let username: String
    let email: String
}

// 토큰 재발급 요청 DTO
struct TokenReissuanceRequestDTO: Encodable {
    
    let accessToken: String
    let refreshToken: String
}

// 토큰 재발급 응답 DTO
struct TokenReissuanceResponseDTO: Decodable {
    
    let accessToken: String
    let refreshToken: String
}
