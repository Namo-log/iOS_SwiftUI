//
//  CustomMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory

struct CustomMainView: View {
    
    @Injected(\.authInteractor) var authInteractor
    
    var body: some View {

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

#Preview {
    CustomMainView()
        .environmentObject(AppState())
}
