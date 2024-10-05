//
//  CategoryUseCase.swift
//  DomainCategory
//
//  Created by 정현우 on 9/19/24.
//

import SwiftUI

import ComposableArchitecture

import SharedUtil
import CoreNetwork

@DependencyClient
public struct CategoryUseCase {
	public func getAllCategory() async -> [NamoCategory] {
		let response: BaseResponse<[CategoryDTO]>? = await APIManager.shared.performRequest(endPoint: CategoryEndPoint.getAllCategory)
		
		return response?.result?.map({$0.toEntity()}) ?? []
	}
}

extension CategoryUseCase: DependencyKey {
	public static var liveValue: CategoryUseCase {
		return CategoryUseCase()
	}
}

extension DependencyValues {
	public var categoryUseCase: CategoryUseCase {
		get { self[CategoryUseCase.self] }
		set { self[CategoryUseCase.self] = newValue }
	}
}
