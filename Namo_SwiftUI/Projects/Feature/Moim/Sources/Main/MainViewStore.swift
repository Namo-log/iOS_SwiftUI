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
                // sheet가 사라질떄 데이터 로드
            case .binding(\.$isSheetPresented):
                if state.isSheetPresented == false {
                    state.moimEdit = .init()
                    return .send(.moimList(.viewOnAppear))
                }
                return .none
                // 모임 삭제 완료
            case .moimEdit(.deleteButtonConfirm):
                state.isSheetPresented = false
                return .none
                // 모임 수정 완료
            case .moimEdit(.createButtonTapped):
                state.isSheetPresented = false
                return .none
                // 모임 수정 취소
            case .moimEdit(.cancleButtonTapped):
                state.isSheetPresented = false
                return .none
                // 모임일정 선택
            case let .moimList(.moimCellSelected(meetingScheduleId)):
                return .run { send in
                    let moimSchedule = try await moimUseCase.getMoimDetail(meetingScheduleId)
                    await send(.presentDetailSheet(moimSchedule))
                } catch: { error, send in
                    // 에러 처리
                }
                // 모임일정 선택후 상태
            case let .presentDetailSheet(moimSchedule):
                state.isSheetPresented = true
                // TODO: 캡슐화 필요?
                state.moimEdit.moimScheduleId = moimSchedule.scheduleId
                state.moimEdit.title = moimSchedule.title
                state.moimEdit.startDate = moimSchedule.startDate
                state.moimEdit.endDate = moimSchedule.endDate
                state.moimEdit.latitude = moimSchedule.latitude
                state.moimEdit.longitude = moimSchedule.longitude
                state.moimEdit.kakaoLocationId = moimSchedule.kakaoLocationId
                state.moimEdit.participants = moimSchedule.participants
                state.moimEdit.locationName = moimSchedule.locationName
                state.moimEdit.imageUrl = moimSchedule.imageUrl
                state.moimEdit.isOwner = moimSchedule.isOwner
                state.moimEdit.mode =  moimSchedule.isOwner ? .edit : .view
                return .none
                // 모임일정 초기화
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
