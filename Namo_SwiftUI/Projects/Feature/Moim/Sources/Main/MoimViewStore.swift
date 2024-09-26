//
//  MoimViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MoimViewStore {
    public init() {}
    public struct State: Equatable {}
    
    public enum Action {
        case notificationButtonTap
    }
}
