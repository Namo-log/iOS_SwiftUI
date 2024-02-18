//
//  APIAuthRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

// 예시로 넣어둔 AuthRepository 구현체이며 실제 구현에 쓰일 예정입니다.
class APIAuthRepositoryImpl: AuthRepository {
    
    // 서버로부터 토큰을 발급받는 메소드
    func getTokenKakao(socialAccessToken: SocialAccessToken) async -> Auth? {
        return await APIManager.shared.performRequest(
            endPoint: AuthEndPoint.fetchTokenKakao(socialAccessToken: socialAccessToken))
    }
    
    // 로그아웃 메소드
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.logout(serverAccessToken: serverAccessToken))
    }
}
