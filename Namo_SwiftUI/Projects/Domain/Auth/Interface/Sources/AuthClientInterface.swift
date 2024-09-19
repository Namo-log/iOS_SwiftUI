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
    public let loginHelper = SNSLoginHelper()
    /// 애플 로그인을 진행합니다. - Apple 로그인 토큰 인증을 위한 정보를 받습니다.
    public lazy var appleLogin: (@escaping (AppleLoginInfo?) -> Void) -> Void = loginHelper.appleLogin
    
    // MARK: API
    /// 나모 API : 애플 소셜 로그인을 통한 회원가입
    public var reqSignInWithApple: @Sendable (AppleSignInRequestDTO) async throws -> Tokens?
    // signInWithKakao
    // signInWithNaver
    // saveToken
    // loadToken
    public init(
        reqSignInWithApple: @Sendable @escaping (AppleSignInRequestDTO) async throws -> Tokens?
    ) {
        self.reqSignInWithApple = reqSignInWithApple
    }
}

//extension AuthClient: TestDependencyKey {
//    public static var previewValue = Self(
//        appleLogin: unimplemented("\(Self.self).appleLogin"),
//        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple")
//    )
//    
//    public static let testValue = Self(
//        appleLogin: unimplemented("\(Self.self).appleLogin"),
//        reqSignInWithApple: unimplemented("\(Self.self).reqSignInWithApple")
//    )
//}
