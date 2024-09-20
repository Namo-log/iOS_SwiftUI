//
//  MoimCoordinatorView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/21/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

public struct MoimCoordinatorView: View {
    let store: StoreOf<MoimCoordinator>
    
    public init(store: StoreOf<MoimCoordinator>) {
        self.store = store
    }
    
    public var body: some View {
        TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
            switch screen.case {
            case let .moimSchedule(store):
                MoimView(store: store)
            case let .moimRequest(store):
                MoimRequestView(store: store)
            }
        }
    }
}

