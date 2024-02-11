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
			categories?.forEach {
				print($0.categoryId, $0.name, $0.paletteId)
				appState.categoryPalette[$0.categoryId] = $0.paletteId
			}
		}
	}
	
	// 기본 팔레트ID로 Color 가져오기
	func getColorWithPaletteId(id: Int) -> Color {
		switch id {
		case 1:
			return Color(hex: "#EB5353")
		case 2:
			return Color(hex: "#ЕС9В3В")
		case 3:
			return Color(hex: "#FBCBOA")
		case 4:
			return Color(hex: "#96BB7C")
		case 5:
			return Color(hex: "#5A8F7B")
		case 6:
			return Color(hex: "#82C4C3")
		case 7:
			return Color(hex: "#187498")
		case 8:
			return Color(hex: "#8571BF")
		case 9:
			return Color(hex: "#E36488")
		case 10:
			return Color(hex: "#858585")
		default:
			print("getColorWithPaletteId - unknown id")
			return Color.clear
		}
	}
}

