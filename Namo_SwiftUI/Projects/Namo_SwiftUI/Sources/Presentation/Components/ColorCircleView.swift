//
//  CheckCircle.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/24/24.
//

import SwiftUI
import Common

enum ColorCirclePresentMode {
    /// 현재 선택 가능한 상태
    case available
    /// 현재 선택된 상태
    case selected
    /// 현재 선택 불가능한 상태
    case unAvailable
    /// 체크마크 넣은 상태
    case checked
}

struct ColorCircleView: View {
    
    /// Cilrcle의 지정색입니다.
    var color: Color?
    /// Circle의 현재 상태입니다.
    var selectState: ColorCirclePresentMode?
    
    var body: some View {
        
        ZStack {
            
            Circle()
				.fill(color ?? Color(asset: CommonAsset.Assets.mainText))
                .aspectRatio(1.0, contentMode: .fit)
            
            if (selectState == .unAvailable || selectState == .selected) {
                Circle()
                    .fill(.white)
                    .aspectRatio(0.7, contentMode: .fit)
            }
            
            if (selectState == .selected) {
                Circle()
                    .fill(color ?? Color(asset: CommonAsset.Assets.mainText))
                    .aspectRatio(0.55, contentMode: .fit)
            }
            
            if (selectState == .checked) {
                Image("checkMark")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(CGSize(width: 0.5, height: 0.5))
            }
        }
        
    }
}

#Preview {
    ColorCircleView(color: .cyan, selectState: .checked)
}
