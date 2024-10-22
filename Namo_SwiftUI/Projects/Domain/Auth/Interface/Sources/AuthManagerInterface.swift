//
//  AuthManagerInterface.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 10/5/24.
//

import Core

/// AuthManager의 인터페이스 프로토콜입니다.
public protocol AuthManagerProtocol {
    func userStatusCheck() -> UserStatus
    func deleteUserInfo()
    func getLoginState() -> OAuthType?
    func setLoginState(_ oAuthType: OAuthType, with result: SignInResponseDTO)
    func setLogoutState() async
    func withdraw() async
    func getAgreementCompletedState() -> Bool?
    func setAgreementCompletedState(_ isCompleted: Bool)
    func deleteAgreementCompletedState()
    func getUserInfoCompletedState() -> Bool?
    func setUserInfoCompletedState(_ isCompleted: Bool)
    func deleteUserInfoCompletedState()
    func getSocialLoginType() -> OAuthType?
    func setSocialLoginType(_ oAuthType: OAuthType)
    func deleteSocialLoginType()
}
