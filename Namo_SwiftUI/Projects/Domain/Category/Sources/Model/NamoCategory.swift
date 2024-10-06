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
	
	public var categoryId: Int
	public var categoryName: String
	public var colorId: Int
	public var baseCategory: Bool
	public var shared: Bool
}



