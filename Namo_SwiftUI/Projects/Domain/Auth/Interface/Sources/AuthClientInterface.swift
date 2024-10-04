//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/18/24.
//

import Foundation
import ComposableArchitecture
import Core

/// BASE:
/// 여기에서는 비즈니스 로직을 포함한 API 호출 로직만이 존재한다.
/// Input from, Output to -> TCA Store
public struct AuthClient {
    /// 소셜 로그인 진행을 위한 헬퍼 클래스입니다
    private let loginHelper: SNSLoginHelperProtocol
    
    /// 애플 로그인을 진행합니다. - Apple 로그인 토큰 인증을 위한 정보를 받습니다.
    public func appleLogin() async -> AppleLoginInfo? {
        return await loginHelper.appleLogin()
    }
    
    /// 네이버 로그인을 진행합니다. - Naver 로그인 토큰 인증을 위한 정보를 받습니다.
    public func naverLogin() async -> NaverLoginInfo? {
        return await loginHelper.naverLogin()
    }
    
    /// 카카오 로그인을 진행합니다. - Kakao 로그인 토큰 인증을 위한 정보를 받습니다.
    public func kakaoLogin() async -> KakaoLoginInfo? {
        return await loginHelper.kakaoLogin()
    }
    
    /// 카카오 로그아웃을 진행합니다. - 실패 시 error를 throw 합니다.
    public func kakaoLogout() async throws {
        return try await loginHelper.kakaoLogout()
    }
    
    /// 네이버 로그아웃을 진행합니다.
    public func naverLogout() async {
        return await loginHelper.naverLogout()
    }
    
    // MARK: API
    /// 나모 API : 애플 소셜 로그인을 통한 회원가입
    public var reqSignInWithApple: @Sendable (AppleSignInRequestDTO) async throws -> SignInResponseDTO?
    /// 나모 API : 네이버 소셜 로그인을 통한 회원가입
    public var reqSignInWithNaver: @Sendable (SocialSignInRequestDTO) async throws -> SignInResponseDTO?
    /// 나모 API : 카카오 소셜 로그인을 통한 회원가입
    public var reqSignInWithKakao: @Sendable (SocialSignInRequestDTO) async throws -> SignInResponseDTO?
    /// 나모 API : 로그아웃
    public var reqSignOut: @Sendable (LogoutRequestDTO) async throws -> Void
    
    public init(
        loginHelper: SNSLoginHelperProtocol,
        reqSignInWithApple: @Sendable @escaping (AppleSignInRequestDTO) async throws -> SignInResponseDTO?,
        reqSignInWithNaver: @Sendable @escaping (SocialSignInRequestDTO) async throws -> SignInResponseDTO?,
        reqSignInWithKakao: @Sendable @escaping (SocialSignInRequestDTO) async throws -> SignInResponseDTO?,
        reqSignOut: @Sendable @escaping (LogoutRequestDTO) async throws -> Void
    ) {
        self.loginHelper = loginHelper
        self.reqSignInWithApple = reqSignInWithApple
        self.reqSignInWithNaver = reqSignInWithNaver
        self.reqSignInWithKakao = reqSignInWithKakao
        self.reqSignOut = reqSignOut
    }
}

extension AuthClient: TestDependencyKey {
    public static var previewValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver"),
        reqSignInWithKakao: unimplemented("\(Self.self).reqSignInWithKakao"),
        reqSignOut: unimplemented("\(Self.self).reqSignOut")
    )
    
    public static let testValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver"),
        reqSignInWithKakao: unimplemented("\(Self.self).reqSignInWithKakao"),
        reqSignOut: unimplemented("\(Self.self).reqSignOut")
    )
}
