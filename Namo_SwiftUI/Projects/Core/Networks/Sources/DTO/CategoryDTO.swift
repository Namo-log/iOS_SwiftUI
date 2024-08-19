//
//  CategoryDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Foundation
import Common

public typealias getCategoryResponse = [CategoryDTO]

public struct CategoryDTO: Decodable {
	public init(categoryId: Int, name: String, paletteId: Int, isShare: Bool) {
		self.categoryId = categoryId
		self.name = name
		self.paletteId = paletteId
		self.isShare = isShare
	}
	
	public let categoryId: Int
	public let name: String
	public let paletteId: Int
	public let isShare: Bool
}

public struct postCategoryRequest: Encodable {
	public init(name: String, paletteId: Int, isShare: Bool) {
		self.name = name
		self.paletteId = paletteId
		self.isShare = isShare
	}
	
	public let name: String
	public let paletteId: Int
	public let isShare: Bool
}

public struct postCategoryResponse: Decodable {
	public init(id: Int) {
		self.id = id
	}
	
	public let id: Int
}

public extension CategoryDTO {
    func toCategory() -> ScheduleCategory {
        return ScheduleCategory(
            categoryId: self.categoryId,
            name: self.name,
            paletteId: self.paletteId,
            isShare: self.isShare
        )
    }
}
