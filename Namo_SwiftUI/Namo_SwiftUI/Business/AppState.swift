//
//  AppState.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

class AppState: ObservableObject {
	
	// Tabbar
	@Published var isTabbarHidden: Bool = false
	@Published var isTabbarOpaque: Bool = false
    
    @Published var currentTab: Tab = .home
	
	// Alert
	@Published var showAlert: Bool = false
	@Published var alertMessage: String = ""
    
	// Category(key - categoryId, value - paletteId)
	@Published var categoryPalette: [Int: Int] = [:]
}
