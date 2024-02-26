//
//  Category.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/19/24.
//

import Foundation
import SwiftUI

struct ScheduleCategory: Hashable {
    let categoryId: Int
    let name: String
    let paletteId: Int
    let isShare: Bool
    var color: Color?
    var isSelected: Bool?
}
