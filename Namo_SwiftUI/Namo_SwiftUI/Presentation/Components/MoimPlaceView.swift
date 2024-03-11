//
//  MoimPlaceView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

// 모임 기록에서 장소 뷰
struct MoimPlaceView: View {
    @EnvironmentObject var appState: AppState

    var placeNumber: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            // 장소 레이블
            HStack(alignment: .top, spacing: 0) {
                Text("장소 \(placeNumber)")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(.textPlaceholder)
                Spacer()
                HStack() {
                    Text("총 0원")
                        .font(.pretendard(.light, size: 15))
                        .foregroundStyle(.mainText)
                    Image(.rightChevronLight)
                }
                .onTapGesture {
                    withAnimation {
                        appState.showCalculateAlert = true
                    }
                }
            }
            .onTapGesture {
                
            }
            .padding(.top, 20)
            
            // 사진 선택 리스트
            PhotoPickerListView()
        }
    }
}

#Preview {
    MoimPlaceView()
}
