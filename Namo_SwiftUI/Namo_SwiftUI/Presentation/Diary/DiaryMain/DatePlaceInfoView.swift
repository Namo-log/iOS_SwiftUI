//
//  DatePlaceInfoView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

// 날짜와 장소 정보 뷰
struct DatePlaceInfoView: View {
    var date: String
    var place: String
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            ZStack(alignment: .center) {
                Circle()
                    .fill(.white)
                    .frame(width: 80, height: 80)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 7)
                
                VStack(alignment: .center, spacing: 0) {
                    Text("JUNE")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
                    Text("28")
                        .font(.pretendard(.bold, size: 36))
                        .foregroundStyle(.mainText)
                }
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("날짜")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(.mainText)
                Text("장소")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(.mainText)
            }
            .padding(.leading, 25)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(date)
                    .font(.pretendard(.light, size: 15))
                    .foregroundStyle(.mainText)
                Text(place)
                    .font(.pretendard(.light, size: 15))
                    .foregroundStyle(.mainText)
            }
            .padding(.leading, 12)
        } // HStack
    }
}

#Preview {
    DatePlaceInfoView(date: "2023.03.05 (화)", place: "비전타워")
}
