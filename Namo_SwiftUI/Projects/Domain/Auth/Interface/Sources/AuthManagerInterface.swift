//
//  AuthManagerInterface.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 10/5/24.
//

/// AuthManager의 인터페이스 프로토콜입니다.
public protocol AuthManagerProtocol {
    func userStatusCheck() -> UserStatus
    func getLoginState() -> OAuthType?
    func setLoginState(_ oAuthType: OAuthType, with tokens: Tokens, userId: Int)
    func setLogoutState(with oAuthType: OAuthType) async
    func withdraw(with oAuthType: OAuthType) async
    func getAgreementCompletedState() -> Bool?
    func setAgreementCompletedState(_ isCompleted: Bool)
    func deleteAgreementCompletedState()
    func getUserInfoCompletedState() -> Bool?
    func setUserInfoCompletedState(_ isCompleted: Bool)
    func deleteUserInfoCompletedState()
}
