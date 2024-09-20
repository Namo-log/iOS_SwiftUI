//
//  MoimRequestViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/21/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MoimRequestViewStore {
    @ObservableState
    public struct State: Equatable {}
    
    public enum Action {
        case backButtonTap
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .backButtonTap:                
                return .none
            }
        }
    }
}
