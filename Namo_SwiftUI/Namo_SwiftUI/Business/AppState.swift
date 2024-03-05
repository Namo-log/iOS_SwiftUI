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
	
	// Tabbar
	@Published var isTabbarHidden: Bool = false
	@Published var isTabbarOpaque: Bool = false
	
	// Alert
	@Published var showAlert: Bool = false
	@Published var alertMessage: String = ""
    
	// Category(key - categoryId, value - paletteId)
	@Published var categoryPalette: [Int: Int] = [:]
	
    @Published var isLogin: Bool = false
	
    // TODO: - 회의한 것처럼 수정 필요
    @Published var isPersonalDiary: Bool = true
}
