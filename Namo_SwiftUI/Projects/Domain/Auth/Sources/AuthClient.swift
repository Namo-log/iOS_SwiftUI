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

extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient(
        
        // MARK: API
        loginHelper: SNSLoginHelper(),
        reqSignInWithApple: { reqDTO -> Tokens? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: reqDTO))
            guard let data = res?.result else { return nil }
            return (data.accessToken, data.refreshToken)
        },
        reqSignInWithNaver: { reqDTO -> Tokens? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: reqDTO))
            guard let data = res?.result else { return nil }
            return (data.accessToken, data.refreshToken)
        },
        reqSignInWithKakao: { reqDTO -> Tokens? in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: reqDTO))
            guard let data = res?.result else { return nil }
            return (data.accessToken, data.refreshToken)
        },
        reqSignOut: { reqDTO -> Void in
            let result: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(refreshToken: reqDTO))
            // 나모 로그아웃 요청이 실패한 경우 에러 throw
            if result?.code != 200 {
                throw APIError.customError("로그아웃 실패: 응답 코드 \(result?.code ?? 0)")
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

