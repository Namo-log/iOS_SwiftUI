//
//  RoundedCorners.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/29/24.
//

import SwiftUI

// ex) .clipShape(RoundedCorners(radius: 3, corners: [.topLeft, .bottoLeft])
struct RoundedCorners: Shape {
	var radius: CGFloat = .infinity
	var corners: UIRectCorner = .allCorners
	
	func path(in rect: CGRect) -> Path {
		let path = UIBezierPath(roundedRect: rect,
								byRoundingCorners: corners,
								cornerRadii: CGSize(width: radius, height: radius))
		return Path(path.cgPath)
	}
}
