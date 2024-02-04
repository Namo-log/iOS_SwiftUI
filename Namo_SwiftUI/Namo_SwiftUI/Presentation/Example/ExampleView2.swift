//
//  ExampleView2.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import SwiftUI
import Factory

struct ExampleView2: View {
    
    @EnvironmentObject var appState: AppState
    @Injected(\.authInteractor) var authInteractor
    
    var body: some View {
        
        // 다음 화면에서도 appState의 값이 공유됩니다.
        Text("\(appState.example)")
    }
}

#Preview {
    ExampleView2()
        .environmentObject(AppState())
}
