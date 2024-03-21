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
	@EnvironmentObject var scheduleState: ScheduleState
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
    
    /// 화면에 표시되기 위한 categoryList State
    @State private var categoryList: [ScheduleCategory] = []
    
    @State var showCategoryDeleteAlert: Bool = false

    /// 날짜 포매터
    private let dateFormatter = DateFormatter()
    
    /// NaivagionPath
    @State private var path = NavigationPath()
    
    init() {
        // SwiftUI의 NavigationTitle는 Font가 적용되지 않습니다.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 15)!]
        UINavigationBar.appearance().barTintColor = .white
        self.dateFormatter.dateFormat = "yyyy.MM.dd (E) hh:mm a"
        // schedule 받은 경우 해당 schedule -> Template 저장 / nil이면 기본값
        // init으로 해당 객체를 직접 받기보다는, 전 화면에서 해당 함수를 호출하여 State에 추가해주는 것이 바람직해보입니다
//        scheduleInteractor.setScheduleToTemplate(schedule: schedule)
    }
    
    
    
    var body: some View {
        
        ZStack(alignment: .top) {
            // MARK: 상단 삭제 원형 버튼
            if isRevise {
                
                CategoryDeleteButton(image: "ic_delete_schedule", frame: 30) {
                    self.showAlert = true
                }
            }
            
            // CategoryEditView의 카테고리 삭제 버튼
            if appState.showCategoryDeleteBtn {
                
                // 카테고리 삭제 불가
                if appState.categoryCantDelete {
                    
                    CategoryDeleteButton(image: "ic_cannot_delete", frame: 24) {
                        
                        withAnimation {
                            self.appState.showCategoryCantDeleteToast = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation {
                                self.appState.showCategoryCantDeleteToast = false
                            }
                        }
                        
                    }
                    // 카테고리 삭제 가능
                } else {
                    
                    CategoryDeleteButton(image: "ic_delete_schedule", frame: 30) {
                        
                        self.showCategoryDeleteAlert = true
                        
                    }
                }
            }
            
            // MARK: 메인 시트
            NavigationStack(path: $path) {
                ScrollView {
                    VStack {
                        // MARK: 일정 제목
						TextField("일정 이름", text: $scheduleState.currentSchedule.name)
                            .font(.pretendard(.bold, size: 22))
                            .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
                        
                        // MARK: 일정 선택내용 아이템 목록
                        VStack(alignment: .center, spacing: 20) {
                            ListItem(listTitle: "카테고리") {
                                
                                Button {
                                    
                                    path.append(CategoryViews.TodoSelectCategoryView)
                                    
                                } label: {
                                    HStack {
//<<<<<<< HEAD
//                                        
//                                        ColorCircleView(color: categoryInteractor.getColorWithPaletteId(id: appState.categoryState.categoryList.first(where: {$0.categoryId == appState.scheduleState.scheduleTemp.categoryId})?.paletteId ?? -1))
//                                                                                    .frame(width: 13, height: 13)
//                                        Text(appState.categoryState.categoryList.first(where: {$0.categoryId == appState.scheduleState.scheduleTemp.categoryId})?.name ?? "카테고리 없음")
//=======
                                        ColorCircleView(color: categoryInteractor.getColorWithPaletteId(id: appState.categoryState.categoryList.first(where: {$0.categoryId == scheduleState.currentSchedule.categoryId})?.paletteId ?? -1))
                                            .frame(width: 13, height: 13)
                                        Text(appState.categoryState.categoryList.first(where: {$0.categoryId == scheduleState.currentSchedule.categoryId})?.name ?? "카테고리 없음")
//>>>>>>> develop
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)
                                        
                                        Image("vector3")
                                            .renderingMode(.template)
                                            .foregroundStyle(.mainText)
                                        
                                    }
                                    .lineSpacing(12)
                                }
                                // MARK: 카테고리 편집 NavigationPath 경로
                                .navigationDestination(for: CategoryViews.self) { id in
                                    
                                    CategoryPath.setCategoryPath(id: id, path: $path)
                                
                                }
                            }
                            .padding(.vertical, 14)
                            
                            ListItem(listTitle: "시작") {
                                Text(dateFormatter.string(from: scheduleState.currentSchedule.startDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showStartTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            if (showStartTimePicker) {
                                DatePicker("StartTimePicker", selection: $scheduleState.currentSchedule.startDate)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            ListItem(listTitle: "종료") {
                                Text(dateFormatter.string(from: scheduleState.currentSchedule.endDate))
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(.mainText)
                                    .onTapGesture {
                                        withAnimation(.easeInOut(duration: 0.3)) {
                                            self.showEndTimePicker.toggle()
                                        }
                                    }
                            }
                            
                            if (showEndTimePicker) {
                                DatePicker("EndTimePicker", selection: $scheduleState.currentSchedule.endDate, in: scheduleState.currentSchedule.startDate...)
                                    .datePickerStyle(.graphical)
                                    .labelsHidden()
                                    .tint(.mainOrange)
                            }
                            
                            ListItem(listTitle: "알림") {
                                HStack {
                                    Text(scheduleState.currentSchedule.alarmDate.isEmpty
                                         ? "없음"
                                         : notiListInString(scheduleState.currentSchedule.alarmDate.sorted(by: { $0 > $1 })
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
                                                if item == .none { scheduleState.currentSchedule.alarmDate.isEmpty }
                                                else { scheduleState.currentSchedule.alarmDate.contains(item.toInt) }
                                            },set: {_ in }),
                                            buttonText: item.toString,
                                            action: {
                                                if item == .none {
                                                    scheduleState.currentSchedule.alarmDate = []
                                                }
                                                else {
                                                    if let index = scheduleState.currentSchedule.alarmDate.firstIndex(of: item.toInt) {
                                                        scheduleState.currentSchedule.alarmDate.remove(at: index)
                                                    }
                                                    else {
                                                        scheduleState.currentSchedule.alarmDate.append(item.toInt)
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
                                        Text(scheduleState.currentSchedule.locationName.isEmpty ? "위치명" : scheduleState.currentSchedule.locationName)
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
            
            // 카테고리 삭제 alert
            if showCategoryDeleteAlert {
                
                NamoAlertView(
                    showAlert: $showCategoryDeleteAlert,
                    content: AnyView(
                        VStack {
                            Text("카테고리를 정말 삭제하시겠어요?")
                                .font(.pretendard(.bold, size: 18))
                                .foregroundStyle(.mainText)
                                .multilineTextAlignment(.center)
                                .padding(.top, 24)
                                .padding(.bottom, 8)
                            Text("삭제하더라도 카테고리에 \n포함된 일정은 사라지지 않습니다.")
                                .font(.pretendard(.regular, size: 14))
                                .foregroundStyle(.mainText)
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                        }
                            .frame(minHeight:114)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {
                        self.showCategoryDeleteAlert = false
                    },
                    rightButtonTitle: "삭제",
                    rightButtonAction: {
                        Task {
                            await self.categoryInteractor.removeCategory(id: self.appState.categoryState.categoryList.first?.categoryId ?? -1)
                            
                            withAnimation {
                                appState.showCategoryDeleteDoneToast = true
                            }
                            
                            appState.showCategoryDeleteBtn = false
                            appState.categoryCantDelete = false
                            
                            path.removeLast()
                        }
                    }
                )
            }
        }
        .overlay(isShowSheet ? ToDoSelectPlaceView(isShowSheet: $isShowSheet, preMapDraw: $draw) : nil)
        .ignoresSafeArea(.all, edges: .bottom)
        .onAppear(perform: {
            // 밖에서 주입 받은 스케쥴 == 스케쥴 수정일 때
            if self.scheduleState.currentSchedule.scheduleId != nil {
                self.isRevise = true
            }
            // 현재 장소 리스트에 Schedule의 장소를 추가
            // 임시용으로, placeID가 추가된 후 추후에 수정이 필요합니다.
            if self.isRevise {
                let temp = self.scheduleState.currentSchedule
                placeInteractor.appendPlaceList(place: Place(
                    id: 0,
                    x: temp.x,
                    y: temp.y,
                    name: temp.locationName,
                    address: "임시용입니다",
                    rodeAddress: "임시용입니다")
                )
            }
            
            Task {
                await self.categoryInteractor.getCategories()
                
                self.categoryList = categoryInteractor.setCategories()
            
                self.scheduleState.currentSchedule.categoryId = self.categoryList.first?.categoryId ?? -1
            }
        })
    }
    
    /// 현재 ToDoEditView를 종로하고, Temp와 PlaceList를 clear합니다.
    private func dismissThis() {
        scheduleInteractor.setScheduleToCurrentSchedule(schedule: nil)
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
    
    struct CategoryDeleteButton: View {
        
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
    
    /// 알림 리스트 값을 문자열로 반환해주는 함수 입니다.
    private func notiListInString(_ notifications: [NotificationSetting]) -> String {
        let returnString = notifications.reduce(into: ""){ $0 += $1.toString+", " }
        return String(returnString.dropLast(2))
    }
}

#Preview {
    ToDoEditView()
        .environmentObject(AppState())
}
