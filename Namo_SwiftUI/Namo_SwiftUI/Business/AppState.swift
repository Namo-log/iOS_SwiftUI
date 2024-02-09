//
//  AppState.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

class AppState: ObservableObject {
    
    // 예시로 입력한 프로퍼티입니다.
    @Published var example = 0
	
	@Published var isTabbarHidden: Bool = false
    
    @Published var isLogin: Bool = false
}
