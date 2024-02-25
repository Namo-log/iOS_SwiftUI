//
//  ToDoCategory.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/25/24.
//

import SwiftUI

/// 일정에서 사용되는 카테고리 모델입니다.
struct ToDoCategory: Hashable {
    /// 카테고리 ID
    var categoryId: Int
    /// 카테고리 명
    var name: String
    /// 카테고리 색
    var color: Color
    /// 해당 카테고리가 선택되었는지 여부
    var isSelected: Bool
}
