//
//  ExampleView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import SwiftUI
import Factory

struct ExampleView: View {
    
    // AppState와 Interactor를 뷰에서 사용하는 예시입니다.
    // Namo_SwiftUIApp에서 시작 화면을 ExampleView로 바꾸고 예시를 보시면 됩니다.
    // # 현재 프리뷰 화면에서는 AppState의 프로퍼티값 변화가 적용되지 않습니다. 따라서 직접 run을 해야 예시를 볼 수 있습니다.
    // 위 문제 해결법을 아시는 분은 공유 부탁드립니다...
    
    @EnvironmentObject var appState: AppState
    @Injected(\.authInteractor) var authInteractor
    
    var body: some View {
        
        NavigationStack {
            VStack {
                
                // appState의 값
                Text("\(appState.example)")
                
                Button {
                    
                    authInteractor.example()
                
                } label: {
                    Text("뷰의 Intereactor로 조작")
                }
                
                Button {
                    
                    appState.example += 1
                    
                } label: {
                    Text("뷰의 appState로 조작")
                }
           
                NavigationLink(destination: ExampleView2()) {
                    Text("다음 화면")
                }
            }
        }
    }
}

#Preview {
    
    ExampleView()
        .environmentObject(AppState())
}
