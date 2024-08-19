//
//  TrashView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import Common

// 네비게이션 오른쪽 아이템으로 쓰이는 기록 삭제 쓰레기 버튼
struct TrashView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        Button{
            appState.isDeletingDiary = true
        } label: {
			Image(asset: CommonAsset.Assets.icTrash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
        }
        .disabled(appState.isDeletingDiary) // Alert 떴을 때 클릭 안 되게
    }
}

#Preview {
    TrashView()
}
