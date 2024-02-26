//
//  APIAuthRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

// 예시로 넣어둔 AuthRepository 구현체이며 실제 구현에 쓰일 예정입니다.
class APIAuthRepositoryImpl: AuthRepository {
    
    // 카카오, 네이버 소셜 로그인. 서버로부터 토큰을 발급받는 메소드
    func getServerToken(socialAccessToken: SocialAccessToken, social: String) async -> Auth? {
        return await APIManager.shared.performRequest(
            endPoint: AuthEndPoint.fetchToken(socialAccessToken: socialAccessToken, social: social))
    }

    // 로그아웃 메소드
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.logout(serverAccessToken: serverAccessToken))
    }
}
