//
//  MoimViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture

@Reducer
public struct MainViewStore {
    public init() {}
        
    public struct State: Equatable {
        public init() {}
        
        // 현재 선택한탭
        @BindingState public var currentTab = 0
        // 일정생성뷰
        @BindingState public var isSheetPresented = false
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case notificationButtonTap
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
    }
}
