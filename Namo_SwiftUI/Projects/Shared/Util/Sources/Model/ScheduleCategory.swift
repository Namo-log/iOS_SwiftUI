//
//  Category.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/19/24.
//

import Foundation
import SwiftUI

public struct ScheduleCategory: Hashable {
	public init(categoryId: Int, name: String, paletteId: Int, isShare: Bool, color: Color? = nil, isSelected: Bool? = nil) {
		self.categoryId = categoryId
		self.name = name
		self.paletteId = paletteId
		self.isShare = isShare
		self.color = color
		self.isSelected = isSelected
	}
	
	public var categoryId: Int
	public var name: String
	public var paletteId: Int
	public var isShare: Bool
	public var color: Color?
	public var isSelected: Bool?
}
