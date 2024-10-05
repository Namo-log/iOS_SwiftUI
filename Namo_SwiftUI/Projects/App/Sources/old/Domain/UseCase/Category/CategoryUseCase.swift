//
//  CategoryUseCase.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import Factory
import SwiftUI

import SharedUtil
import CoreNetwork

final class CategoryUseCase {
	static let shared = CategoryUseCase()
	@Injected(\.categoryRepository) private var categoryRepository
    @Injected(\.scheduleState) private var scheduleState
	
    /// 카테고리 호출 API 및 AppState에 저장
	func getCategories() async {
		let categories = await categoryRepository.getAllCategory()
		
//		DispatchQueue.main.async {
//			AppState.shared.categoryState.categoryList = categories?.map { return $0.toCategory() } ?? [] // 받아온 Categories categoryState의 categoryList에 저장
//			categories?.forEach {
//				AppState.shared.categoryPalette[$0.categoryId] = $0.paletteId
//			}
//		}
	}
    
    /// AppState의 카테고리 리스트를 뷰에서 쓰일 형태로 변환
    func setCategories() -> [ScheduleCategory] {
        
		let categoryList = AppState.shared.categoryState.categoryList.map { category in
            
            return ScheduleCategory(categoryId: category.categoryId, name: category.name, paletteId: category.paletteId, isShare: category.isShare, color: self.getColorWithPaletteId(id: category.paletteId), isSelected: self.scheduleState.currentSchedule.categoryId == category.categoryId ? true : false)
        }
        return categoryList
    }
    
    // 카테고리 생성
    func addCategory(data: postCategoryRequest) async -> Bool {
        
//        if let result = await categoryRepository.postCategory(data: data)?.id {
//            
//            return true
//            
//        } else {
//            
//            ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "네트워크 오류", message: "일시적인 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "카테고리 생성 실패"))
//            
//            return false
//        }
		return false
    }
    
    // 카테고리 수정
    func editCategory(id: Int, data: postCategoryRequest) async -> Bool {
        
//        if let result = await categoryRepository.patchCategory(id: id, data: data)?.id {
//            
//            return true
//        } else {
//            
//            ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "네트워크 오류", message: "일시적인 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "카테고리 수정 실패"))
//            
//            return false
//        }
		return false
    }
    
    // 카테고리 삭제
    func removeCategory(id: Int) async -> Bool {
        
        if let result = await categoryRepository.deleteCategory(id: id) {
            
            return true
        } else {
            
            ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "네트워크 오류", message: "일시적인 오류가 발생했습니다. \n잠시 후 다시 시도해주세요.", localizedDescription: "카테고리 삭제 실패"))
            
            return false
        }
    }
    
    // 카테고리 편집 토스트 메시지 조작
    func showCategoryDoneToast() {
        
		if AppState.shared.showCategoryDeleteDoneToast {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                withAnimation {
					AppState.shared.showCategoryDeleteDoneToast = false
                }
            }
        }
        
		if AppState.shared.showCategoryEditDoneToast {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                
                withAnimation {
					AppState.shared.showCategoryEditDoneToast = false
                }
            }
        }
    }
	
	// 기본 팔레트ID로 Color 가져오기
    // 기존 10개에서 14개로 팔레트ID 추가
    func getColorWithPaletteId(id: Int) -> Color {
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

