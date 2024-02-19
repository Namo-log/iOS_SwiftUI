//
//  CategoryInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Factory
import SwiftUI

struct CategoryInteractorImpl: CategoryInteractor {
	
	@Injected(\.categoryRepository) private var categoryRepository
	@Injected(\.appState) private var appState
	
	func getCategories() async {
		let categories = await categoryRepository.getAllCategory()
		
		DispatchQueue.main.async {
            appState.categoryState.categoryList = categories?.map { return $0.toCategory() } ?? [] // 받아온 Categories categoryState의 categoryList에 저장
			categories?.forEach {
				appState.categoryPalette[$0.categoryId] = $0.paletteId
			}
		}
	}
	
	// 기본 팔레트ID로 Color 가져오기
	func getColorWithPaletteId(id: Int) -> Color {
		switch id {
		case 1:
			return Color(hex: 0xEB5353)
		case 2:
			return Color(hex: 0xEC9B3B)
		case 3:
			return Color(hex: 0xFBCB0A)
		case 4:
			return Color(hex: 0x96BB7C)
		case 5:
			return Color(hex: 0x5A8F7B)
		case 6:
			return Color(hex: 0x82C4C3)
		case 7:
			return Color(hex: 0x187498)
		case 8:
			return Color(hex: 0x8571BF)
		case 9:
			return Color(hex: 0xE36488)
		case 10:
			return Color(hex: 0x858585)
		default:
			return Color.clear
		}
	}
}

