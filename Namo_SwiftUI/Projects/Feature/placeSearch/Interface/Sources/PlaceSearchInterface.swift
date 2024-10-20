//
//  PlaceSearchInterface.swift
//  FeaturePlaceSearchInterface
//
//  Created by 권석기 on 10/20/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct PlaceSearchStore {
    private let reducer: Reduce<State, Action>
    
    public init(reducer: Reduce<State, Action>) {
        self.reducer = reducer
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        public var longitude: Double = 0.0
        
        public var latitude: Double = 0.0
        
        public var locationName: String = ""
        
        public var searchText: String = ""
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case searchLocations
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        reducer
    }
}
