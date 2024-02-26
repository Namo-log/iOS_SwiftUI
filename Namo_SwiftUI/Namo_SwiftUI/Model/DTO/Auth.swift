//
//  Auth.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation

struct Auth: Codable {
    let accessToken: String
    let refreshToken: String
}

struct SocialAccessToken: Encodable {
    
    let accessToken: String
}

struct ServerAccessToken: Encodable {
    
    let accessToken: String
}

struct AppleAccessToken: Encodable {
    
    let identityToken: String
    let email: String
    let username: String
}
