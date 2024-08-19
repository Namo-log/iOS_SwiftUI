//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Common
import Networks

struct SplashView: View {
    
    @State var isActive: Bool = false   // 다음 화면 활성화
    @State var didGetRemoteConfig: Bool = false
    @State var showUpdateRequired: Bool = false
    @AppStorage("onboardingDone") var onboardingDone: Bool = false  // 온보딩 완료 여부
    @AppStorage("isLogin") var isLogin: Bool = false                // 로그인 여부
    @AppStorage("newUser") var newUser: Bool = true                 // 약관동의 완료 여부
    
    let remoteConfigManager = RemoteConfigManager()
    
    var socialLogin: String?
    
    var body: some View {
        ZStack {
            
            if !onboardingDone && isActive && didGetRemoteConfig && !showUpdateRequired {
                OnboardingView()    // 온보딩 화면
            } else if onboardingDone && isActive && didGetRemoteConfig && !showUpdateRequired && !isLogin {
                LoginView()         // 로그인 화면
            } else if onboardingDone && isActive && didGetRemoteConfig && !showUpdateRequired && isLogin && !newUser {
                NamoHome()          // 나모 홈 화면
            } else if onboardingDone && isActive && didGetRemoteConfig && !showUpdateRequired && isLogin && newUser {
                AgreeView()     // 약관동의 화면
            } else {
                ZStack {            // 스플래시 화면
                    
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0xe59744), Color(asset: CommonAsset.Assets.mainOrange)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Image(asset: CommonAsset.Assets.logo)
                    
                    if showUpdateRequired {
                        NamoAlertViewWithOneButton(
                            showAlert: .constant(true),
                            title: "업데이트가 필요합니다.",
                            buttonTitle: "업데이트 하러 가기",
                            buttonAction: {
                                openAppStore(appID: "6477534399")
                            }
                        )
                    }
                }
            }
        }
        .onAppear {
            Task {
                do {
                    if let minimumVersion = try await remoteConfigManager.getMinimumVersion() {
                        let checkUpdate = checkUpdateRequired(minimumVersion: minimumVersion, currentVersion: version)
                        showUpdateRequired = checkUpdate
                        #if DEBUG
                        showUpdateRequired = false
                        #endif
                        
                        
                    }
                    
                    if let baseUrl = try await remoteConfigManager.getBaseUrl() {
                        //						SecretConstants.baseURL = baseUrl
                        let result = await APIManager.shared.ReissuanceToken()
                        if !result {
                            print("==== 토큰 갱신 실패로 로그아웃 처리됨 ====")
                            
                            // 로그아웃 처리
                            DispatchQueue.main.async {
                                UserDefaults.standard.set(false, forKey: "isLogin")
                            }
                        }
                    }
                } catch {
                    print("최소 버전 가져오기 실패")
                }
                didGetRemoteConfig = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
            
            UserDefaults.standard.set(socialLogin, forKey: "socialLogin")
        }
        .ignoresSafeArea()
    }
    
    // 업데이트가 필요하면 true를, 필요없다면 false를
    func checkUpdateRequired(minimumVersion: String, currentVersion: String) -> Bool {
        // 버전 문자열을 '.'을 기준으로 나누어 배열로 변환
        let minimumVersionComponents = minimumVersion.split(separator: ".").map { Int($0) ?? 0 }
        let currentVersionComponents = currentVersion.split(separator: ".").map { Int($0) ?? 0 }
        
        // 두 배열의 길이를 맞추기 위해 짧은 배열에 0 추가
        let maxLength = max(minimumVersionComponents.count, currentVersionComponents.count)
        let paddedMinimumVersion = minimumVersionComponents + Array(repeating: 0, count: maxLength - minimumVersionComponents.count)
        let paddedCurrentVersion = currentVersionComponents + Array(repeating: 0, count: maxLength - currentVersionComponents.count)
        
        // 각 버전 숫자를 비교
        for (min, cur) in zip(paddedMinimumVersion, paddedCurrentVersion) {
            if cur < min {
                return true // 업데이트가 필요함
            } else if cur > min {
                return false // 업데이트가 필요하지 않음
            }
        }
        
        return false // 두 버전이 같음
    }
    
    func openAppStore(appID: String) {
        if let url = URL(string: "https://apps.apple.com/app/id\(appID)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview {
    SplashView(socialLogin: "kakao")
}
