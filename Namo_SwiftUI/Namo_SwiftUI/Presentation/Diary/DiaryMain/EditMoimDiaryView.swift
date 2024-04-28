//
//  EditMoimDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import Factory

// 모임 기록 추가 및 수정 화면
struct EditMoimDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @Injected(\.moimDiaryInteractor) var moimDiaryInteractor
    
    @State private var showParticipants: Bool = true
    @State private var showAddPlaceButton: Bool = true
    @State private var numOfPlace = 1
    @State private var showCalculateAlert: Bool = false
    @State private var totalCost: String = ""
    
    let info: ScheduleInfo
    let moimUser: [MoimUser]
    let gridColumn: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
    
    @State var selectedUser: [MoimUser] = []
    
    // 모임 정산 Alert
    var groupCalculateAlertView: some View {
        NamoAlertViewWithTopButton(
            showAlert: $showCalculateAlert,
            title: "정산 페이지",
            leftButtonTitle: "닫기",
            leftButtonAction: {
                showCalculateAlert = false
            },
            rightButtonTitle: "저장",
            rightButtonAction: {
                // TODO: - 저장 기능 연결 필요
                showCalculateAlert = false
                return true
            },
            content: AnyView(
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        Text("총 금액")
                            .font(.pretendard(.bold, size: 15))
                        Spacer()
                        HStack(spacing: 0) {
                            TextField("금액 입력", text: $totalCost)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.trailing)
                            
                            if (totalCost != "") {
                                Text(" 원")
                            }
                        }
                        .frame(width: (screenWidth-90)/2, height: 30)
                        .foregroundStyle(Color.mainText)
                        .padding(.trailing, 10)
                        .background(Color(.mainGray))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .font(.pretendard(.regular, size: 15))
                        
                    }
                    
                    HStack {
                        Text("인원 수")
                            .font(.pretendard(.bold, size: 15))
                        Spacer()
                        HStack {
                            Text("÷")
                                .font(.pretendard(.regular, size: 15))
                            Spacer()
                            Text("\(selectedUser.count) 명")
                                .font(.pretendard(.regular, size: 15))
                        }
                        .frame(width: (screenWidth-90)/2)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .fill(Color.black)
                                .frame(height: 1)
                                .offset(y: 10)
                        }
                    }
                    
                    HStack {
                        Text("인당 금액")
                            .font(.pretendard(.bold, size: 15))
                        Spacer()
                        if selectedUser.count == 0 {
                            Text("0 원")
                                .font(.pretendard(.regular, size: 15))
                        } else {
                            Text("\((Int(totalCost) ?? 0) / selectedUser.count) 원")
                                .font(.pretendard(.regular, size: 15))
                        }
                    }
                    
                    LazyVGrid(columns: gridColumn) {
                        ForEach(moimUser, id: \.userId) { user in
                            HStack(spacing: 20) {
                                Button(
                                    action: {
                                        if selectedUser.contains(where: {$0 == user}) {
                                            selectedUser.removeAll(where: {$0 == user})
                                        } else {
                                            selectedUser.append(user)
                                        }
                                    }, label: {
                                        Image(selectedUser.contains(where: {$0 == user}) ? .isSelectedTrue : .isSelectedFalse)
                                            .resizable()
                                            .frame(width: 20, height: 20)
                                    }
                                )
                                
                                Text(user.userName)
                                Spacer()
                            }
                        }
                    }
                    
                }
                    .padding(.top, 25)
                    .padding(.bottom, 33)
            )
        )
    }
    
    var body: some View {
        ZStack() {
            VStack(alignment: .center, spacing: 0) {
                ScrollView(.vertical) {
                    VStack(alignment: .leading, spacing: 0) {
                        // 날짜와 장소 정보
                        DatePlaceInfoView(date: info.date, place: info.place)
                        
                        // 참석자
                        HStack(alignment: .top) {
                            Text("참석자 (\(moimUser.count))")
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
                                ForEach(moimUser, id: \.self) { user in
                                    Circle()
                                        .stroke(.textUnselected, lineWidth: 2)
                                        .frame(width: 42, height: 42)
                                        .overlay {
                                            Text(user.userName)
                                                .font(.pretendard(.bold, size: 11))
                                                .foregroundStyle(.textPlaceholder)
                                        }
                                }
                            }
                            .padding(.top, 15)
                        }
                        
                        // 장소 뷰
                        ForEach(0..<numOfPlace, id: \.self) { num in
                            MoimPlaceView(numOfPlace: $numOfPlace, showCalculateAlert: $showCalculateAlert)
                        }
                    } // VStack - leading
                    .padding(.top, 12)
                    .padding(.leading, 25)
                    .padding(.trailing, 25)
                    
                    // 활동 추가 버튼
                    if showAddPlaceButton {
                        Button {
                            if numOfPlace == 2 {
                                print("2개다")
                                showAddPlaceButton = false
                            }
                            
                            if numOfPlace < 3 {
                                withAnimation(.easeIn(duration: 0.2)) {
                                    numOfPlace += 1
                                }
                            }
                        } label: {
                            BlackBorderRoundedView(text: "활동 추가", image: Image(.icMap), width: 136, height: 40)
                                .padding(.top, 25)
                        }
                    }
                } // ScrollView
                
                EditSaveDiaryView
            } // VStack - center
            
            // 쓰레기통 클릭 시 Alert 띄우기
            if appState.isDeletingDiary {
                Color.black.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
                
                NamoAlertView(
                    showAlert: $appState.isDeletingDiary,
                    content: AnyView(
                        VStack(alignment: .center, spacing: 10) {
                            Text("모임 기록을 정말 삭제하시겠어요?")
                                .font(.pretendard(.bold, size: 16))
                                .foregroundStyle(.mainText)
                                .padding(.top, 24)
                            Text("삭제한 모임 기록은\n개인 기록 페이지에서도 삭제됩니다.")
                                .font(.pretendard(.light, size: 14))
                                .foregroundStyle(.mainText)
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom, 5)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {},
                    rightButtonTitle: "삭제") {
                        print("기록 삭제")
                        Task {
                            // 모임 기록 삭제
                            await moimDiaryInteractor.deleteMoimDiary(moimMemoId: 1)
                        }
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
            
            // 정산 Alert 뷰
            if showCalculateAlert {
                groupCalculateAlertView
            }
        } // ZStack
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: DismissButton(isDeletingDiary: $appState.isDeletingDiary),
            trailing: appState.isEditingDiary ? TrashView() : nil
        )
        .navigationTitle(info.scheduleName)
        .ignoresSafeArea(edges: .bottom)
    }
    
    // 모임 기록 수정 완료 버튼 또는 기록 저장 버튼
    private var EditSaveDiaryView: some View {
        Button {
            print(appState.isEditingDiary ? "기록 수정" : "기록 저장")
            if appState.isEditingDiary {
                Task {
                    // TODO: - 이미지 연결
                    // TODO: - API 연결
//                    await moimDiaryInteractor.changeMoimDiaryPlace(moimLocationId: 0, req: EditMoimDiaryPlaceReqDTO(name: "", money: totalCost, participants: moimUseer.reduce(nil, { partialResult, user in
//                        user.userName
//                    }), imgs: <#T##[Data?]#>))
                }
            } else {
                Task {
                    // TODO: - API 연결
//                    let req = EditMoimDiaryPlaceReqDTO(name: <#T##String#>, money: <#T##String#>, participants: moimUser., imgs: <#T##[Data?]#>)
//                    await moimDiaryInteractor.createMoimDiaryPlace(moimScheduleId: info.scheduleId, req: req)
                }
            }
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
