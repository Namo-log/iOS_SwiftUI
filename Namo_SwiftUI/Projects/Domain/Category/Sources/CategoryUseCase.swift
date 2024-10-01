//
//  CategoryUseCase.swift
//  DomainCategory
//
//  Created by 정현우 on 9/19/24.
//

import SwiftUI

import ComposableArchitecture

import SharedUtil

@DependencyClient
struct CategoryUseCase {
	func getColorWithColorId(id: Int) -> Color {
		switch id {
		case 1:
			return Color(hex: 0xDE8989)
		case 2:
			return Color(hex: 0xE1B000)
		case 3:
			return Color(hex: 0x5C8596)
		case 4:
			return Color(hex: 0xDA6022)
		case 5:
			return Color(hex: 0xEB5353)
		case 6:
			return Color(hex: 0xEC9B3B)
		case 7:
			return Color(hex: 0xFBCB0A)
		case 8:
			return Color(hex: 0x96BB7C)
		case 9:
			return Color(hex: 0x5A8F7B)
		case 10:
			return Color(hex: 0x82C4C3)
		case 11:
			return Color(hex: 0x187498)
		case 12:
			return Color(hex: 0x8571BF)
		case 13:
			return Color(hex: 0xE36488)
		case 14:
			return Color(hex: 0x858585)
		default:
			return Color.clear
		}
	}
	
}

extension CategoryUseCase: DependencyKey {
	static var liveValue: CategoryUseCase {
		return CategoryUseCase()
	}
}

extension DependencyValues {
	var categoryUseCase: CategoryUseCase {
		get { self[CategoryUseCase.self] }
		set { self[CategoryUseCase.self] = newValue }
	}
}
