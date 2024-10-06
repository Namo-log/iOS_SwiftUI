//
//  ColorCircleView.swift
//  SharedDesignSystem
//
//  Created by 정현우 on 10/5/24.
//

import SwiftUI

public struct ColorCircleView: View {
	let color: Color
	let isChecked: Bool
	
	public init(color: Color, isChecked: Bool = false) {
		self.color = color
		self.isChecked = isChecked
	}

	public var body: some View {
		ZStack {
			Circle()
				.fill(color)
			
			Image(asset: SharedDesignSystemAsset.Assets.icCheckmark)
				.resizable()
				.scaledToFit()
				.scaleEffect(CGSize(width: 0.5, height: 0.5))

		}
	}
}