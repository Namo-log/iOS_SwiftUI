//
//  MoimViewStore.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import Foundation
import ComposableArchitecture
import FeatureMoimInterface
import DomainMoimInterface
import FeatureFriend

@Reducer
public struct MainViewStore {
    @Dependency(\.moimUseCase) var moimUseCase
    
    public init() {}
    
    public struct State: Equatable {
        public static let initialState = State(moimList: .init(), 
                                               friendList: .init(),
                                               moimEdit: .init())
        
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
        case presentDetailSheet(MoimSchedule)
        case presentComposeSheet
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
        
        Reduce<State, Action> { state, action in
            switch action {
            case .moimEdit(.cancleButtonTapped):
                state.isSheetPresented = false
                return .none
            case let .moimList(.moimCellSelected(meetingScheduleId)):
                return .run { send in
                    do {
                        let moimSchedule = try await moimUseCase.getMoimDetail(meetingScheduleId)
                            await send(.presentDetailSheet(moimSchedule))
                    } catch {
                        
                    }
                }
            case let .presentDetailSheet(moimSchedule):
                state.isSheetPresented = true
                state.moimEdit.title = moimSchedule.title
                state.moimEdit.startDate = moimSchedule.startDate
                state.moimEdit.endDate = moimSchedule.endDate
                state.moimEdit.latitude = moimSchedule.latitude
                state.moimEdit.longitude = moimSchedule.longitude
                state.moimEdit.kakaoLocationId = moimSchedule.kakaoLocationId
                return .none
            case .presentComposeSheet:
                state.moimEdit = .init()
                state.isSheetPresented = true
                return .none
            default:
                return .none
            }
        }
    }
}
