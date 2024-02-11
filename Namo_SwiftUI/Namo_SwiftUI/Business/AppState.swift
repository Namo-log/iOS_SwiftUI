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
	
	//Tabbar
	@Published var isTabbarHidden: Bool = false
	@Published var isTabbarOpaque: Bool = false
	
	@Published var showAlert: Bool = false
	@Published var alertMessage: String = ""
}
