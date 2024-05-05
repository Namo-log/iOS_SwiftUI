//
//  GroupListItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

import SwiftUI
import Kingfisher

struct GroupListItem: View {
	let moim: Moim
	
	var body: some View {
		HStack(spacing: 15) {
			KFImage(URL(string: moim.groupImgUrl ?? ""))
				.resizable()
				.aspectRatio(contentMode: .fill)
				.frame(width: 45, height: 45)
				.clipShape(Circle())
			
			VStack(alignment: .leading, spacing: 10) {
				Text("\(moim.groupName ?? "")")
					.font(.pretendard(.bold, size: 15))
				
				HStack(spacing: 10) {
					Text("\(moim.groupUsers.count)")
						.font(.pretendard(.bold, size: 12))
					
					Text("\(moim.groupUsers.map({$0.userName}).joined(separator: ", "))")
						.font(.pretendard(.regular, size: 12))
				}
			}
			
			Spacer(minLength: 100)
		}
		.padding(.horizontal, 15)
		.frame(width: screenWidth-50, height: 70)
		.background(Color(.textBackground))
		.clipShape(RoundedRectangle(cornerRadius: 10))
		.shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
	}
}
