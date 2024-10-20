//
//  PlaceSearchStore.swift
//  FeaturePlaceSearchInterface
//
//  Created by 권석기 on 10/20/24.
//

import Foundation
import FeaturePlaceSearchInterface
import DomainPlaceSearch
import ComposableArchitecture

public extension PlaceSearchStore {
    public init() {
        @Dependency(\.placeUseCase) var placeUseCase
        
        let reducer: Reduce<State, Action> = Reduce { state, action in
            switch action {
            case .searchButtonTapped:
                return .run { [state = state] send in
                    try await placeUseCase.getSearchList(state.searchText)
                }
            default:
                return .none
            }
        }
        
        self.init(reducer: reducer)
    }
}
