//
//  AuthRepository.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

protocol AuthRepository {
    
    // 카카오, 네이버 소셜 로그인. 나모 서버로부터 토큰을 발급받는 메소드
    func getServerToken(socialAccessToken: SocialAccessToken, social: SocialType) async -> ServerTokenResponse?
    
    // 애플 소셜 로그인. 나모 서버로부터 토큰을 발급받는 메소드
    func getServerTokenApple(appleAccessToken: AppleAccessToken) async -> ServerTokenResponse?
    
    // 로그아웃. 토큰 삭제
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>?
    
    // 카카오 회원 탈퇴
    func withdrawMemberKakako<T:Decodable>(kakaoAccessToken: String) async -> BaseResponse<T>?
    
    // 네이버 회원 탈퇴
    func withdrawMemberNaver<T:Decodable>(naverAccessToken: String) async -> BaseResponse<T>?
    
    // 애플 회원 탈퇴
    func withdrawMemberApple<T:Decodable>(appleAuthorizationCode: String) async -> BaseResponse<T>?
    
}
