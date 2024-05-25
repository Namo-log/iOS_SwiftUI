//
//  GroupToDoEditView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 4/14/24.
//


import SwiftUI
import Factory

/// 일정 추가/생성/삭제에서 표시되는 Edit 화면 입니다.
/// 장소 선택 시 -> ToDoSelectPlaceView
struct GroupToDoEditView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var scheduleState: ScheduleState
    @EnvironmentObject var moimState: MoimState
    @Injected(\.scheduleInteractor) var scheduleInteractor
    @Injected(\.placeInteractor) var placeInteractor
    @Injected(\.moimInteractor) var moimInteractor
    
    /// 시작 날짜 + 시각 Picker Show value
    @State private var showStartTimePicker: Bool = false
    /// 종료 날짜 + 시각 Picker Show value
    @State private var showEndTimePicker: Bool = false
    /// KakaoMapView draw State
    @State var draw: Bool = false
    /// 수정 화면일때 화면 변경 State
    @State var isRevise: Bool = false
    /// 현재 화면 dismiss
    @Environment(\.dismiss) private var dismiss
    /// ToDoSelectPlaceView Show State
    @State var isShowSheet: Bool = false
    /// 삭제 Alert Show State
    @State var showAlert: Bool = false
    /// 참석자 선택 창 Show State
    @State var showCheckParticipant: Bool = false

    /// 날짜 포매터
    private let dateFormatter = DateFormatter()
    
    init() {
        // SwiftUI의 NavigationTitle는 Font가 적용되지 않습니다.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 15)!]
        UINavigationBar.appearance().barTintColor = .white
        self.dateFormatter.dateFormat = "yyyy.MM.dd (E) hh:mm a"
    }
    
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            // MARK: 상단 삭제 원형 버튼
            if isRevise {
                DeleteButton(image: "ic_delete_schedule", frame: 30) {
                    self.showAlert = true
                }
            }
            
            // MARK: 메인 시트
            NavigationStack {
                ScrollView {
                    VStack {
                        // MARK: 일정 제목
                        TextField("일정 이름", text: $scheduleState.currentMoimSchedule.name)
                            .font(.pretendard(.bold, size: 22))
                            .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
                        
                        // MARK: 일정 선택내용 아이템 목록
                        VStack(alignment: .center, spacing: 20) {
                            ListItem(listTitle: "참석자") {
                                Button {
                                    self.showCheckParticipant = true
                                } label: {
                                    HStack {
                                        Text(usersInString(scheduleState.currentMoimSchedule.users))
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)
                                        
										Image(.arrowBasic)
                                            .renderingMode(.template)
                                            .foregroundStyle(.mainText)
                                        
                                    }
                                    .lineSpacing(12)
                                }
                            }
                            .padding(.vertical, 14)
                            
                            ListItem(listTitle: "시작") {
                                Text(dateFormatter.string(from: scheduleState.currentMoimSchedule.startDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showStartTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            if (showStartTimePicker) {
                                DatePicker("StartTimePicker", selection: $scheduleState.currentMoimSchedule.startDate)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            ListItem(listTitle: "종료") {
                                Text(dateFormatter.string(from: scheduleState.currentMoimSchedule.endDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showEndTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            if (showEndTimePicker) {
                                DatePicker("EndTimePicker", selection: $scheduleState.currentMoimSchedule.endDate, in: scheduleState.currentMoimSchedule.startDate...)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            ListItem(listTitle: "장소") {
                                Button(action: {
                                    self.draw = false
                                    withAnimation {
                                        isShowSheet = true
                                    }
                                }, label: {
                                    HStack {
                                        Text(scheduleState.currentMoimSchedule.locationName.isEmpty ? "위치명" : scheduleState.currentMoimSchedule.locationName)
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)
										Image(.arrowBasic)
                                            .renderingMode(.template)
                                            .foregroundStyle(.mainText)
                                    }
                                    .lineSpacing(12)
                                })
                            }
                            .padding(.vertical, 14)
                        }
                        .padding(.horizontal, 30)
                        
                        // MARK: 카카오 맵 뷰
                        KakaoMapView(draw: $draw, pinList: $appState.placeState.placeList, selectedPlace: $appState.placeState.selectedPlace)
                            .onAppear(perform: {
                                self.draw = true
                            }).onDisappear(perform: {
                                self.draw = false
                            })
                            .frame(width: 330, height:200)
                            .border(Color.init(hex: 0xD9D9D9), width: 1)
             
                        Spacer()
                    }
                    .navigationTitle(self.isRevise ? "일정 편집" : "새 일정")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button(action: {
                                // 닫기
                                dismissThis()
                            }, label: {
                                Text("닫기")
                                    .font(.pretendard(.regular, size: 15))
                            })
                            .foregroundStyle(.mainText)
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(action: {
                                // 저장
                                Task {
                                    let name = scheduleState.currentMoimSchedule.name
                                    guard !name.isEmpty else {
                                        print("@Log - \(scheduleState.currentMoimSchedule.name)")
                                        ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "입력 오류", message: "일정 제목은 공백일 수 없습니다.", localizedDescription: nil))
                                        return
                                    }
                                    if self.isRevise {
                                        await moimInteractor.patchMoimSchedule()
                                    } else {
                                        await moimInteractor.postNewMoimSchedule()
                                    }
                                    // 닫기
                                    dismissThis()
                                }
                                
                            }, label: {
                                Text("저장")
                                    .font(.pretendard(.regular, size: 15))
                            })
                            .foregroundStyle(.mainText)
                        }
                    }//: VStack - toolbar
                }//: ScrollView
                .background(.white)
            }
            
            .clipShape(UnevenRoundedRectangle(cornerRadii: .init(
                topLeading: 15,
                topTrailing: 15)))
            .shadow(radius: 10)
            .offset(y: 100)
            
            
            // MARK: 삭제 Alert 창
            if showAlert {
                NamoAlertView(
                    showAlert: $showAlert,
                    content: AnyView(
                        VStack {
                            Text("모임 일정을 정말 삭제하시겠어요?")
                                .font(.pretendard(.bold, size: 18))
                                .foregroundStyle(.mainText)
                                .multilineTextAlignment(.center)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            Text("삭제한 모임 일정은\n모든 참여자의 일정에서 삭제됩니다.")
                                .font(.pretendard(.regular, size: 14))
                                .foregroundStyle(.mainText)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                            .frame(minHeight:114)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {
                        // 자동 Alert창 dismiss
                    },
                    rightButtonTitle: "삭제",
                    rightButtonAction: {
                        Task {
                            // 삭제 후 dismiss
//                            await self.scheduleInteractor.deleteSchedule()
                            await self.moimInteractor.deleteMoimSchedule()
//                            dismissThis()
                        }
                    }
                )
            }
            
            // MARK: 참석자 선택 창
            if showCheckParticipant {
                CheckParticipant(
                    showCheckParticipant: $showCheckParticipant,
                    selectedUser: scheduleState.currentMoimSchedule.users
                )
            }
            
        }
        .overlay(isShowSheet ? ToDoSelectPlaceView(isShowSheet: $isShowSheet, preMapDraw: $draw, isGroup: true) : nil)
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear(perform: {
            // 템플릿에 모임Id 주입
            self.scheduleState.currentMoimSchedule.moimId = self.moimState.currentMoim.groupId
            print("현재 템플릿의 moimID : \(self.scheduleState.currentMoimSchedule.moimId)")
            // 밖에서 주입 받은 스케쥴 == 스케쥴 수정일 때
            if self.scheduleState.currentMoimSchedule.moimScheduleId != nil {
                self.isRevise = true
            } else { // 스케쥴 추가일 때
                self.scheduleState.currentMoimSchedule.users = moimState.currentMoim.groupUsers
            }
            // 현재 장소 리스트에 Schedule의 장소를 추가
            // 임시용으로, placeID가 추가된 후 추후에 수정이 필요합니다.
            if self.isRevise {
                let temp = self.scheduleState.currentMoimSchedule
                placeInteractor.appendPlaceList(place: Place(
                    id: 0,
                    x: temp.x,
                    y: temp.y,
                    name: temp.locationName,
                    address: "임시용입니다",
                    rodeAddress: "임시용입니다")
                )
            }
        })
        .onAppear (perform : UIApplication.shared.hideKeyboard)
    }
    
    /// 현재 ToDoEditView를 종로하고, Temp와 PlaceList를 clear합니다.
    private func dismissThis() {
        self.scheduleState.currentMoimSchedule = MoimScheduleTemplate()
        // 대충 여기 모임 스케쥴 템플릿 초기화
        placeInteractor.clearPlaces(isSave: false)
        placeInteractor.selectPlace(place: nil)
        dismiss()
    }
    
    /// 일정 생성/수정 화면의 각 아이템 리스트 아이템 뷰입니다.
    private struct ListItem<Content: View>: View {
        
        var listTitle: String
        var content: () -> Content
        
        var body: some View {
            HStack {
                Text(listTitle)
                    .font(.pretendard(.bold, size: 15))
                Spacer()
                content()
            }
        }
    }
    
    struct DeleteButton: View {
        
        let image: String
        let frame: CGFloat
        let action: () -> Void
        
        var body: some View {
            
            CircleItemView(content: {
                Image(image)
                    .resizable()
                    .frame(width: frame, height: frame)
            })
            .offset(y: 50)
            .onTapGesture(perform: {
                action()
            })
        }
    }
    
    /// 참석자 선택 리스트 뷰입니다.
    struct CheckParticipant: View {
        
        @EnvironmentObject var moimState: MoimState
        @Injected(\.scheduleInteractor) var scheduleInteractor
        @Injected(\.moimInteractor) var moimInteractor
        
        @Binding var showCheckParticipant: Bool
        @State var selectedUser: [MoimUser]
        
        var body: some View {
            NamoAlertViewWithTopButton(
                showAlert: $showCheckParticipant,
                title: "참석자",
                leftButtonTitle: "닫기",
                leftButtonAction: {},
                rightButtonTitle: "저장",
                rightButtonAction: {
                    moimInteractor.setSelectedUserListToCurrentMoimSchedule(list: selectedUser)
                    return true
                },
                content: AnyView(
                    ScrollView{
                        VStack(spacing: 15) {
                            ForEach(moimState.currentMoim.groupUsers, id: \.userId) { user in
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
                        .frame(height: 265)
                        .padding(.top, 25)
                )
            )
        }
        
       
    }
    
    /// 유저 리스트 값을 문자열로 반환해주는 함수 입니다.
    private func usersInString(_ users: [MoimUser]) -> String {
        guard users.count > 0 else { return "없음" }
         
        var userNames = users.count > 4
        ? users[0...3].reduce(into: "") { $0 += $1.userName + ", " }
        : users.reduce(into: "") { $0 += $1.userName + ", " }
        userNames = String(userNames.dropLast(2))
        
        let printString = users.count > 4
        ? userNames + " 외 \(users.count-4)명"
        : userNames
        
        return printString
    }
}

//#Preview {
//    GroupToDoEditView()
//        .environmentObject(AppState())
//}

