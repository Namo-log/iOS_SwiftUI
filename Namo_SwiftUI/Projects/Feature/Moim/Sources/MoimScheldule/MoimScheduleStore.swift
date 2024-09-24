//
//  MoimScheduleStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/24/24.
//

import SwiftUI
import ComposableArchitecture
import FeatureMoimInterface

extension MoimScheduleStore {
    public init() {
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
                state.showingStartPicker.toggle()
                return .none
            case .endPickerTapped:
                state.showingEndPicker.toggle()
                return .none
            default:
                return .none
            }
        }
        self.init(reducer: reducer)
    }
}
