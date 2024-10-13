//
//  UserStatus.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 10/9/24.
//

/// 유저의 현재 상태를 분류합니다
public enum UserStatus {
    /// 로그인 X
    case logout
    /// 로그인 + 추가 정보 미입력
    case loginWithoutEverything
    /// 로그인, 약관동의 정보 필요
    case loginWithoutAgreement
    /// 로그인, 유저 정보 필요
    case loginWithoutUserInfo
    /// 로그인 + 모든 정보 입력
    case loginWithAll
}
