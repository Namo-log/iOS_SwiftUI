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
}
