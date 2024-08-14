//
//  Constants.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/19/24.
//

import UIKit

let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
let screenWidth = windowScene?.screen.bounds.width ?? 0
let screenHeight = windowScene?.screen.bounds.height ?? 0

let window = UIApplication
	.shared
	.connectedScenes
	.flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
	.first { $0.isKeyWindow }
let topSafeAreaPadding = window?.safeAreaInsets.top ?? 0

let tabBarHeight: CGFloat = 80

// 캘린더에 표시되는 최대 하루 일정 개수 - 800미만(홈버튼 아이폰)이면 2개씩만 표시
//let MAX_SCHEDULE = screenHeight < 800 ? 3 : 4
//let MAX_SCHEDULE = 3

let version = Bundle.main.infoDictionary? ["CFBundleShortVersionString"] as! String
let bundleVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String

