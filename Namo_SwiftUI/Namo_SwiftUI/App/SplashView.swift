//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false   // 다음 화면 활성화
	@State var didGetRemoteConfig: Bool = false
	@State var showUpdateRequired: Bool = false
    @AppStorage("onboardingDone") var onboardingDone: Bool = false  // 온보딩 완료 여부
    @AppStorage("isLogin") var isLogin: Bool = false                // 로그인 여부
    @AppStorage("newUser") var newUser: Bool = true                 // 약관동의 완료 여부
    
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
                AgreeMainView()     // 약관동의 화면
            } else {
                ZStack {            // 스플래시 화면
                    
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0xe59744), Color.mainOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Image(.logo)
					
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
					if let minimumVersion = try await RemoteConfigManager().getMinimumVersion() {
						let checkUpdate = checkUpdateRequired(minimumVersion: "2.0.0", currentVersion: version)
						showUpdateRequired = checkUpdate
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
