//
//  Font+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/20/24.
//

import SwiftUI

public extension Font {
	enum Pretendard {
		case thin
		case extraLight
		case light
		case regular
		case medium
		case semibold
		case bold
		case extrabold
		case black
		
//		public var name: String {
//			switch self {
//			case .thin:
//				return "Pretendard-Thin"
//			case .extraLight:
//				return "Pretendard-ExtraLight"
//			case .light:
//				return "Pretendard-Light"
//			case .regular:
//				return "Pretendard-Regular"
//			case .medium:
//				return "Pretendard-Medium"
//			case .semibold:
//				return "Pretendard-SemiBold"
//			case .bold:
//				return "Pretendard-Bold"
//			case .extrabold:
//				return "Pretendard-ExtraBold"
//			case .black:
//				return "Pretendard-Black"
//			}
//		}
		
		var font: CommonFontConvertible {
			switch self {
			case .thin:
				return CommonFontFamily.Pretendard.thin
			case .extraLight:
				return CommonFontFamily.Pretendard.extraLight
			case .light:
				return CommonFontFamily.Pretendard.light
			case .regular:
				return CommonFontFamily.Pretendard.regular
			case .medium:
				return CommonFontFamily.Pretendard.medium
			case .semibold:
				return CommonFontFamily.Pretendard.semiBold
			case .bold:
				return CommonFontFamily.Pretendard.bold
			case .extrabold:
				return CommonFontFamily.Pretendard.extraBold
			case .black:
				return CommonFontFamily.Pretendard.black
			}
		}
	}
	
	static func pretendard(_ weight: Pretendard, size: CGFloat) -> Font {
		return weight.font.swiftUIFont(size: size)
//		return .custom(weight.name, size: size)
	}
}
