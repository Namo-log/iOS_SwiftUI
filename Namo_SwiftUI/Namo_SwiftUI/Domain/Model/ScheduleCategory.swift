//
//  Category.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/19/24.
//

import Foundation
import SwiftUI

struct ScheduleCategory: Hashable {
    var categoryId: Int
    var name: String
    var paletteId: Int
    var isShare: Bool
    var color: Color?
    var isSelected: Bool?
}
