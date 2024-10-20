//
//  PlaceSearchStore.swift
//  FeaturePlaceSearchInterface
//
//  Created by 권석기 on 10/20/24.
//

import Foundation
import FeaturePlaceSearchInterface
import ComposableArchitecture

public extension PlaceSearchStore {
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
