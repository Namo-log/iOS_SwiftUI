//
//  AuthRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation

final class AuthRepositoryImpl: AuthRepository {
    
    // 카카오 소셜 로그인
    func signIn<T>(kakaoToken: SocialSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: kakaoToken))
    }
    
    // 네이버 소셜 로그인
    func signIn<T>(naverToken: SocialSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: naverToken))
    }
    
    // 애플 소셜 로그인
    func signIn<T>(appleToken: AppleSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: appleToken))
    }
    
    // 로그아웃
    func removeToken<T>(serverAccessToken: LogoutRequestDTO) async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(serverAccessToken: serverAccessToken))
    }
    
    func withdrawMemberKakao<T>() async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberKakao)
    }
    
    func withdrawMemberNaver<T>() async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberNaver)
    }
    
    func withdrawMemberApple<T>() async -> BaseResponse<T>? where T : Decodable {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple)
    }
}
