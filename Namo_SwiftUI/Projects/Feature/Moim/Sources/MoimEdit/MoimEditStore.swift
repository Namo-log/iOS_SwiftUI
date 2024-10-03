//
//  MoimScheduleStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI
import ComposableArchitecture
import FeatureMoimInterface
import Domain

extension MoimEditStore {
    public init() {
        @Dependency(\.moimUseCase) var moimUseCase
        
        let reducer: Reduce<State, Action> = Reduce { state, action in
            switch action {
            case .binding(\.$coverImageItem):
                return .run { [imageItem = state.coverImageItem] send in
                    if let loaded = try? await imageItem?.loadTransferable(type: Image.self) {
                        await send(.selectedImage(loaded))
                    }
                }
                
            case let .selectedImage(image):
                state.coverImage = image
                return .none
                
            case .startPickerTapped:
                state.isStartPickerPresented.toggle()
                return .none
                
            case .endPickerTapped:
                state.isEndPickerPresented.toggle()
                return .none
                
            case .createButtonTapped:
                return .run { [state = state] send in
                    try await moimUseCase.createMoim(.init(title: state.title,
                                                                        imageUrl: "",
                                                                        startDate: state.startDate,
                                                                        endDate: state.endDate,
                                                                        longitude: 0.0,
                                                                        latitude: 0.0,
                                                                        locationName: "",
                                                                        kakaoLocationId: "",
                                                                        participants: []))                    
                }
            default:
                return .none
            }
        }
        self.init(reducer: reducer)
    }
}



