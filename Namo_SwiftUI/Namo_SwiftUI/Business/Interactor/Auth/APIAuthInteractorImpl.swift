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

enum socialLogin {
    
    case kakao
    case naver
    case apple
}

class APIAuthInteractorImpl: NSObject, AuthInteractor, ASAuthorizationControllerPresentationContextProviding {
    
    @Injected(\.authRepository) private var authRepository
    @Injected(\.appState) private var appState: AppState
    
    // 카카오 로그인
    func kakaoLogin() async {
        
        DispatchQueue.main.async {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                
                UserApi.shared.loginWithKakaoTalk { [weak self] (oauthToken, error) in
                    
                    if let error = error {

                        print("카카오 토큰(앱) 받아오기 실패", error.localizedDescription)
                        
                    } else {
                        
                        print("카카오 토큰(앱) 받아오기 성공")
                        
                        guard let kakaoAccessToken = oauthToken?.accessToken else { return }
                        
                        print("카카오 accessToken: \(kakaoAccessToken)")
                        
                        let socialAccessToken = SocialAccessToken(accessToken: kakaoAccessToken)
                        
                        Task {
                            
                            let namoServerTokens = await self?.authRepository.getServerToken(socialAccessToken: socialAccessToken, social: SocialType.kakao)
                            
                            if let serverTokens = namoServerTokens {
                                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                                
                                print("accessToken: \(serverTokens.accessToken)")
                                print("refreshToken: \(serverTokens.refreshToken)")
                                
                                /// 현재 로그인한 소셜 미디어는 카카오
//                                self.appState.socialLogin = .kakao
                                UserDefaults.standard.set("kakao", forKey: "socialLogin")
                                
                                KeyChainManager.addItem(key: "kakaoAccessToken", value: kakaoAccessToken)
                                
                                DispatchQueue.main.async {
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
                                    self?.appState.isTabbarHidden = false
                                }
                                
                            } else {
                                
                                ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "인증 오류", message: "일시적인 인증 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "나모서버에서 토큰 받아오기 실패(카카오 로그인)"))
                                
                            }
                        }
                    }
                }
            } else {
                
                UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                    
                    if let error = error {
                        
                        print("카카오 토큰(웹) 받아오기 실패", error.localizedDescription)
                        
                    } else {
                        
                        print("카카오 토큰(웹) 받아오기 성공")
                        
                        guard let kakaoAccessToken = oauthToken?.accessToken else { return }
                        
                        print("카카오 accessToken: \(kakaoAccessToken)")
                        
                        let socialAccessToken = SocialAccessToken(accessToken: kakaoAccessToken)
                        
                        Task {
                            
                            let namoServerTokens = await self.authRepository.getServerToken(socialAccessToken: socialAccessToken, social: SocialType.kakao)
                            
                            if let serverTokens = namoServerTokens {
                                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                                
                                print("accessToken: \(serverTokens.accessToken)")
                                print("refreshToken: \(serverTokens.refreshToken)")
                                
                                KeyChainManager.addItem(key: "kakaoAccessToken", value: kakaoAccessToken)
                                
                                /// 현재 로그인한 소셜 미디어는 카카오
//                                self.appState.socialLogin = .kakao
                                UserDefaults.standard.set("kakao", forKey: "socialLogin")
                                
                                DispatchQueue.main.async {
                                    
                                    UserDefaults.standard.set(true, forKey: "isLogin")
                                    UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
                                    self.appState.isTabbarHidden = false
                                }
               
                            } else {
                                ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "인증 오류", message: "일시적인 인증 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "나모서버에서 토큰 받아오기 실패(카카오 로그인)"))
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
    
    // 회원 탈퇴
    func withdrawMember() async {
        
        if let sociallogin = UserDefaults.standard.string(forKey: "socialLogin") {
            
            if sociallogin == "kakao" {
                
                let result: BaseResponse<String>? = await authRepository.withdrawMemberKakao(kakaoAccessToken: WithDrawKakakoNaverRequestDTO(accessToken: KeyChainManager.readItem(key: "kakaoAccessToken")!))
                
                if result?.code == 200 {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isLogin")
                        self.appState.isTabbarHidden = true
                        self.appState.currentTab = .home
                    }
                } else {
                    ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "회원 탈퇴 오류", message: "일시적인 서비스 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "카카오 회원 탈퇴 \(String(describing: result?.code)) 에러"))
                }
                
            } else if sociallogin == "naver" {
                
                let result: BaseResponse<String>? = await authRepository.withdrawMemberNaver(naverAccessToken: WithDrawKakakoNaverRequestDTO(accessToken: KeyChainManager.readItem(key: "naverAccessToken")!))
                
                if result?.code == 200 {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isLogin")
                        self.appState.isTabbarHidden = true
                        self.appState.currentTab = .home
                    }
                } else {

                    ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "회원 탈퇴 오류", message: "일시적인 서비스 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "네이버 회원 탈퇴 \(String(describing: result?.code)) 에러"))
                }
                
            } else if sociallogin == "apple" {
                
                let result: BaseResponse<String>? = await authRepository.withdrawMemberApple(appleAuthorizationCode: WithDrawAppleRequestDTO(authorizationCode: KeyChainManager.readItem(key: "appleAuthorizationCode")!))
                
                if result?.code == 200 {
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(false, forKey: "isLogin")
                        self.appState.isTabbarHidden = true
                        self.appState.currentTab = .home
                    }
                } else {
                    ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "회원 탈퇴 오류", message: "일시적인 서비스 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "애플 회원 탈퇴 \(String(describing: result?.code)) 에러"))
                }
            }
        }
    }
    
    // 로그아웃
    func logout() async {
        
        let accessToken: String = KeyChainManager.readItem(key: "accessToken")!
        
        // 나모 서버 로그아웃 처리
        let result: BaseResponse<ServerTokenResponse>? = await authRepository.removeToken(serverAccessToken: ServerAccessToken(accessToken: accessToken))
        
        if result?.code == 200 {

            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
                self.appState.isTabbarHidden = true
                self.appState.currentTab = .home
            }
            
            KeyChainManager.deleteItem(key: "accessToken")
            
            if let sociallogin = UserDefaults.standard.string(forKey: "socialLogin") {
                
                // 현재 소셜 로그인이 카카오인 경우 카카오 로그아웃 처리
                if sociallogin == "kakao" {
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
                // 현재 소셜 로그인이 네이버인 경우 네이버 로그아웃 처리
                } else if sociallogin == "naver" {
                    await NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
                    
                    print("네이버 로그아웃 성공")
                
                // 현재 소셜 로그인이 애플인 경우 로그아웃 처리
                } else if sociallogin == "apple" {
                
                    print("애플 로그아웃 성공")
                }
            }
        } else {
            
            // MARK: 에러 핸들링 추후에 필요
            ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "회원 탈퇴 오류", message: "일시적인 서비스 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "로그아웃 \(String(describing: result?.code)) 에러"))
        }
    }
}

// MARK: 네이버 로그인 Extension 구현
extension APIAuthInteractorImpl: NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        
        print("네이버 로그인 성공")
        
