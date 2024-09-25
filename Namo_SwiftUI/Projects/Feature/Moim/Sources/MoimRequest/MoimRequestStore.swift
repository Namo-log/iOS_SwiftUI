//
//  MoimRequestStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture
import FeatureMoimInterface

extension MoimRequestStore {
    public init() {
        let reducer: Reduce<State, Action> = Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        self.init(reducer: reducer)
    }
}
