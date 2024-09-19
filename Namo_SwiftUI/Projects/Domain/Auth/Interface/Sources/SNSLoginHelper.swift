//
//  SNSLoginHelper.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/19/24.
//

import Foundation
import AuthenticationServices

import Core
import SharedUtil

public final class SNSLoginHelper: NSObject {
    
    // 클로저 저장을 위한 프로퍼티
    private var appleLoginCompletion: ((AppleLoginInfo?) -> Void)?
    
    // 애플 로그인
    public func appleLogin(completion: @escaping (AppleLoginInfo?) -> Void) {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        self.appleLoginCompletion = completion
        authorizationController.performRequests()
    }
}

// MARK: 애플 로그인 Extension 구현
extension SNSLoginHelper: ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding, ASAuthorizationControllerPresentationContextProviding {
    
    // 애플 로그인 성공 시 필요 정보 클로저로 리턴
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            self.appleLoginCompletion?(nil)
            return
        }
        
        guard
            let identityToken = appleIDCredential.identityToken,
            let identityTokenString = String(data: identityToken, encoding: .utf8),
            let authorizationCode = appleIDCredential.authorizationCode,
            let authorizationCodeString = String(data: authorizationCode, encoding: .utf8)
        else {
            self.appleLoginCompletion?(nil)
            return
        }
        
        self.appleLoginCompletion?(
            AppleLoginInfo(
                identityToken: identityTokenString,
                authorizationCode: authorizationCodeString
            )
        )
    }
    
    // 애플 로그인 실패 시 nil 리턴
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple login failed: \(error.localizedDescription)")
        self.appleLoginCompletion?(nil)
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
