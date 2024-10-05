//
//  CategoryListStore.swift
//  FeatureHome
//
//  Created by 정현우 on 10/5/24.
//

import ComposableArchitecture

import DomainSchedule
import DomainCategory
import SharedUtil

@Reducer
public struct CategoryListStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 수정/생성중인 스케쥴
		@Shared var schedule: ScheduleEdit
		// 카테고리 리스트
		@Shared(.inMemory(SharedKeys.categories.rawValue)) var categories: [NamoCategory] = []
	}
	
	public enum Action {
		case backBtnTapped
		case categorySelect(NamoCategory)
		case editCategoryTapped(NamoCategory)
		case newCategoryTapped
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .backBtnTapped:
				return .none
				
			case .categorySelect(let category):
				let sCategory = ScheduleCategory(categoryId: category.colorId, colorId: category.colorId, name: category.categoryName, isShared: category.shared)
				
				state.schedule.category = sCategory
				
				return .none
				
			case .editCategoryTapped:
				return .none
				
			case .newCategoryTapped:
				return .none
			}
		}
	}
}
