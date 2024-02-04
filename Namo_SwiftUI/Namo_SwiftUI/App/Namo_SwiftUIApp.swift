//
//  Namo_SwiftUIApp.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory

@main
struct Namo_SwiftUIApp: App {
    
    // 앱의 최상위에서 appState를 선언하여 앱의 전역에서 쓰일 수 있도록 합니다.
    var appState = Container.shared.appState()
    
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(appState)
        }
    }
}
