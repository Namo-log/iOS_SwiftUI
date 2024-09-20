//
//  Token.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/19/24.
//

import Core

/// AccessToken 명시를 위한 alias 입니다. - 내부 토큰 분해 x
public typealias AccessToken = String
/// RefreshToken 명시를 위한 alias 입니다. - 내부 토큰 분해 x
public typealias RefreshToken = String
/// AccessToken, RefreshToken 튜플 명시를 위한 alias 입니다.
public typealias Tokens = (accessToken: AccessToken, refreshToken: RefreshToken)
/// AppleLoginInfo 튜플 명시를 위한 alias 입니다.
public typealias AppleLoginInfo = AppleSignInRequestDTO
