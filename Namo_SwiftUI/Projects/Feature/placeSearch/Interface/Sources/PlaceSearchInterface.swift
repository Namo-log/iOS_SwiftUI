//
//  PlaceSearchInterface.swift
//  FeaturePlaceSearchInterface
//
//  Created by 권석기 on 10/20/24.
//

import Foundation
import ComposableArchitecture
import DomainPlaceSearchInterface

@Reducer
public struct PlaceSearchStore {
    private let reducer: Reduce<State, Action>
    
    public init(reducer: Reduce<State, Action>) {
        self.reducer = reducer
    }
    
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        public var draw: Bool = false
        
        public var id: String = ""
        
        public var x: Double = 0.0
        
        public var y: Double = 0.0
        
        public var locationName: String = ""                
        
        public var searchText: String = ""
        
        public var searchList: [LocationInfo] = []
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case searchButtonTapped
        case placeListResponse([LocationInfo])
        case poiTapped(String)
        case viewOnAppear
        case viewOnDisappear
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        reducer
    }
}
