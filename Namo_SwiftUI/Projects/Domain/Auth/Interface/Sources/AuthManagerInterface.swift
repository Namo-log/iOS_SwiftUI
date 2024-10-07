//
//  AuthManagerInterface.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 10/5/24.
//

/// AuthManager의 인터페이스 프로토콜입니다.
public protocol AuthManagerProtocol {
    func getLoginState() -> OAuthType?
    func setLoginState(_ oAuthType: OAuthType, with tokens: Tokens)
    func setLogoutState(with oAuthType: OAuthType) async
    func setUserId(userId: Int)
    func getUserId() -> Int
}
