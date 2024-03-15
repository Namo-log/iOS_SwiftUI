//
//  EditSaveDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

// 기록 수정 완료 버튼 또는 기록 저장 버튼
struct EditSaveDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Button {
            print(appState.isEditingDiary ? "기록 수정" : "기록 저장")
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            ZStack() {
                Rectangle()
                    .fill(appState.isEditingDiary ? .white : .mainOrange)
                    .frame(height: 60 + 10) // 하단의 Safe Area 영역 칠한 거 높이 10으로 가정
                    .shadow(color: .black.opacity(0.25), radius: 7)
                
                Text(appState.isEditingDiary ? "기록 수정" : "기록 저장")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(appState.isEditingDiary ? .mainOrange : .white)
                    .padding(.bottom, 10) // Safe Area 칠한만큼
            }
        }
    }
}

#Preview {
    EditSaveDiaryView()
}
