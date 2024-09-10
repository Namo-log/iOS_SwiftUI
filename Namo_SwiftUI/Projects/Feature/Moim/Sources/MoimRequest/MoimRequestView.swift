//
//  MoimRequestView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem

struct MoimRequestView: View {
    var body: some View {
        VStack {
            
        }
        .namoNabBar(center: {
            Text("새로운 요청")
                .font(.pretendard(.bold, size: 16))
                .foregroundStyle(.black)
        }, left: {
            Text("")
        })
    }
        
}

#Preview {
    MoimRequestView()
}
