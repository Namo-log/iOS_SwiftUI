//
//  DatePlaceInfoView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

import Factory
import Common

// 날짜와 장소 정보 뷰
struct DatePlaceInfoView: View {
    let diaryUseCase = DiaryUseCase.shared
    
    var date: Date
    var place: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                Circle()
                    .fill(.white)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 7)
                
                VStack(alignment: .center, spacing: 0) {
                    Text(diaryUseCase.getMonthEngString(date: date) ?? "")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
                    Text(date.toDD())
                        .font(.pretendard(.bold, size: 36))
                        .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("날짜")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
                Text("장소")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
            }
            .padding(.leading, 25)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(date.toYMDEHM())
                    .font(.pretendard(.light, size: 15))
                    .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
                Text(place)
                    .font(.pretendard(.light, size: 15))
                    .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
            }
            .padding(.leading, 12)
        } // HStack
    }
}
