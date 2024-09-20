//
//  MainTabCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

@Reducer
struct MainTabCoordinator {
    enum Tab: Hashable {
        case moim
    }
    
    @ObservableState
    struct State: Equatable {
        
    }
}
