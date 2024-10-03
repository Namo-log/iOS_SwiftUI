//
//  MoimViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture
import FeatureMoimInterface
import FeatureFriend
@Reducer
public struct MainViewStore {
    public init() {}
        
    public struct State: Equatable {
        public static let initialState = State(moimList: .init(), friendList: .init(), moimEdit: .init())
        
        // 현재 선택한탭
        @BindingState public var currentTab = 0
        // 일정생성뷰
        @BindingState public var isSheetPresented = false
        // 모임리스트
        var moimList: MoimListStore.State
        // 친구리스트
        var friendList: FriendListStore.State
        // 모임생성
        var moimEdit: MoimEditStore.State
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case notificationButtonTap
        case moimList(MoimListStore.Action)
        case moimEdit(MoimEditStore.Action)
        case friendList(FriendListStore.Action)
    }
    
    public var body: some Reducer<State, Action> {
        Scope(state: \.moimList, action: \.moimList) {
            MoimListStore()
        }
        Scope(state: \.friendList, action: \.friendList) {
            FriendListStore()
        }
        Scope(state: \.moimEdit, action: \.moimEdit) {
            MoimEditStore()
        }
        
        BindingReducer()
    }
}
