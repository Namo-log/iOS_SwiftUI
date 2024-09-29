//
//  SplashCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators

@Reducer
struct SplashCoordinator {
    struct State: Equatable {}
    
    enum Action {
        case loginCheck(isSuccess: Bool)
    }
}