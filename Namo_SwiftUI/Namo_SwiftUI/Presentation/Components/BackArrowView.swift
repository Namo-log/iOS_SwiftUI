//
//  BackArrowView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

// 네비게이션 왼쪽 아이템으로 쓰이는 주황색 뒤로가기 버튼
struct BackArrowView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(.icBack)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 14)
        }
        .disabled(appState.isDeletingDiary) // Alert 떴을 때 클릭 안 되게
    }
}

#Preview {
    BackArrowView()
}
