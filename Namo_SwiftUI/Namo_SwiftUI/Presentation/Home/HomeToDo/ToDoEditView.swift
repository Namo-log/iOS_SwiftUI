//
//  ToDoEditView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/24/24.
//

import SwiftUI
import Factory

/// 일정 추가/생성/삭제에서 표시되는 Edit 화면 입니다.
/// 카테고리 선택 시 -> ToDoSelectCategoryView
/// 장소 선택 시 -> ToDoSelectPlaceView
struct ToDoEditView: View {
    
    @EnvironmentObject var appState: AppState
    @Injected(\.scheduleInteractor) var scheduleInteractor
    @Injected(\.categoryInteractor) var categoryInteractor
    @Injected(\.placeInteractor) var placeInteractor
    
    /// 시작 날짜 + 시각 Picker Show value
    @State private var showStartTimePicker: Bool = false
    /// 종료 날짜 + 시각 Picker Show value
    @State private var showEndTimePicker: Bool = false
    /// 알림 선택란 Show value
    @State private var showNotificationSetting: Bool = false
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

    /// 날짜 포매터
    private let dateFormatter = DateFormatter()
    
    init(schedule: Schedule?) {
        // SwiftUI의 NavigationTitle는 Font가 적용되지 않습니다.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 15)!]
        UINavigationBar.appearance().barTintColor = .white
        self.dateFormatter.dateFormat = "yyyy.MM.dd (E) hh:mm a"
        // schedule 받은 경우 해당 schedule -> Template 저장 / nil이면 기본값
        // init으로 해당 객체를 직접 받기보다는, 전 화면에서 해당 함수를 호출하여 State에 추가해주는 것이 바람직해보입니다
        scheduleInteractor.setScheduleToTemplate(schedule: schedule)
    }
    
