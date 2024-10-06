//
//  MoimScheduleStoreInterface.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI
import UIKit
import PhotosUI
import ComposableArchitecture

@Reducer
public struct MoimEditStore {
    private let reducer: Reduce<State, Action>
    
    public init(reducer: Reduce<State, Action>) {
        self.reducer = reducer
    }
            
    public struct State: Equatable {
        @BindingState public var title: String = ""
        @BindingState public var coverImageItem: PhotosPickerItem?
        @BindingState public var startDate: Date = .now
        @BindingState public var endDate: Date = .now
        @BindingState public var isStartPickerPresented: Bool = false
        @BindingState public var isEndPickerPresented: Bool = false
        
        public var coverImage: UIImage?
        public var longitude = 0.0
        public var latitude = 0.0
        public var locationName = ""
        public var kakaoLocationId = ""
        public var participants: [String] = []
        
        public init() {}
    }
    
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case selectedImage(UIImage)
        case startPickerTapped
        case endPickerTapped
        case createButtonTapped
        case cancleButtonTapped
        case goToKakaoMap
        case viewOnAppear
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        reducer
    }
}


