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

enum SocialLogin {
    case kakao
    case naver
    case apple
}
