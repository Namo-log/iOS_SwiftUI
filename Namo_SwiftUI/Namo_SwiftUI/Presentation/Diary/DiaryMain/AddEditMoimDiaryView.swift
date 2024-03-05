//
//  AddEditMoimDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

// 모임 기록 추가 및 수정 화면
struct AddEditMoimDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    
    let info: ScheduleInfo
    let isEditing: Bool
    
    var body: some View {
        ZStack() {
            VStack() {
                // 날짜와 장소 정보
                DatePlaceInfoView(date: info.date, place: info.place)
                
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: BackArrowView(),
                trailing: isEditing ? TrashView() : nil
            )
            .navigationTitle(info.scheduleName)
            .ignoresSafeArea(edges: .bottom)
            
            // 쓰레기통 클릭 시 Alert 띄우기
            if appState.isDeletingDiary {
                Color.black.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
                
                NamoAlertView(
                    showAlert: $appState.isDeletingDiary,
                    content: AnyView(
                        Text("기록을 정말 삭제하시겠어요?")
                            .font(.pretendard(.bold, size: 16))
                            .foregroundStyle(.mainText)
                            .padding(.top, 24)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {},
                    rightButtonTitle: "삭제") {
                        print("기록 삭제")
                        self.presentationMode.wrappedValue.dismiss()
                    }
            } // VStack
        } // ZStack
    }
}

#Preview {
    AddEditMoimDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: false)
}
