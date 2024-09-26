//
//  MoimRequestStoreInterface.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MoimRequestStore {
    private let reducer: Reduce<State, Action>
    
    public init(reducer: Reduce<State, Action>) {
        self.reducer = reducer
    }
    
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case backButtonTap
    }
    
    public var body: some ReducerOf<Self> {
        reducer
    }
}
