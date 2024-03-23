//
//  CategoryInteractor.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/11/24.
//

import SwiftUI

protocol CategoryInteractor {
	func getCategories() async
	func getColorWithPaletteId(id: Int) -> Color
    func addCategory(data: postCategoryRequest) async
    func editCategory(id: Int, data: postCategoryRequest) async
    func removeCategory(id: Int) async 
    func showCategoryDoneToast()
    func setCategories() -> [ScheduleCategory]
}
