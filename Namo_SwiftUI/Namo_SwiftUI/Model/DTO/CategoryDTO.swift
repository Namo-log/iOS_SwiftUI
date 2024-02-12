//
//  CategoryDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Foundation

typealias getCategoryResponse = [CategoryDTO]

struct CategoryDTO: Decodable {
	let categoryId: Int
	let name: String
	let paletteId: Int
	let isShare: Bool
}

struct postCategoryRequest: Encodable {
	let name: String
	let paletteId: Int
	let isShare: Bool
}

struct postCategoryResponse: Decodable {
	let id: Int
}
