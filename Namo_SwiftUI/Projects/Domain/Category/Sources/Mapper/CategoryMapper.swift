//
//  CategoryMapper.swift
//  DomainCategory
//
//  Created by 정현우 on 10/5/24.
//

import Foundation

import CoreNetwork

// MARK: - toEntity()
extension CategoryDTO {
	func toEntity() -> NamoCategory {
		return NamoCategory(
			categoryId: categoryId,
			categoryName: categoryName,
			colorId: colorId,
			baseCategory: baseCategory,
			shared: shared
		)
	}
}

// MARK: - toData()
extension NamoCategory {
	func toData() -> CategoryDTO {
		return  CategoryDTO(
			categoryId: categoryId,
			categoryName: categoryName,
			colorId: colorId,
			baseCategory: baseCategory,
			shared: shared
		)
	}
}
