//
//  MainTabCoordinatorView.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct MainTabCoordinatorView: View {
    let store: StoreOf<MainTabCoordinator>
    
    var body: some View {
        Text("MainTab!")
    }
}

