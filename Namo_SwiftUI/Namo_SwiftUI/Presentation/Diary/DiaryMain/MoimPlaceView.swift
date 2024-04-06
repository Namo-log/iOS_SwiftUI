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
    @State private var dragOffset: CGSize = .zero
    @State private var isAddingViewVisible = false
    @Binding var numOfPlace: Int
    @Binding var showCalculateAlert: Bool

    var placeNumber: Int = 1
    
    var body: some View {
        HStack(spacing: 0) {
            
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
                            self.showCalculateAlert = true
                        }
                    }
                }
                .onTapGesture {
                    
                }
                .padding(.top, 20)
                
                // 사진 선택 리스트
                PhotoPickerListView()
            }
            .padding(.bottom, 25)
            .offset(x: dragOffset.width, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if !isAddingViewVisible {
                            if value.translation.width > -20 && value.translation.width < 0 {
                                self.dragOffset = value.translation
                                withAnimation {
                                    isAddingViewVisible = true
                                }
                            }
                        } else {
                            if value.translation.width < 20 && value.translation.width > 0 {
                                self.dragOffset = .zero
                                withAnimation {
                                    isAddingViewVisible = false
                                }
                            }
                        }
                    }
            ) // gesture
            
            if isAddingViewVisible {
                Button {
                    self.numOfPlace -= 1
                    self.dragOffset = .zero
                } label: {
                    Rectangle()
                        .fill(Color(.mainOrange))
                        .frame(width: 65, height: 136)
                        .overlay {
                            Image(.icTrashWhite)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                }
            }
        }
    }
}
