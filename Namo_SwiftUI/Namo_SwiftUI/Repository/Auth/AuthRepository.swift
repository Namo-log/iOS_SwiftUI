//
//  AuthRepository.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

import Foundation

protocol AuthRepository {
    
    // 카카오, 네이버 소셜 로그인. 서버로부터 토큰을 발급받는 메소드
    func getServerToken(socialAccessToken: SocialAccessToken, social: SocialType) async -> Auth?
    
    // 로그아웃. 토큰 삭제
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>?
}
