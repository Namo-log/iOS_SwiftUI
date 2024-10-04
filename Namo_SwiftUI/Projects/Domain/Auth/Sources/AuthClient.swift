//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/18/24.
//

import Foundation
import ComposableArchitecture

import Core
import DomainAuthInterface
import SharedUtil

/// API를 통해 소셜 로그인과 로그아웃, 나모 인증 작업을 수행하는 역할을 담당합니다.
/// Auth 관련 Namo API는 모두 이곳에서 호출됩니다.
/// - 의존성:
///   - `SNSLoginHelperProtocol`을 사용하여 소셜 로그인/로그아웃 API 로직을 처리합니다.
///   - 서버와의 통신을 담당하는 `APIManager`를 통해 실제 로그아웃 API 요청을 수행합니다.
extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient(
        
        // MARK: API
        loginHelper: SNSLoginHelper(),
        authManager: AuthManager(),
        reqSignInWithApple: { reqDTO -> SignInResponseDTO? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: reqDTO))
            guard let data = res?.result else { return nil }
            return data
        },
        reqSignInWithNaver: { reqDTO -> SignInResponseDTO? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: reqDTO))
            guard let data = res?.result else { return nil }
            return data
        },
        reqSignInWithKakao: { reqDTO -> SignInResponseDTO? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: reqDTO))
            guard let data = res?.result else { return nil }
            return data
        },
        reqSignOut: { reqDTO -> Void in
            let result: BaseResponse<String>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(refreshToken: reqDTO))
            // 나모 로그아웃 요청이 실패한 경우 에러 throw
            if result?.code != 200 {
                throw APIError.customError("로그아웃 실패: 응답 코드 \(result?.code ?? 0)")
            }
        },
        reqWithdrawalApple: { reqDTO in
            let result: BaseResponse<String>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result?.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result?.code ?? 0)")
            }
        },
        reqWithdrawalNaver: { reqDTO in
            let result: BaseResponse<String>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result?.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result?.code ?? 0)")
            }
        },
        reqWithdrawalKakao: { reqDTO in
            let result: BaseResponse<String>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result?.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result?.code ?? 0)")
            }
        }
    )
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

