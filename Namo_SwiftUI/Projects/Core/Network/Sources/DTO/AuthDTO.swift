//
//  Auth.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation


/// 약관동의 여부 구조체
public struct TermDTO: Decodable {
    
    let content: String
    let isCheck: Bool
}

/// 로그인 응답 DTO
public struct SignInResponseDTO: Decodable {
	public let accessToken: String
	public let refreshToken: String
	public let newUser: Bool
	public let terms: [TermDTO]
}

// 카카오, 네이버 로그인 요청 DTO
public struct SocialSignInRequestDTO: Encodable {
	public init(accessToken: String, socialRefreshToken: String) {
		self.accessToken = accessToken
		self.socialRefreshToken = socialRefreshToken
	}
    
    let accessToken: String
    let socialRefreshToken: String
}

// 로그아웃 요청 DTO
public struct LogoutRequestDTO: Encodable {
	public init(refreshToken: String) {
		self.refreshToken = refreshToken
	}
    let refreshToken: String
}

// 애플 로그인 요청 DTO
public struct AppleSignInRequestDTO: Codable {
//	public init(identityToken: String, authorizationCode: String, username: String, email: String) {
//		self.identityToken = identityToken
//		self.authorizationCode = authorizationCode
//		self.username = username
//		self.email = email
//	}
    
    public init(identityToken: String, authorizationCode: String) {
        self.identityToken = identityToken
        self.authorizationCode = authorizationCode
    }
	
    public let identityToken: String
    public let authorizationCode: String
//    let username: String
//    let email: String
}

// 토큰 재발급 요청 DTO
public struct TokenReissuanceRequestDTO: Encodable {
    
    let accessToken: String
    let refreshToken: String
}

// 토큰 재발급 응답 DTO
public struct TokenReissuanceResponseDTO: Decodable {
    
    let accessToken: String
    let refreshToken: String
}
