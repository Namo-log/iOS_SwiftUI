//
//  DismissButton.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import Factory
import SharedDesignSystem

// 네비게이션 왼쪽 아이템으로 쓰이는 주황색 뒤로가기 버튼
struct DismissButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var scheduleState: ScheduleState
//	let scheduleUseCase = ScheduleUseCase.shared
    @Binding var isDeletingDiary: Bool
    @Binding var isChangedContents: Bool
    @Binding var showIsChangedAlert: Bool
    
    var body: some View {
        Button{
            
            
            if isChangedContents {
                
                showIsChangedAlert = true
                
            } else {
                self.presentationMode.wrappedValue.dismiss()
    //            scheduleState.currentSchedule =
//                scheduleUseCase.setScheduleToCurrentSchedule(schedule: nil)
//                scheduleUseCase.setScheduleToCurrentMoimSchedule(schedule: nil, users: nil)
            }
            
        } label: {
            Image(asset: SharedDesignSystemAsset.Assets.icBack)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 14)
        }
        .disabled(isDeletingDiary) // Alert 떴을 때 클릭 안 되게
    }
}
