//
//  APIAuthRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

class APIAuthRepositoryImpl: AuthRepository {
    
    // 카카오 소셜 로그인. 오버로드
    func signIn(kakaoToken: SocialSignInRequestDTO) async -> SignInResponseDTO? {
        
        print("[Repository] kakako SignIn Called")
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: kakaoToken))
    }
    
    // 네이버 소셜 로그인. 오버로드
    func signIn(naverToken: SocialSignInRequestDTO) async -> SignInResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: naverToken))
    }
    
    // 애플 소셜 로그인. 오버로드
    func signIn(appleToken: AppleSignInRequestDTO) async -> SignInResponseDTO? {
        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: appleToken))
    }
    
    // 카카오 회원 탈퇴
    func withdrawMemberKakao<T:Decodable>() async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.withdrawMemberKakao)
    }
    
    // 네이버 회원 탈퇴
    func withdrawMemberNaver<T:Decodable>() async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.withdrawMemberNaver)
    }
    
    // 애플 회원 탈퇴
    func withdrawMemberApple<T:Decodable>() async -> BaseResponse<T>? {
        
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.withdrawMemberApple)
    }
    
    // 로그아웃 메소드
    func removeToken<T:Decodable>(serverAccessToken: LogoutRequestDTO) async -> BaseResponse<T>? {
        return await APIManager.shared.performRequestBaseResponse(endPoint: AuthEndPoint.logout(serverAccessToken: serverAccessToken))
    }
}
