//
//  ScheduleEditCoordinator.swift
//  FeatureHome
//
//  Created by 정현우 on 10/3/24.
//

import ComposableArchitecture
import TCACoordinators

import DomainSchedule
import DomainCategory

@Reducer(state: .equatable)
public enum ScheduleEditScreen {
	case scheduleEdit(ScheduleEditStore)
	case categoryList(CategoryListStore)
	case categoryEdit(CategoryEditStore)
	case reminderSetting(ReminderSettingStore)
}

@Reducer
public struct ScheduleEditCoordinator {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		var routes: [Route<ScheduleEditScreen.State>]
		
		// 하위 뷰에서 사용할 현재 편집 중인 스케쥴
		@Shared var schedule: ScheduleEdit
			
		public init(
			isNewSchedule: Bool,
			schedule: ScheduleEdit
		) {
			self.routes = []
			self._schedule = Shared(schedule)
			
			// scheduleEdit에 자신의 Shared 객체를 넘겨줌
			self.routes = [
				.root(
					.scheduleEdit(
						.init(
							isNewSchedule: isNewSchedule,
							schedule: $schedule
						)
					),
					embedInNavigationView: true
				)
			]
		}

	}
	
	public enum Action {
		case router(IndexedRouterActionOf<ScheduleEditScreen>)
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
				
			case .router(.routeAction(_, action: .scheduleEdit(.selectCategoryTapped))):
				// 스케쥴 생성/편집에서 카테고리 리스트 push
				state.routes.push(.categoryList(.init(schedule: state.$schedule)))
				return .none
				
			case .router(.routeAction(_, action: .categoryList(.backBtnTapped))):
				// 카테고리 리스트 pop
				state.routes.pop()
				return .none
				
			case .router(.routeAction(_, action: .categoryList(.newCategoryTapped))):
				// 카테고리 리스트에서 카테고리 생성 push
				state.routes.push(
					.categoryEdit(
						.init(
							isNewCategory: true,
							category: NamoCategory(categoryId: -1, categoryName: "", colorId: -1, baseCategory: false, shared: false)
						)
					)
				)
				return .none
				
			case .router(.routeAction(_, action: .categoryList(.editCategoryTapped(let category)))):
				// 카테고리 리스트에서 카테고리 편집 push
				state.routes.push(
					.categoryEdit(
						.init(
							isNewCategory: false,
							category: category
						)
					)
				)
				return .none
				
			case .router(.routeAction(_, action: .categoryEdit(.backBtnTapped))):
				// 카테고리 생성/편집 뒤로가기
				state.routes.pop()
				return .none
				
			case .router(.routeAction(_, action: .scheduleEdit(.reminderBtnTapped))):
				// 일정 생성/편집에서 알림 push
				state.routes.push(.reminderSetting(.init(schedule: state.$schedule)))
				return .none
				
			case .router(.routeAction(_, action: .reminderSetting(.backBtnTapped))):
				// 알림 pop
				state.routes.pop()
				return .none
				
			case .router(.routeAction(_, action: .reminderSetting(.saveReminderBtnTapped))):
				// 알림 pop
				state.routes.pop()
				return .none
				
			default:
				return .none
			}
		}
		.forEachRoute(\.routes, action: \.router)
		
	}
}

