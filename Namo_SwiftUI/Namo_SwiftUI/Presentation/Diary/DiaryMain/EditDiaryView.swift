//
//  EditDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 2/25/24.
//

import SwiftUI

// 개인 / 모임 기록 추가 및 수정 화면
struct EditDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    
    let info: ScheduleInfo
    
    @State var placeholderText: String = "메모 입력"
    @State var memo = ""
    @State var typedCharacters = 0
    @State var characterLimit = 200
    
    var body: some View {
        ZStack() {
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    // 날짜와 장소 정보
                    DatePlaceInfoView(date: info.date, place: info.place)
                    
                    // 메모 입력 부분
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .fill(.textBackground)
                            .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                        
                        Rectangle()
                            .fill(.pink)
                            .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .bottomLeft]))
                            .frame(width: 10)
                        
                        // Place Holder
                        if self.memo.isEmpty {
                            TextEditor(text: $placeholderText)
                                .font(.pretendard(.medium, size: 15))
                                .foregroundColor(.textPlaceholder)
                                .disabled(true)
                                .padding(.leading, 20)
                                .padding(.top, 5)
                                .padding(.bottom, 5)
                                .padding(.trailing, 16)
                                .scrollContentBackground(.hidden) // 컨텐츠 영역의 하얀 배경 제거
                                .lineLimit(7)
                        }
                        TextEditor(text: $memo)
                            .font(.pretendard(.medium, size: 15))
                            .foregroundColor(.mainText)
                            .opacity(self.memo.isEmpty ? 0.25 : 1)
                            .padding(.leading, 20)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.trailing, 16)
                            .scrollContentBackground(.hidden) // 컨텐츠 영역의 하얀 배경 제거
                            .lineLimit(7)
                            .onChange(of: memo) { res in
                                typedCharacters = memo.count
                                memo = String(memo.prefix(characterLimit))
                            }
                    } // ZStack
                    .frame(height: 150)
                    
                    // 글자수 체크
                    HStack() {
                        Spacer()
                        
                        Text("\(typedCharacters) / \(characterLimit)")
                            .font(.pretendard(.bold, size: 12))
                            .foregroundStyle(.textUnselected)
                    } // HStack
                    .padding(.top, 10)
                    
                    // 사진 목록
                    PhotoPickerListView()
                } // VStack
                .padding(.top, 12)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                
                Spacer()
                
                // 모임 기록 보러가기 버튼
                if !appState.isPersonalDiary {
                    NavigationLink(destination: EditMoimDiaryView(info: info)) {
                        BlackBorderRoundedView(text: "모임 기록 보러가기", image: Image(.icDiary), width: 192, height: 40)
                    }
                    .padding(.bottom, 25)
                }
                
                // 기록 저장 또는 기록 수정 버튼
                EditSaveDiaryView()
            } // VStack
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: DismissButton(isDeletingDiary: $appState.isDeletingDiary),
                trailing: appState.isEditingDiary ? TrashView() : nil
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
            }
        } // ZStack
    }
}

#Preview {
    EditDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"))
}
