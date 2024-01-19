//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct SplashView: View {
	@State var isActive: Bool = false
	@State var isLogin: Bool = false
	
    var body: some View {
        ZStack {
			if isActive && isLogin {
				NamoHome()
			} else if isActive && !isLogin {
				// 온보딩 view
			} else {
				// splash view
				Text("Splash View")
			}
        }
		.onAppear {
			// 로그인 후
			isLogin = true
			
			// 스플래시 뷰 지속 시간
			DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
				isActive = true
			}
		}
    }
}

#Preview {
    SplashView()
}
