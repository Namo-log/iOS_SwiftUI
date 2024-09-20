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
    public let loginHelper: SNSLoginHelperProtocol
    
    /// 애플 로그인을 진행합니다. - Apple 로그인 토큰 인증을 위한 정보를 받습니다.
    public func appleLogin() async -> AppleLoginInfo? {
        return await loginHelper.appleLogin()
    }
    
    /// 네이버 로그인을 진행합니다. - Naver 로그인 토큰 인증을 위한 정보를 받습니다.
    public func naverLogin() async -> NaverLoginInfo? {
        return await loginHelper.naverLogin()
    }
    
    // MARK: API
    /// 나모 API : 애플 소셜 로그인을 통한 회원가입
    public var reqSignInWithApple: @Sendable (AppleSignInRequestDTO) async throws -> Tokens?
    // signInWithKakao
    /// 나모 API : 네이버 소셜 로그인을 통한 회원가입
    public var reqSignInWithNaver: @Sendable (SocialSignInRequestDTO) async throws -> Tokens?
    // saveToken
    // loadToken
    public init(
        loginHelper: SNSLoginHelperProtocol,
        reqSignInWithApple: @Sendable @escaping (AppleSignInRequestDTO) async throws -> Tokens?,
        reqSignInWithNaver: @Sendable @escaping (SocialSignInRequestDTO) async throws -> Tokens?
    ) {
        self.loginHelper = loginHelper
        self.reqSignInWithApple = reqSignInWithApple
        self.reqSignInWithNaver = reqSignInWithNaver
    }
}

extension AuthClient: TestDependencyKey {
    public static var previewValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver")
    )
    
    public static let testValue = Self(
        loginHelper: unimplemented("\(Self.self).loginHelper"),
        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple"),
        reqSignInWithNaver: unimplemented("\(Self.self).reqSignInWithNaver")
    )
}