    var body: some View {
        
        ZStack(alignment: .top) {
            // MARK: 상단 삭제 원형 버튼
            if isRevise {
                CircleItemView(content: {
                    Image("ic_delete_schedule")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
                .offset(y: 50)
                .onTapGesture(perform: {
                    Task {
                        self.showAlert = true
                    }
                })
            }
            
            // MARK: 메인 시트
            NavigationStack {
                ScrollView {
                    VStack {
                        // MARK: 일정 제목
                        TextField("일정 이름", text: $appState.scheduleState.scheduleTemp.name)
                            .font(.pretendard(.bold, size: 22))
                            .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
                        
                        // MARK: 일정 선택내용 아이템 목록
                        VStack(alignment: .center, spacing: 20) {
                            ListItem(listTitle: "카테고리") {
                                NavigationLink(destination: ToDoSelectCategoryView()) {
                                    HStack {
                                        ColorCircleView(color: categoryInteractor.getColorWithPaletteId(id: appState.categoryState.categoryList.first(where: {$0.categoryId == appState.scheduleState.scheduleTemp.categoryId})?.paletteId ?? -1))
                                            .frame(width: 13, height: 13)
                                        Text(appState.categoryState.categoryList.first(where: {$0.categoryId == appState.scheduleState.scheduleTemp.categoryId})?.name ?? "카테고리 없음")
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)
                                        Image("vector3")
                                            .renderingMode(.template)
                                            .foregroundStyle(.mainText)
                                    }
                                    .lineSpacing(12)
                                }
                            }
                            .padding(.vertical, 14)
                            
                            ListItem(listTitle: "시작") {
                                Text(dateFormatter.string(from: appState.scheduleState.scheduleTemp.startDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showStartTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            
                            if (showStartTimePicker) {
                                DatePicker("StartTimePicker", selection: $appState.scheduleState.scheduleTemp.startDate)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            ListItem(listTitle: "종료") {
                                Text(dateFormatter.string(from: appState.scheduleState.scheduleTemp.endDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showEndTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            if (showEndTimePicker) {
                                DatePicker("EndTimePicker", selection: $appState.scheduleState.scheduleTemp.endDate, in: appState.scheduleState.scheduleTemp.startDate...)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            
                            
                            ListItem(listTitle: "알림") {
                                HStack {
                                    Text(appState.scheduleState.scheduleTemp.alarmDate.isEmpty
                                         ? "없음"
                                         : notiListInString(appState.scheduleState.scheduleTemp.alarmDate.sorted(by: { $0 > $1 })
                                            .map { NotificationSetting.getValueFromInt($0) })
                                    )
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    
                                    Image(showNotificationSetting == true ? "upChevron" : "downChevron")
                                        .renderingMode(.template)
                                        .foregroundStyle(.mainText)
                                }
                                .lineSpacing(12)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        self.showNotificationSetting.toggle()
                                    }
                                }
                            }
                            
                            if (showNotificationSetting) {
                                let notificationsList = NotificationSetting.allCases
                                
                                let rows = [
                                    GridItem(.fixed(35), spacing: 15, alignment: .topLeading),
                                    GridItem(.fixed(35), spacing: 15, alignment: .bottomTrailing)
                                ]
                                
                                LazyHGrid(rows: rows) {
                                    ForEach(notificationsList, id: \.self) { item in
                                        ColorToggleButton(
                                            isOn: Binding(get: {
                                                if item == .none { appState.scheduleState.scheduleTemp.alarmDate.isEmpty }
                                                else { appState.scheduleState.scheduleTemp.alarmDate.contains(item.toInt) }
                                            },set: {_ in }),
                                            buttonText: item.toString,
                                            action: {
                                                if item == .none {
                                                    appState.scheduleState.scheduleTemp.alarmDate = []
                                                }
                                                else {
                                                    if let index = appState.scheduleState.scheduleTemp.alarmDate.firstIndex(of: item.toInt) {
                                                        appState.scheduleState.scheduleTemp.alarmDate.remove(at: index)
                                                    }
                                                    else {
                                                        appState.scheduleState.scheduleTemp.alarmDate.append(item.toInt)
                                                    }
                                                }
                                            })
                                    }
                                }
                                
                            }
                            
                            ListItem(listTitle: "장소") {
                                Button(action: {
                                    self.draw = false
                                    withAnimation {
                                        isShowSheet = true
                                    }
                                }, label: {
                                    HStack {
                                        Text(appState.scheduleState.scheduleTemp.locationName.isEmpty ? "위치명" : appState.scheduleState.scheduleTemp.locationName)
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)
                                        Image("vector3")
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
                                    if self.isRevise {
                                        await scheduleInteractor.patchSchedule()
                                    } else {
                                        await scheduleInteractor.postNewSchedule()
                                    }
                                }
                                // 닫기
                                dismissThis()
                            }, label: {
                                Text("저장")
                                    .font(.pretendard(.regular, size: 15))
                            })
                            .foregroundStyle(.mainText)
                        }
                    }//: VStack - toolbar
                }//: ScrollView
            }//: NavigationStack
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
                            Text("일정을 정말 삭제하시겠어요?")
                                .font(.pretendard(.bold, size: 18))
                                .foregroundStyle(.mainText)
                                .multilineTextAlignment(.center)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            Text("일정 삭제 시, 해당 일정에 대한\n기록 또한 삭제됩니다.")
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
                            await self.scheduleInteractor.deleteSchedule()
                            dismissThis()
                        }
                    }
                )
            }
            
            
        }
        .overlay(isShowSheet ? ToDoSelectPlaceView(isShowSheet: $isShowSheet, preMapDraw: $draw) : nil)
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear(perform: {
            // 밖에서 주입 받은 스케쥴 == 스케쥴 수정일 때
            if self.appState.scheduleState.scheduleTemp.scheduleId != nil {
                self.isRevise = true
            }
            // 현재 장소 리스트에 Schedule의 장소를 추가
            // 임시용으로, placeID가 추가된 후 추후에 수정이 필요합니다.
            if self.isRevise {
                let temp = self.appState.scheduleState.scheduleTemp
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
    }
    
    /// 현재 ToDoEditView를 종로하고, Temp와 PlaceList를 clear합니다.
    private func dismissThis() {
        scheduleInteractor.setScheduleToTemplate(schedule: nil)
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
    
    /// 일정 생성/수정 화면의 알림 주기 설정 버튼 뷰입니다
    private struct ColorToggleButton: View {
        
        @Binding var isOn: Bool
        let buttonText: String
        let action: () -> Void
        
        var body: some View {
            Button(action: {
                self.action()
            }) {
                Text(buttonText)
                    .font(.pretendard(self.isOn ? .bold : .regular, size: 15))
                    .lineLimit(1)
                    .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                    .foregroundStyle(self.isOn ? .mainOrange : .mainText)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .stroke(self.isOn ? .mainOrange : .mainText, lineWidth: self.isOn ? 2 : 1)
                    )
            }
        }
    }
    
    /// 알림 리스트 값을 문자열로 반환해주는 함수 입니다.
    private func notiListInString(_ notifications: [NotificationSetting]) -> String {
        let returnString = notifications.reduce(into: ""){ $0 += $1.toString+", " }
        return String(returnString.dropLast(2))
    }
}



#Preview {
    ToDoEditView(schedule: nil)
        .environmentObject(AppState())
}
