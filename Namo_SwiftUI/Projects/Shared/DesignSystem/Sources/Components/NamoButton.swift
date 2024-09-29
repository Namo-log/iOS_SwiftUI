//
//  NamoButton.swift
//  SharedDesignSystem
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI

/// App 전역에서 사용되는 커스텀 버튼 입니다.
public struct NamoButton: View {
    /// 버튼 라벨 텍스트
    var title: String
    /// 버튼 라벨 텍스트 폰트
    var font: Font
    /// 버튼 cornerRadii
    var cornerRadius: CGFloat
    /// 버튼 라벨 - 배경 간의 verticalPadding
    var verticalPadding: CGFloat
    /// Namo 버튼 타입
    var type: NamoButtonType
    /// 화면 밑에 붙는 직사각형 버튼인 경우 true
    var isBottomButton: Bool
    /// 버튼 액션
    var action: () -> Void
    
    public init(
        title: String,
        font: Font = .pretendard(.bold, size: 18),
        cornerRadius: CGFloat = 15,
        verticalPadding: CGFloat = 17,
        type: NamoButtonType,
        atBottom: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.font = font
        self.cornerRadius = cornerRadius
        self.verticalPadding = verticalPadding
        self.type = type
        self.isBottomButton = atBottom
        self.action = action
    }
    
    public var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .frame(maxWidth: .infinity, maxHeight: isBottomButton ? .infinity : nil)
                .padding(.vertical, verticalPadding)
                .foregroundColor(type.foregroundColor)
                .background(type.backgroundColor)
                .cornerRadius(cornerRadius)
        }
        .disabled(type.isDisabled)
    }
}

public extension NamoButton {
    /// NamoButton에 적용되는 Style
    enum NamoButtonType {
        /// 활성화된 상태 (Primary 버튼)
        case active
        /// 비활성화된 상태 (Disabled 버튼)
        case inactive
        /// 다음 버튼 (Secondary 또는 Outline 버튼)
        case next
        
        /// type의 foregroundColor
        var foregroundColor: Color {
            switch self {
            case .active, .inactive:
                return .white
            case .next:
                return .mainOrange
            }
        }
        
        /// type의 backgroundColor
        var backgroundColor: Color {
            switch self {
            case .active:
                return .mainOrange
            case .inactive:
                return .textUnselected
            case .next:
                return .mainGray
            }
        }
        
        /// 버튼 비활성화 여부
        var isDisabled: Bool {
            return self == .inactive
        }
    }
}
