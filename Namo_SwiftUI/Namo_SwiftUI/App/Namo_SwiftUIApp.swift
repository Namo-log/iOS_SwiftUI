//
//  Namo_SwiftUIApp.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin

@main
struct Namo_SwiftUIApp: App {
    // 앱의 최상위에서 appState를 선언하여 앱의 전역에서 쓰일 수 있도록 합니다.
    var appState = Container.shared.appState()
    
    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    init() {
        KakaoSDK.initSDK(appKey: SecretConstants.kakaoLoginAPIKey)
        
        // 네이버 앱으로 로그인 허용
        instance?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        instance?.isInAppOauthEnable = true
        // 네이버 로그인 세로모드 고정
        instance?.setOnlyPortraitSupportInIphone(true)
        
        instance?.serviceUrlScheme = Bundle.main.bundleIdentifier
        instance?.consumerKey = SecretConstants.naverLoginConsumerKey
        instance?.consumerSecret = SecretConstants.naverLoginClinetSecret
        instance?.appName = "나모"
    }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appState)
                .onOpenURL(perform: { url in
                    
                    if AuthApi.isKakaoTalkLoginUrl(url) {
                        
                        AuthController.handleOpenUrl(url: url)
         
                    } else {
                        instance?.receiveAccessToken(url)
                    }
                })
        }
    }
}
