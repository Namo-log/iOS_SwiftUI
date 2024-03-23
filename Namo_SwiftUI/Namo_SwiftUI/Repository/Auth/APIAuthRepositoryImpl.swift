//
//  APIAuthRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

class APIAuthRepositoryImpl: AuthRepository {
    
    // 카카오, 네이버 소셜 로그인. 나모 서버로부터 토큰을 발급받는 메소드
    func getServerToken(socialAccessToken: SocialAccessToken, social: SocialType) async -> ServerTokenResponse? {
        return await APIManager.shared.performRequest(
            endPoint: AuthEndPoint.fetchToken(socialAccessToken: socialAccessToken, social: social))
    }
    
    // 애플 소셜 로그인. 나모 서버로부터 토큰을 발급받는 메소드
    func getServerTokenApple(appleAccessToken: AppleAccessToken) async -> ServerTokenResponse? {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.fetchTokenApple(appleAccessToken: appleAccessToken))
    }
    

    // 로그아웃 메소드
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.logout(serverAccessToken: serverAccessToken))
    }
}
