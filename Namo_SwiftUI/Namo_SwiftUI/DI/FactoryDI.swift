//
//  FactoryDI.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import Foundation
import Factory

extension Container {
    
    // 예시로 넣어둔 Factory 컨테이너 요소들이며 실제 구현에 쓰일 예정입니다.
    // 구현체들에 주입될 요소들입니다.
    
    var appState: Factory<AppState> {
        self { AppState() }
            .singleton
    }
    
    // 프로토콜 타입 지정 후 실제 구현체를 넣어준다는 의미입니다.
    var authInteractor: Factory<AuthInteractor> {
        self { APIAuthInteractorImpl() }
            .singleton
    }
    
    var authRepository: Factory<AuthRepository> {
        self { APIAuthRepositoryImpl() }
            .singleton
    }
}
