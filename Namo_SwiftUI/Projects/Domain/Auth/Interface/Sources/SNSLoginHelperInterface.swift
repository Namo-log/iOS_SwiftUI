//
//  SNSLoginHelperInterface.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/20/24.
//

/// SNSLoginHelper의 인터페이스 프로토콜입니다.
public protocol SNSLoginHelperProtocol {
    func appleLogin() async -> AppleLoginInfo?
    func naverLogin() async -> NaverLoginInfo?
    func kakaoLogin() async -> KakaoLoginInfo?
    func kakaoLogout() async throws
}