        let naverAccessToken = NaverThirdPartyLoginConnection.getSharedInstance().accessToken ?? ""
        
        print("네이버 AccessToken: \(naverAccessToken)")
        
        Task {
            
            let namoServerTokens = await authRepository.getServerToken(socialAccessToken: SocialAccessToken(accessToken: naverAccessToken), social: SocialType.naver)
            
            if let serverTokens = namoServerTokens {
                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                
                print("accessToken: \(serverTokens.accessToken)")
                print("refreshToken: \(serverTokens.refreshToken)")
                
                DispatchQueue.main.async {
                    
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
                    self.appState.isTabbarHidden = false
                }
                
                KeyChainManager.addItem(key: "naverAccessToken", value: naverAccessToken)
                
                UserDefaults.standard.set("naver", forKey: "socialLogin")

            } else {
                
                ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "인증 오류", message: "일시적인 인증 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "나모서버에서 토큰 받아오기 실패(네이버 로그인)"))
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
        
        let identityToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)!
        
        let authorizationCode = String(data: appleIDCredential.authorizationCode!, encoding: .utf8)!
        
        print("authorizationCode: \(authorizationCode)")
        
        print("identityToken: \(identityToken)")
        print("email: \(appleIDCredential.email)")
        print("username: \(appleIDCredential.fullName)")
        
        var email: String = ""
        var username: String = ""
        
        if let appleEmail = appleIDCredential.email {
            email = appleEmail
            
            UserDefaults.standard.set(appleEmail, forKey: "appleLoginEmail")
            
        } else {
            email = UserDefaults.standard.string(forKey: "appleLoginEmail") ?? ""
            print(email)
        }
        
        if let appleFullName = appleIDCredential.fullName {
            if let familyName = appleFullName.familyName, let givenName = appleFullName.givenName {
                
                username = familyName + givenName
                
                UserDefaults.standard.set(username, forKey: "appleLoginUsername")
                
            } else {
                
                username = UserDefaults.standard.string(forKey: "appleLoginUsername") ?? ""
                print(username)
            }
        }
        
        let appleLoginDTO = AppleAccessToken(identityToken: identityToken, username: username, email: email)
        
        print("서버로 보내는 identityToken: \(identityToken)")
        print("서버로 보내는 username: \(username)")
        print("서버로 보내는 email: \(email)")
        print("서버로 보내는 username: \(type(of: username))")
        print("서버로 보내는 email: \(type(of: email))")
        
        Task {
            
            let namoServerTokens = await authRepository.getServerTokenApple(appleAccessToken: appleLoginDTO)
            
            if let serverTokens = namoServerTokens {
                KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                
                print("accessToken: \(serverTokens.accessToken)")
                print("refreshToken: \(serverTokens.refreshToken)")
                
                DispatchQueue.main.async {
                    
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
                    self.appState.isTabbarHidden = false
                }
                
                KeyChainManager.addItem(key: "appleAuthorizationCode", value: authorizationCode)
                
                /// 현재 로그인한 소셜 미디어는 애플
                UserDefaults.standard.set("apple", forKey: "socialLogin")
                
                print("애플 로그인 성공")

            } else {
                print("서버 토큰 에러")
            }
        }
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
