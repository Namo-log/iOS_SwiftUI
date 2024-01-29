//
//  LoginViewModel.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/23/24.
//

import Foundation
import KakaoSDKUser

class LoginViewModel: ObservableObject {
    
    @Published var errorMessage: String? = nil
    @Published var isLogin = false
    
    
    func kakaoLogin() {
        
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            UserApi.shared.loginWithKakaoTalk() { (oauthToken, error) in
                
                if let error = error {
                    print(error)
                } else {
                    print("카카오톡으로 로그인 성공")
                }
                guard let accessToken = oauthToken?.accessToken else { return }
                
                do {
                    try KeyChainManager.addItem(key: "accessTokenKakao", value: accessToken)
                    try KeyChainManager.addItem(key: "kakaoLogin", value: "true")
                } catch (let error) {
                    
                    self.errorMessage = error.localizedDescription
                }
                
                LoginAPI.kakaoLogin(accessToken: accessToken) { [weak self] result in
                    
                    switch result {
                        
                    case.success(let result):
                        
                        if (result.code == 200) {
                            
                            print("성공(간편 로그인(카카오)): \(result.message)")
                            
                            do {
                                try KeyChainManager.addItem(key: "accessToken", value: result.result?.accessToken ?? "1")
                                try KeyChainManager.addItem(key: "refreshToken", value: result.result?.refreshToken ?? "1")
                            } catch (let error) {
                                
                                self?.errorMessage = error.localizedDescription
                            }
                            
                            self?.isLogin = true
                        
                        } else {
                            
                            switch result.code {
                                
                            default:
                                
                                self?.errorMessage = "서버 에러!: \(String(describing: error?.localizedDescription))"
                                
                            }
                            
                        }
                        
                    case .failure(let error):
                        
                        print("실패(AF-간편 로그인(카카오)): \(error.localizedDescription)")
                        
                        self?.errorMessage = "Wifi 또는 셀룰러 네트워크에\n 연결되어 있는지 확인하십시오"
                        
                    }
                }
            }
            
        } else {
            
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                
                if let error = error {
                    
                    print(error)
                    print("로그인 실패")
                } else {
                    
                    print("카카오 계정으로 로그인 성공")
                    
                    guard let accessToken = oauthToken?.accessToken else {return}
                    
                    do {
                        try KeyChainManager.addItem(key: "accessTokenKakao", value: accessToken)
                        try KeyChainManager.addItem(key: "kakaoLogin", value: "true")
                    } catch (let error) {
                        
                        self.errorMessage = error.localizedDescription
                    }
                    
                    LoginAPI.kakaoLogin(accessToken: accessToken) { [weak self] result in
                        
                        switch result {
                            
                        case.success(let result):
                            
                            if (result.code == 200) {
                                
                                print("성공(간편 로그인(카카오)): \(result.message)")
                                
                                do {
                                    try KeyChainManager.addItem(key: "accessToken", value: result.result?.accessToken ?? "1")
                                    try KeyChainManager.addItem(key: "refreshToken", value: result.result?.refreshToken ?? "1")
                                } catch (let error) {
                                    
                                    self?.errorMessage = error.localizedDescription
                                }
                                
                                self?.isLogin = true
                            
                            } else {
                                
                                switch result.code {
                                    
                                default:
                                    
                                    self?.errorMessage = "서버 에러!: \(String(describing: error?.localizedDescription))"
                                    
                                }
                                
                            }
                            
                        case .failure(let error):
                            
                            print("실패(AF-간편 로그인(카카오)): \(error.localizedDescription)")
                            
                            self?.errorMessage = "Wifi 또는 셀룰러 네트워크에\n 연결되어 있는지 확인하십시오"
                            
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    

//    // 카카오 로그인
//    func kakaoLogin() async {
//        
//        if (UserApi.isKakaoTalkLoginAvailable()) {      // 카카오톡으로 로그인
//            
//            UserApi.shared.loginWithKakaoTalk { (oauthToken, error) in
//                
//                if let error = error {
//                    
//                    self.errorMessage = error.localizedDescription
//                } else {
//                    
//                    guard let accessToken = oauthToken?.accessToken else { return }
//                    
//                    try! KeyChainManager.addItem(key: "accessTokenKaKao", value: accessToken)
//                    
//                    print("카카오톡으로 로그인 성공")
//                    
//                    Task {
//                        
//                        do {
//                            try await LoginAPI.kakaoLogin(accessToken: accessToken)
//                            self.isLogin = true
//                            
//                        } catch KeyChainError.invalidItemFormat {
//                            
//                            self.errorMessage = "키체인 에러: 적절하지 않은 형식!"
//                        } catch (let error) {
//                            
//                            self.errorMessage = "키체인 에러: 알 수 없는 오류 - \(error.localizedDescription)"
//                        }
//                    }
//                }
//            }
//        } else {    // 카카오 계정으로 로그인(정보 직접 입력)
//            
//            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
//                
//                if let error = error {
//                    
//                    DispatchQueue.main.async {
//                        self.errorMessage = error.localizedDescription
//                    }
//                    
//                } else {
//                    print("카카오톡으로 로그인 성공")
//                    guard let accessToken = oauthToken?.accessToken else { return }
//                    
//                    do {
//                        try KeyChainManager.addItem(key: "accessTokenKaKao", value: accessToken)
//                    } catch (let error) {
//                        DispatchQueue.main.async {
//                            self.errorMessage = error.localizedDescription
//                        }
//                    }
//                    
//                    Task {
//                        
//                        do {
//                            try await LoginAPI.kakaoLogin(accessToken: accessToken)
//                        } catch KeyChainError.invalidItemFormat {
//                            
//                            DispatchQueue.main.async {
//                                self.errorMessage = "키체인 에러: 적절하지 않은 형식!"
//                            }
//                            
//                        } catch (let error) {
//                            
//                            DispatchQueue.main.async {
//                                self.errorMessage = "키체인 에러: 알 수 없는 오류22 - \(error.localizedDescription)"
//                            }
//                        }
//                    }
//                }
//            }
//        }
//    }
}
