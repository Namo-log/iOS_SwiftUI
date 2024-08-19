//
//  BlackBorderRoundedView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import Common

// 1px 검은색 보더 있는 라운드 뷰
struct BlackBorderRoundedView: View {
    var text: String
    var image: Image
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
                .foregroundStyle(.white)
                .frame(width: width, height: height)
            HStack() {
                image
                    .resizable()
                    .frame(width: 18, height: 18)
                Text(text)
                    .foregroundStyle(.black)
                    .font(.pretendard(.light, size: 15))
            }
        }
    }
}

#Preview {
    BlackBorderRoundedView(text: "모임 기록 보러가기", image: Image(asset: CommonAsset.Assets.icDiary), width: 192, height: 40)
}
