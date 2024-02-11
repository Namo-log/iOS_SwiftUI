//
//  CustomMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory

// 아직 쓰이지 않는 커스텀 뷰를 로그아웃 예시로 쓰고 있습니다.
struct CustomMainView: View {
    
    @EnvironmentObject var appState: AppState
    @Injected(\.authInteractor) var authInteractor
    
    
    var body: some View {
        
        if !appState.isLogin {
            LoginView()
        } else {
            Text("로그아웃 테스트")
            
            Button {
                Task {
                    await authInteractor.logout()
                }
            } label: {
                Text("로그아웃")
            }
        }
    }
}

#Preview {
    CustomMainView()
        .environmentObject(AppState())
}
