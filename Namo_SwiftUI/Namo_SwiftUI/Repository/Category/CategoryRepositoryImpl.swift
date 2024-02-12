//
//  CategoryRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Alamofire

final class CategoryRepositoryImpl: CategoryRepository {
	func postCategory(data: postCategoryRequest) async -> postCategoryResponse? {
		return await APIManager.shared.performRequest(endPoint: CategoryEndPoint.postCategory(data: data))
	}
	
	func patchCategory(id: Int, data: postCategoryRequest) async -> postCategoryResponse? {
		return await APIManager.shared.performRequest(endPoint: CategoryEndPoint.patchCategory(id: id, data: data))
	}
	
	func getAllCategory() async -> getCategoryResponse? {
		return await APIManager.shared.performRequest(endPoint: CategoryEndPoint.getAllCategory)
	}
	
	func deleteCategory(id: Int) async -> String? {
		return await APIManager.shared.performRequest(endPoint: CategoryEndPoint.deleteCategory(id: id))
	}
	
	
}
