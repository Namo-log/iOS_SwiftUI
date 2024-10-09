//
//  ReminderSettingStore.swift
//  FeatureHome
//
//  Created by 정현우 on 10/6/24.
//

import ComposableArchitecture

import DomainSchedule

@Reducer
public struct ReminderSettingStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 수정/생성중인 스케쥴
		@Shared var schedule: ScheduleEdit
		// 알림 시간 목록
		var timeList: [String] = []
		// 선택한 알림 시간 목록
		var selectedTimeList: [String] = []
		// 직접 추가하기 보이게
		var showAddReminder: Bool = false
		// picker에 보여질 숫자 목록
		var pickerTimeList: [Int] = Array(1...100)
		// picker의 숫자
		var selectedTime: Int = 1
		// picker의 단위
		var selectedUnit: String = "분"
		
		public init(
			schedule: Shared<ScheduleEdit>
		) {
			self._schedule = schedule
			self.timeList = ["정시", "5분 전", "10분 전", "30분 전", "1시간 전"]
			
			self.schedule.reminderTrigger?.forEach {
				if !timeList.contains($0) {
					timeList.append($0)
				}
			}
			self.selectedTimeList = self.schedule.reminderTrigger ?? []
		}
	}
	
	public enum Action: BindableAction {
		case binding(BindingAction<State>)
		
		// 없음
		case noReminderTapped
		// 시간 tap
		case timeReminderTapped(String)
		// 직접 추가하기 toggle
		case toggleAddReminder
		// 추가하기 단위 변경 시
		case timeUnitChanged
		// 추가하기 누른 경우
		case addReminder
		// 추가한 알림 제거
		case removeReminder(String)
		// 뒤로가기
		case backBtnTapped
		// 저장
		case saveReminderBtnTapped
	}
	
	public var body: some ReducerOf<Self> {
		BindingReducer()
		
		Reduce { state, action in
			switch action {
			case .binding(let bindingAction):
				switch bindingAction.keyPath {
				case \State.selectedUnit:
					
					return .send(.timeUnitChanged)
					
				default:
					return .none
				}
				
			case .noReminderTapped:
				state.selectedTimeList.removeAll()
				return .none
				
			case .timeReminderTapped(let time):
				print(state.selectedTimeList)
				if !state.selectedTimeList.contains(time) {
					state.selectedTimeList.append(time)
				}
				return .none
				
			case .toggleAddReminder:
				state.showAddReminder.toggle()
				return .none
				
			case .timeUnitChanged:
				switch state.selectedUnit {
				case "분":
					state.pickerTimeList = Array(1...100)
				case "시간":
					state.pickerTimeList = Array(1...36)
					if state.selectedTime > 36 {
						state.selectedTime = 36
					}
				case "일":
					state.pickerTimeList = Array(1...7)
					if state.selectedTime > 7 {
						state.selectedTime = 7
					}
					
				default:
					break
				}
				return .none
				
			case .addReminder:
				let time = "\(state.selectedTime)\(state.selectedUnit) 전"
				if !state.timeList.contains(time) {
					state.timeList.append(time)
					state.selectedTimeList.append(time)
				}
				return .none
				
			case .removeReminder(let time):
				state.timeList.removeAll(where: {$0 == time})
				state.selectedTimeList.removeAll(where: {$0 == time})
				
				return .none
				
			case .backBtnTapped:
				return .none
				
			case .saveReminderBtnTapped:
				state.schedule.reminderTrigger = state.selectedTimeList
				return .none
			}
		}
	}
	
}
