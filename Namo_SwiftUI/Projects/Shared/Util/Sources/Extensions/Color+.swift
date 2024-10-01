//
//  Color+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/23/24.
//

import SwiftUI

public extension Color {
	init(hex: UInt) {
		self.init(
			.sRGB,
			red: Double((hex >> 16) & 0xff) / 255,
			green: Double((hex >> 08) & 0xff) / 255,
			blue: Double((hex >> 00) & 0xff) / 255
		)
	}
	
	static func paletteColor(id: Int) -> Color {
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

