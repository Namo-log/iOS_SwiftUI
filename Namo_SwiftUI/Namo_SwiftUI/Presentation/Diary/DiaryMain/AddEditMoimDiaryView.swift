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
    
    @State var showParticipants: Bool = true
    @State var showAddPlaceButton: Bool = true
    @State var numOfPlace = 1
    
    var body: some View {
        ZStack() {
            VStack(alignment: .center, spacing: 0) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        // 날짜와 장소 정보
                        DatePlaceInfoView(date: info.date, place: info.place)
                        
                        // 참석자
                        HStack(alignment: .top) {
                            Text("참석자 (\(info.participants))")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundStyle(.mainText)
                            Spacer()
                            Image(showParticipants ? "upChevronBold" : "downChevronBold")
                                .renderingMode(.template)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                self.showParticipants.toggle()
                            }
                        }
                        .padding(.top, 25)
                        
                        // 참석자 동그라미 뷰
                        if showParticipants {
                            HStack(spacing: 10) {
                                ForEach(0..<info.participants, id: \.self) { _ in
                                    Circle()
                                        .stroke(.textUnselected, lineWidth: 2)
                                        .frame(width: 42, height: 42)
                                        .overlay {
                                            Text("은수")
                                                .font(.pretendard(.bold, size: 11))
                                                .foregroundStyle(.textPlaceholder)
                                        }
                                }
                            }
                            .padding(.top, 15)
                        }
                        
                        // 장소
                        ForEach(0..<numOfPlace, id: \.self) { num in
                            MoimPlaceView(placeNumber: num + 1)
                                .padding(.bottom, 25)
                        }
                        
                    } // VStack - leading
                    .padding(.top, 12)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    
                    // 장소 추가 버튼
                    if showAddPlaceButton {
                        Button {
                            if numOfPlace == 2 {
                                showAddPlaceButton = false
                            }
                            
                            if numOfPlace < 3 {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    numOfPlace += 1
                                }
                            }
                        } label: {
                            BlackBorderRoundedView(text: "장소 추가", image: Image(.icMap), width: 136, height: 40)
                                .padding(.top, 25)
                        }
                    }
                } // ScrollView
                
                EditSaveDiaryView()
            } // VStack - center
            
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
            }
        } // ZStack
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: BackArrowView(),
            trailing: appState.isEditingDiary ? TrashView() : nil
        )
        .navigationTitle(info.scheduleName)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    AddEditMoimDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"))
}
