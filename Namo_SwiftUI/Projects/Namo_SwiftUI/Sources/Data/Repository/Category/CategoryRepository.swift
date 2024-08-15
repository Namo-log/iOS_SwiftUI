//
//  CategoryRepository.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

protocol CategoryRepository {
	func postCategory(data: postCategoryRequest) async -> postCategoryResponse?
	func patchCategory(id: Int, data: postCategoryRequest) async -> postCategoryResponse?
	func getAllCategory() async -> getCategoryResponse?
	func deleteCategory(id: Int) async -> String?
}
