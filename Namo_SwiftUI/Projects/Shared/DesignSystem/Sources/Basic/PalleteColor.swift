//
//  PalleteColor.swift
//  SharedDesignSystem
//
//  Created by 정현우 on 10/6/24.
//

import SwiftUI

public enum PalleteColor: Int, CaseIterable {
	case namoOrange = 1
	case namoPink = 2
	case namoYellow = 3
	case namoBlue = 4
	case colorLightGray = 5
	case colorRed = 6
	case colorPink = 7
	case colorOrange = 8
	case colorYellow = 9
	case colorLime = 10
	case colorLightGreen = 11
	case colorGreen = 12
	case colorCyan = 13
	case colorLightBlue = 14
	case colorBlue = 15
	case colorLavendar = 16
	case colorPurple = 17
	case colorMagenta = 18
	case colorDarkGray = 19
	case colorBlack = 20
	
	public var color: Color {
		switch self {
		case .namoOrange: return Color.namoOrange
		case .namoPink: return Color.namoPink
		case .namoYellow: return Color.namoYellow
		case .namoBlue: return Color.namoBlue
		case .colorLightGray: return Color.colorLightGray
		case .colorRed: return Color.colorRed
		case .colorPink: return Color.colorPink
		case .colorOrange: return Color.colorOrange
		case .colorYellow: return Color.colorYellow
		case .colorLime: return Color.colorLime
		case .colorLightGreen: return Color.colorLightGreen
		case .colorGreen: return Color.colorGreen
		case .colorCyan: return Color.colorCyan
		case .colorLightBlue: return Color.colorLightBlue
		case .colorBlue: return Color.colorBlue
		case .colorLavendar: return Color.colorLavendar
		case .colorPurple: return Color.colorPurple
		case .colorMagenta: return Color.colorMagenta
		case .colorDarkGray: return Color.colorDarkGray
		case .colorBlack: return Color.colorBlack
		}
	}
    
    public var name: String {
        switch self {
        case .namoOrange:
            return "Namo Orange"
        case .namoPink:
            return "Namo Pink"
        case .namoYellow:
            return "Namo Yellow"
        case .namoBlue:
            return "Namo Blue"
        case .colorLightGray:
            return "Light Gray"
        case .colorRed:
            return "Red"
        case .colorPink:
            return "Pink"
        case .colorOrange:
            return "Orange"
        case .colorYellow:
            return "Yellow"
        case .colorLime:
            return "Lime"
        case .colorLightGreen:
            return "Light Green"
        case .colorGreen:
            return "Green"
        case .colorCyan:
            return "Cyan"
        case .colorLightBlue:
            return "Light Blue"
        case .colorBlue:
            return "Blue"
        case .colorLavendar:
            return "Lavender"
        case .colorPurple:
            return "Purple"
        case .colorMagenta:
            return "Magenta"
        case .colorDarkGray:
            return "Dark Gray"
        case .colorBlack:
            return "Black"
        }
    }
}
