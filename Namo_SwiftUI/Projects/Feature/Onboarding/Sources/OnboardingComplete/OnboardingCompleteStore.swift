//
//  OnboardingCompleteStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 10/9/24.
//

import ComposableArchitecture
import DomainAuthInterface

@Reducer
public struct OnboardingCompleteStore {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {

        var presentInfo: SignUpInfo?
        
        public init(result: SignUpInfo) {
            self.presentInfo = result
        }
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

