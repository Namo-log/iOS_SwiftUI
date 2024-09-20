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

extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient(
        
        // MARK: API
        loginHelper: SNSLoginHelper(),
        reqSignInWithApple: { reqDTO in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: reqDTO))
            guard let data = res?.result else { return nil }
            return (data.accessToken, data.refreshToken)
        },
        reqSignInWithNaver: { reqDTO in
            let res: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: reqDTO))
            print("자 여기서 너가 어떻게 할지 보자고")
            print(res)
            guard let data = res?.result else { return nil }
            return (data.accessToken, data.refreshToken)
        }
    )
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

