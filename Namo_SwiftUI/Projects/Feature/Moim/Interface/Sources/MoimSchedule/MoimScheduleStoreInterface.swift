//
//  MoimScheduleStoreInterface.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI
import PhotosUI
import ComposableArchitecture

@Reducer
public struct MoimScheduleStore {
    private let reducer: Reduce<State, Action>
    
    public init(reducer: Reduce<State, Action>) {
        self.reducer = reducer
    }
            
    public struct State: Equatable {
        @BindingState public var title: String = ""
        @BindingState public var coverImageItem: PhotosPickerItem?
        @BindingState public var startDate: Date = .now
        @BindingState public var endDate: Date = .now
        @BindingState public var showingStartPicker: Bool = false
        @BindingState public var showingEndPicker: Bool = false
        
        public var coverImage: Image?
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case selectedImage(Image)
        case startPickerTapped
        case endPickerTapped
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        reducer
    }
}
