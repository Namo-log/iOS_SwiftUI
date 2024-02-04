//
//  Namo_SwiftUIApp.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

@main
struct Namo_SwiftUIApp: App {
	
    var body: some Scene {
        WindowGroup {
            SplashView()
				.environmentObject(AppState())

        }
    }
}
