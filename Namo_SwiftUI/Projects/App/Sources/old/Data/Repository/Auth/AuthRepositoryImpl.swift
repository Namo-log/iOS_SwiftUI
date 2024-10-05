////
////  AuthRepositoryImpl.swift
////  Namo_SwiftUI
////
////  Created by KoSungmin on 7/3/24.
////
//
//import Foundation
//
//import CoreNetwork
//
//final class AuthRepositoryImpl: AuthRepository {
//    
//    // 카카오 소셜 로그인
//    func signIn<T>(kakaoToken: SocialSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//		return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: kakaoToken))
//    }
//    
//    // 네이버 소셜 로그인
//    func signIn<T>(naverToken: SocialSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: naverToken))
//    }
//    
//    // 애플 소셜 로그인
//    func signIn<T>(appleToken: AppleSignInRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//        return await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: appleToken))
//    }
//    
//    // 로그아웃
//    func removeToken<T>(refreshToken: LogoutRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//		return await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(refreshToken: refreshToken))
//    }
//    
//    func withdrawMemberKakao<T>(refreshToken: LogoutRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//		return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberKakao(refreshToken: refreshToken))
//    }
//    
//    func withdrawMemberNaver<T>(refreshToken: LogoutRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//		return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberNaver(refreshToken: refreshToken))
//    }
//    
//    func withdrawMemberApple<T>(refreshToken: LogoutRequestDTO) async -> BaseResponse<T>? where T : Decodable {
//		return await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: refreshToken))
//    }
//}
