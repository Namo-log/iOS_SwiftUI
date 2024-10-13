//
//  OnboardingCompleteStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 10/9/24.
//

import ComposableArchitecture

@Reducer
public struct OnboardingCompleteStore {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        /// 다음 화면 이동
        case goToNextScreen
    }
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                
            case .goToNextScreen:
                print("move to next page")
                return .none
            }
        }
    }
}

