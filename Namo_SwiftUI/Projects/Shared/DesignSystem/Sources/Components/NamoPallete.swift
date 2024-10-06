//
//  NamoPallete.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI

public struct NamoPallete: View {
	
	@Binding var selectedColor: PalleteColor?
	let itemName: String
	
	var columns: [GridItem] {
		let columnCount = 5
		return Array(repeating: GridItem(.flexible(minimum: 20)), count: columnCount)
	}
	
	public init(
		selectedColor: Binding<PalleteColor?>,
		itemName: String
	) {
		self._selectedColor = selectedColor
		self.itemName = itemName
	}
	
	
	public var body: some View {
		HStack(alignment: .top) {
			VStack {
				Text(itemName)
					.font(.pretendard(.bold, size: 15))
					.foregroundColor(.mainText)
//				Spacer()
			}
			
			Spacer()
			
			LazyVGrid(columns: columns, alignment: .trailing, spacing: 16) {
				ForEach(PalleteColor.allCases, id: \.self) { palleteColor in
					Circle()
						.fill(palleteColor.color)
						.frame(width: 24, height: 24)
						.overlay {
							if palleteColor == self.selectedColor {
								Image(asset: SharedDesignSystemAsset.Assets.icCheckmark)
									.frame(width: 24, height: 24)
							}
						}
						.onTapGesture {
							selectedColor = palleteColor
						}
				}
			}
		}
	}
}
