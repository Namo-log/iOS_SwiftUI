//
//  APIAuthInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation
import Factory
import KakaoSDKUser

// 예시로 넣어둔 AuthInteractor 구현체이며 실제 구현에 쓰일 예정입니다.
class APIAuthInteractorImpl: AuthInteractor {
    
    // Interactor는 AppState와 Repository를 주입받고 로직에 활용합니다.
    // Interactor의 AppState는 View의 Interactor를 통해 직접 접근할 수는 없고 Interactor의 로직으로 조작합니다.
    @Injected(\.authRepository) private var authRepository
    @Injected(\.appState) private var appState: AppState
    
    // 카카오 로그인
    func kakaoLogin() async {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                
                if let error = error {
                    print(error.localizedDescription)
                    print("카카오 토큰 받아오기 실패")
                } else {
                    
                    print("카카오 토큰 받아오기 성공")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
                    
                    let socialAccessToken = SocialAccessToken(accessToken: accessToken)
                    
                    Task {
                        
                        let serverTokens = await self.authRepository.getTokenKakao(socialAccessToken: socialAccessToken)
                        
                        if let serverTokens = serverTokens {
                            KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                            KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                            
                            print("accessToken: \(serverTokens.accessToken)")
                            print("refreshToken: \(serverTokens.refreshToken)")
                            
                            DispatchQueue.main.async {
                                self.appState.isLogin = true
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
                } else {
                    
                    print("카카오 토큰 받아오기 성공")
                    
                    guard let accessToken = oauthToken?.accessToken else { return }
                    
                    let socialAccessToken = SocialAccessToken(accessToken: accessToken)
                    
                    Task {
                        
                        let serverTokens = await self.authRepository.getTokenKakao(socialAccessToken: socialAccessToken)
                        
                        if let serverTokens = serverTokens {
                            KeyChainManager.addItem(key: "accessToken", value: serverTokens.accessToken)
                            KeyChainManager.addItem(key: "refreshToken", value: serverTokens.refreshToken)
                            
                            print("accessToken: \(serverTokens.accessToken)")
                            print("refreshToken: \(serverTokens.refreshToken)")
                            
                            DispatchQueue.main.async {
                                
                                self.appState.isLogin = true
                            }
           
                        } else {
                            print("서버 토큰 에러")
                        }
                    }
                }
            }
        }
        
    }
    
    // 로그아웃
    func logout() async {
        
        let accessToken: String = KeyChainManager.readItem(key: "accessToken")!
        
        let result: BaseResponse<Auth>? = await authRepository.removeToken(serverAccessToken: ServerAccessToken(accessToken: accessToken))
        
        if result?.code == 200 {
            
            print(result?.message)
            
            DispatchQueue.main.async {
                self.appState.isLogin = false
                self.appState.isTabbarHidden = true
            }
            
            KeyChainManager.deleteItem(key: "accessToken")
            
            
        } else {
            
            print(result?.code)
            print(result?.message)
            print("로그아웃 실패. 재시도하세요.")
        }
    }
    
    // 예시로 쓰인 메소드입니다.
    func example() {
        appState.example += 1
    }
}
