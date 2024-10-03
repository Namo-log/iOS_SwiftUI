////
////  CategoryRepositoryImpl.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 2/11/24.
////
//
//import Alamofire
//
//import CoreNetwork
//
//final class CategoryRepositoryImpl: CategoryRepository {
//	func postCategory(data: postCategoryRequest) async -> postCategoryResponse? {
//		return await APIManager.shared.performRequestOld(endPoint: CategoryEndPoint.postCategory(data: data))
//	}
//	
//	func patchCategory(id: Int, data: postCategoryRequest) async -> postCategoryResponse? {
//		return await APIManager.shared.performRequestOld(endPoint: CategoryEndPoint.patchCategory(id: id, data: data))
//	}
//	
//	func getAllCategory() async -> getCategoryResponse? {
//		return await APIManager.shared.performRequestOld(endPoint: CategoryEndPoint.getAllCategory)
//	}
//	
//	func deleteCategory(id: Int) async -> String? {
//		return await APIManager.shared.performRequestOld(endPoint: CategoryEndPoint.deleteCategory(id: id))
//	}
//	
//	
//}
