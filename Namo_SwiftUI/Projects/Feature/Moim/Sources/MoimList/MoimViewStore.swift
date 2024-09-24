//
//  MoimViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MoimViewStore {    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case requestButtonTap
        case logout
    }
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .requestButtonTap:                
                return .none
            default:
                return .none
            }
        }
    }
}
