//
//  APIAuthInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation
import Factory
import KakaoSDKUser
import KakaoSDKAuth
import NaverThirdPartyLogin
import AuthenticationServices

class APIAuthInteractorImpl: NSObject, AuthInteractor, ASAuthorizationControllerPresentationContextProviding {
    
    @Injected(\.authRepository) private var authRepository
    @Injected(\.appState) private var appState: AppState
    
    // 카카오 로그인
    func kakaoLogin() async {
        
        DispatchQueue.main.async {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                
                UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                    
                    if let error = error {
                        print(error.localizedDescription)
                        print("카카오 토큰(앱) 받아오기 실패")
                    } else {
                        
                        print("카카오 토큰(앱) 받아오기 성공")
                        
                        guard let accessToken = oauthToken?.accessToken else { return }
                        
                        print("카카오 accessToken: \(accessToken)")
                        
                        let socialAccessToken = SocialAccessToken(accessToken: accessToken)
                        
                        Task {
                            
                            let serverTokens = await self.authRepository.getServerToken(socialAccessToken: socialAccessToken, social: SocialType.kakao)
                            
                            if let serverTokens = serverTokens {
                                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                                
                                print("accessToken: \(serverTokens.accessToken)")
                                print("refreshToken: \(serverTokens.refreshToken)")
                                
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    self.appState.isTabbarHidden = false
                                }
                                
                            } else {
                                print("서버 토큰 에러")
                            }
                        }
                    }
                }
            } else {
                
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    
                    if let error = error {
                        print(error)
                        print("카카오 토큰(웹) 받아오기 실패")
                    } else {
                        
                        print("카카오 토큰(웹) 받아오기 성공")
                        
                        guard let accessToken = oauthToken?.accessToken else { return }
                        
                        print("카카오 accessToken: \(accessToken)")
                        
                        let socialAccessToken = SocialAccessToken(accessToken: accessToken)
                        
                        Task {
                            
                            let serverTokens = await self.authRepository.getServerToken(socialAccessToken: socialAccessToken, social: SocialType.kakao)
                            
                            if let serverTokens = serverTokens {
                                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                                
                                print("accessToken: \(serverTokens.accessToken)")
                                print("refreshToken: \(serverTokens.refreshToken)")
                                
                                DispatchQueue.main.async {
                                    
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    self.appState.isTabbarHidden = false
                                }
               
                            } else {
                                print("서버 토큰 에러")
                            }
                        }
                    }
                }
            }
    }
}
    
    // 네이버 로그인
    func naverLogin() {
        
        NaverThirdPartyLoginConnection.getSharedInstance().delegate = self
        NaverThirdPartyLoginConnection
            .getSharedInstance()
            .requestThirdPartyLogin()
    }
    
    // 애플 로그인
    func appleLogin() {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    // 로그아웃
    func logout() async {
        
        let accessToken: String = KeyChainManager.readItem(key: "accessToken")!
        
        let result: BaseResponse<Auth>? = await authRepository.removeToken(serverAccessToken: ServerAccessToken(accessToken: accessToken))
        
        if result?.code == 200 {

            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
                self.appState.isTabbarHidden = true
                self.appState.currentTab = .home
            }
            
            KeyChainManager.deleteItem(key: "accessToken")
            
            // 카카오 로그아웃
            if (AuthApi.hasToken()) {
                UserApi.shared.logout{ error in
                    
                    if let error = error {
                        print(error)
                        print(error.localizedDescription)
                    } else {
                        print("카카오 로그아웃 성공")
                    }
                }
            }

            // 네이버 로그아웃
            await NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
            
        } else {
            
            // MARK: 에러 핸들링 추후에 필요
            print(result?.code)
            print(result?.message)
            print("로그아웃 실패. 재시도하세요.")
        }
    }
}

// MARK: 네이버 로그인 Extension 구현
extension APIAuthInteractorImpl: NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        print("네이버 로그인 성공")
        
        let socialAccessToken = SocialAccessToken(
            accessToken: NaverThirdPartyLoginConnection.getSharedInstance().accessToken)
        
        print("네이버 AccessToken: \(socialAccessToken)")
        
        Task {
            
            let serverTokens = await authRepository.getServerToken(socialAccessToken: socialAccessToken, social: SocialType.naver)
            
            if let serverTokens = serverTokens {
                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                
                print("accessToken: \(serverTokens.accessToken)")
                print("refreshToken: \(serverTokens.refreshToken)")
                
                DispatchQueue.main.async {
                    
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    self.appState.isTabbarHidden = false
                }

            } else {
                print("서버 토큰 에러")
            }
        }
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {

    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        print("네이버 로그아웃 성공")
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("에러: \(error.localizedDescription)")
    }
}

// MARK: 애플 로그인 Extension 구현
extension APIAuthInteractorImpl: ASAuthorizationControllerDelegate, ASWebAuthenticationPresentationContextProviding {
    
    // 애플 로그인 성공 후 서버로 정보 보내기
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {return}
        
        print("Authentication successful: \(appleIDCredential.user)")
        print("Authentication successful: \(String(data: appleIDCredential.identityToken!, encoding: .utf8))")
        print("Authentication successful: \(String(data: appleIDCredential.authorizationCode!, encoding: .utf8))")
    }
    
    // 애플 로그인 실패
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Error occurred: \(error.localizedDescription)")
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
    
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}
