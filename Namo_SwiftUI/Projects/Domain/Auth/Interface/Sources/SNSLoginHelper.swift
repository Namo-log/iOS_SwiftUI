//
//  SNSLoginHelper.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/19/24.
//

import Foundation
import AuthenticationServices

import Core

public final class SNSLoginHelper: NSObject {
    // 애플 로그인
    public func appleLogin() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

// MARK: 애플 로그인 Extension 구현
extension SNSLoginHelper: ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding, ASAuthorizationControllerPresentationContextProviding {
    
    // 애플 로그인 성공 후 서버로 정보 보내기
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {return}
        
        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)!
        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!
        
        var email: String = ""
        var username: String = ""
        
        if let appleEmail = appleIDCredential.email {
            email = appleEmail
            
            UserDefaults.standard.set(appleEmail, forKey: "appleLoginEmail")
            
        } else {
            email = UserDefaults.standard.string(forKey: "appleLoginEmail") ?? ""
        }
        
        if let appleFullName = appleIDCredential.fullName {
            if let familyName = appleFullName.familyName, let givenName = appleFullName.givenName {
                
                username = familyName + givenName
                
                UserDefaults.standard.set(username, forKey: "appleLoginUsername")
                
            } else {
                
                username = UserDefaults.standard.string(forKey: "appleLoginUsername") ?? ""
            }
        }

        let appleLoginDTO = AppleSignInRequestDTO(identityToken: identityToken, authorizationCode: authorizationCode, username: username, email: email)
        
        print("야 됐다 : \(appleLoginDTO)")
        
        // 나모 서버 보내깅
//        Task {
//            
//            /// 나모 서버로부터 애플 토큰을 보내고 서버의 토큰을 받음
//            let result: BaseResponse<SignInResponseDTO>? = await authRepository.signIn(appleToken: appleLoginDTO)
//            
//            let namoServerTokens = result?.result
//            
//            /// 서버의 토큰을 제대로 받았을 때
//            if let serverTokens = namoServerTokens {
//                
//                /// 키체인에 서버의 토큰을 저장
//                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
//                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
//                
//                print("accessToken: \(serverTokens.accessToken)")
//                print("refreshToken: \(serverTokens.refreshToken)")
//                
//                /// 현재 로그인한 소셜 미디어는 애플
//                UserDefaults.standard.set("apple", forKey: "socialLogin")
//                
//                DispatchQueue.main.async {
//                    
//                    UserDefaults.standard.set(true, forKey: "isLogin")
//                    UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
//                }
//
//                print("애플 로그인 성공")
//
//            } else {
//                print("서버 토큰 에러")
//            }
//        }
    }
    
    // 애플 로그인 실패
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error occurred: \(error.localizedDescription)")
    }
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
