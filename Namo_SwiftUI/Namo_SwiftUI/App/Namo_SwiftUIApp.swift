//
//  Namo_SwiftUIApp.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct Namo_SwiftUIApp: App {
    
    init() {
        
        // KaKao SDK 초기화
        KakaoSDK.initSDK(appKey: "c67dfbcc5d7f1af4dccefc8cb7a4380d")
    }
    
    var body: some Scene {
        WindowGroup {
            LoginView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
