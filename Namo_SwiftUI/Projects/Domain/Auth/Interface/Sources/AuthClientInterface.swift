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
    
    /// 로그인 상태 관리를 위한 매니저입니다
    private let authManager: AuthManagerProtocol
    
    // MARK: SNS Login Helper API
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
    public func kakaoLogout() async {
        return await loginHelper.kakaoLogout()
    }
    
    /// 네이버 로그아웃을 진행합니다.
    public func naverLogout() async {
        return await loginHelper.naverLogout()
    }
    
    // MARK: Auth Manager API
    /// 현재 로그인 상태를 가져옵니다
    public func getLoginState() -> OAuthType? {
        return authManager.getLoginState()
    }
    
    /// 카카오/네이버/애플 중 소셜 로그인 된 상태와 토큰을 저장합니다
    public func setLoginState(_ oAuthType: OAuthType, with tokens: Tokens) {
        return authManager.setLoginState(oAuthType, with: tokens)
    }
    
    /// 로그인 된 소셜 로그인 타입에 맞춰 로그아웃합니다
    public func setLogoutState(with oAuthType: OAuthType) async {
        return await authManager.setLogoutState(with: oAuthType)
    }
    
    // MARK: API
    /// 나모 API : 애플 소셜 로그인을 통한 회원가입
    public var reqSignInWithApple: @Sendable (AppleSignInRequestDTO) async -> SignInResponseDTO?
    /// 나모 API : 네이버 소셜 로그인을 통한 회원가입
    public var reqSignInWithNaver: @Sendable (SocialSignInRequestDTO) async -> SignInResponseDTO?
    /// 나모 API : 카카오 소셜 로그인을 통한 회원가입
    public var reqSignInWithKakao: @Sendable (SocialSignInRequestDTO) async -> SignInResponseDTO?
    /// 나모 API : 로그아웃
    public var reqSignOut: @Sendable (LogoutRequestDTO) async throws -> Void
    /// 나모 API : 회원탈퇴 - Apple
    public var reqWithdrawalApple: @Sendable (LogoutRequestDTO) async throws -> Void
    /// 나모 API : 회원탈퇴 - Naver
    public var reqWithdrawalNaver: @Sendable (LogoutRequestDTO) async throws -> Void
    /// 나모 API : 회원탈퇴 - Kakao
    public var reqWithdrawalKakao: @Sendable (LogoutRequestDTO) async throws -> Void
    
    // MARK: init
    public init(
        loginHelper: SNSLoginHelperProtocol,
        authManager: AuthManagerProtocol,
        reqSignInWithApple: @Sendable @escaping (AppleSignInRequestDTO) async -> SignInResponseDTO?,
        reqSignInWithNaver: @Sendable @escaping (SocialSignInRequestDTO) async -> SignInResponseDTO?,
        reqSignInWithKakao: @Sendable @escaping (SocialSignInRequestDTO) async -> SignInResponseDTO?,
        reqSignOut: @Sendable @escaping (LogoutRequestDTO) async throws -> Void,
        reqWithdrawalApple: @Sendable @escaping (LogoutRequestDTO) async throws -> Void,
        reqWithdrawalNaver: @Sendable @escaping (LogoutRequestDTO) async throws -> Void,
        reqWithdrawalKakao: @Sendable @escaping (LogoutRequestDTO) async throws -> Void
    ) {
        self.loginHelper = loginHelper
        self.authManager = authManager
        self.reqSignInWithApple = reqSignInWithApple
        self.reqSignInWithNaver = reqSignInWithNaver
        self.reqSignInWithKakao = reqSignInWithKakao
        self.reqSignOut = reqSignOut
        self.reqWithdrawalApple = reqWithdrawalApple
        self.reqWithdrawalNaver = reqWithdrawalNaver
        self.reqWithdrawalKakao = reqWithdrawalKakao
    }
}

extension AuthClient: TestDependencyKey {
    public static var previewValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        authManager: unimplemented("\(Self.self).authManager"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver"),
        reqSignInWithKakao: unimplemented("\(Self.self).reqSignInWithKakao"),
        reqSignOut: unimplemented("\(Self.self).reqSignOut"),
        reqWithdrawalApple: unimplemented("\(Self.self).reqWithdrawalApple"),
        reqWithdrawalNaver: unimplemented("\(Self.self).reqWithdrawalNaver"),
        reqWithdrawalKakao: unimplemented("\(Self.self).reqWithdrawalKakao")
    )
    
    public static let testValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        authManager: unimplemented("\(Self.self).authManager"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver"),
        reqSignInWithKakao: unimplemented("\(Self.self).reqSignInWithKakao"),
        reqSignOut: unimplemented("\(Self.self).reqSignOut"),
        reqWithdrawalApple: unimplemented("\(Self.self).reqWithdrawalApple"),
        reqWithdrawalNaver: unimplemented("\(Self.self).reqWithdrawalNaver"),
        reqWithdrawalKakao: unimplemented("\(Self.self).reqWithdrawalKakao")
    )
}
