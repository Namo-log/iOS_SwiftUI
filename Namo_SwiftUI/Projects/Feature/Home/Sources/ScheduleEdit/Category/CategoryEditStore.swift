//
//  CategoryEditStore.swift
//  FeatureHome
//
//  Created by 정현우 on 10/5/24.
//

import ComposableArchitecture

import DomainCategory
import SharedUtil

@Reducer
public struct CategoryEditStore {
	public init() {}
	
	@ObservableState
	public struct State: Equatable {
		// 카테고리 생성인지 편집인지
		var isNewCategory: Bool
		// 생성/편집 하는 카테고리
		var category: NamoCategory
		// 카테고리 리스트
		@Shared(.inMemory(SharedKeys.categories.rawValue)) var categories: [NamoCategory] = []
	}
	
	public enum Action {
		case backBtnTapped
		case saveBtnTapped
	}
	
	public var body: some ReducerOf<Self> {
		Reduce { state, action in
			switch action {
			case .backBtnTapped:
				return .none
				
			case .saveBtnTapped:
				
				return .run { send in
					// 생성 수정 api 성공 시 shared를 api 통해서 업데이트 후 뒤로 가기
					// api 사용하는 이유는 categoryId를 몰라서
				}
			}
		}
	}
	
}
