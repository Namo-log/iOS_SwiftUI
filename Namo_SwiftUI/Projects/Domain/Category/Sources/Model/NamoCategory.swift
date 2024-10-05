//
//  NamoCategory.swift
//  DomainCategory
//
//  Created by 정현우 on 10/5/24.
//

import Foundation

public struct NamoCategory: Encodable, Equatable {
	public init(
		categoryId: Int,
		categoryName: String,
		colorId: Int,
		baseCategory: Bool,
		shared: Bool
	) {
		self.categoryId = categoryId
		self.categoryName = categoryName
		self.colorId = colorId
		self.baseCategory = baseCategory
		self.shared = shared
	}
	
	public let categoryId: Int
	public let categoryName: String
	public let colorId: Int
	public let baseCategory: Bool
	public let shared: Bool
}



