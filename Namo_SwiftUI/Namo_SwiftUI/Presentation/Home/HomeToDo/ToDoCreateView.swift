//
//  ToDoCreateView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/24/24.
//

import SwiftUI
import Factory

/// 알림 시각 설정을 위한 enum입니다.
/// 임시 세팅입니다.
enum NotificationSetting: CaseIterable {
    case none
    case oneHour
    case thirtyMin
    case tenMin
    case fiveMin
    case exactTime
    
    var toString: String {
        switch self {
        case .none:
            return "없음"
        case .oneHour:
            return "1시간 전"
        case .thirtyMin:
            return "30분 전"
        case .tenMin:
            return "10분 전"
        case .fiveMin:
            return "5분 전"
        case .exactTime:
            return "정시"
        }
    }
    
    var toInt: Int {
        switch self {
        case .none:
            return -1
        case .oneHour:
            return 60
        case .thirtyMin:
            return 30
        case .tenMin:
            return 10
        case .fiveMin:
            return 5
        case .exactTime:
            return 0
        }
    }
}


struct ToDoCreateView: View {
    
    @EnvironmentObject var appState: AppState
    @Injected(\.scheduleInteractor) var schduleInteractor
    @Injected(\.categoryInteractor) var categoryInteractor
    
    /// 일정 이름
    @State private var toDoTitle: String = ""
    /// 카테고리 색상
    @State private var categoryColor: Color = .mainText
    /// 카테고리 이름
    @State private var categoryName: String = "카테고리 없음"
    /// 시작 날짜 + 시각
    @State private var startDateTime: Date = Date()
    /// 종료 날짜 + 시각
    @State private var endDateTime: Date = Date()
    /// 알림 선택 목록
    @State private var notificationList: [NotificationSetting] = []
//    @State private var notificationList: [NotificationSetting:Bool] = [:]
    /// 장소명 -> 추후 long/latitude 추가 가능성 있습니다
    @State private var place: String = "위치명"
    
    /// 시작 날짜 + 시각 Picker Show value
    @State private var showStartTimePicker: Bool = false
    /// 종료 날짜 + 시각 Picker Show value
    @State private var showEndTimePicker: Bool = false
    /// 알림 선택란 Show value
    @State private var showNotificationSetting: Bool = false
    
    // KakaoMapView draw State
    @State var draw: Bool = false
    @State var pinList: [Place] = [
        Place(id: 0, x: 37.382001, y: 127.088678, name: "asdf", address: "asdf", rodeAddress: "asdf")
    ]
    
    /// 날짜 포매터
    private let dateFormatter = DateFormatter()
    
    init() {
        // SwiftUI의 NavigationTitle는 Font가 적용되지 않습니다.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 15)!]
        self.dateFormatter.dateFormat = "yyyy.MM.dd (E) hh:mm a"
    }
    
    var body: some View {
        NavigationStack {
//            ScrollView {
                VStack {
                    TextField("일정 이름", text: $toDoTitle)
                        .font(.pretendard(.bold, size: 22))
                        .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
                    
                    VStack(alignment: .center, spacing: 20) {
                        ListItem(listTitle: "카테고리") {
                            NavigationLink(destination: HomeMainView()) {
                                HStack {
                                    ColorCircleView(color: categoryColor)
                                        .frame(width: 13, height: 13)
                                    NavigationLink(categoryName, destination: HomeMainView())
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
                            Text(dateFormatter.string(from: startDateTime))
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        print("showStartTimePicker")
                                        self.showStartTimePicker.toggle()
                                    }
                                    
                                    Task {
                                        //fetch 함수 호출
                                    }
                                }
                        }
                        
                        
                        if (showStartTimePicker) {
                            DatePicker("StartTimePicker", selection: $startDateTime)
                                .datePickerStyle(.graphical)
                                .labelsHidden()
                                .tint(.mainOrange)
                        }
                        
                        ListItem(listTitle: "종료") {
                            Text(dateFormatter.string(from: endDateTime))
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                                .onTapGesture {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        print("showEndTimePicker")
                                        self.showEndTimePicker.toggle()
                                    }
                                }
                        }
                        
                        if (showEndTimePicker) {
                            DatePicker("EndTimePicker", selection: $endDateTime, in: startDateTime...)
                                .datePickerStyle(.graphical)
                                .labelsHidden()
                                .tint(.mainOrange)
                        }
                        
                        
                        
                        ListItem(listTitle: "알림") {
                            HStack {
                                Text(notificationList == [] ? "없음" : notiListInString(
                                    notificationList.sorted(by: {
                                        return $0.toInt > $1.toInt
                                    })
                                )
                                
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
                            // 테스트용
//                            let buttons = ["없음", "30분 전", "60분 전", "10분 전", "5분 전", "정시"]
                            let buttons = NotificationSetting.allCases
                            
                            VStack(spacing: 12) {
                                HStack {
                                    let halfenButtonIndices1 = buttons.indices[0..<buttons.count/2]
                                    ForEach(halfenButtonIndices1, id: \.self) { index in
                                        ColorToggleButton(isOn:  Binding(
                                            get: { notificationList.contains(buttons[index]) },
                                            set: { _ in
                                                notificationList.contains(buttons[index]) }
                                        ),
                                                          buttonText: buttons[index].toString) {
                                            if buttons[index] == .none {
                                                notificationList.removeAll()
                                            }
                                            else {
                                                if let index = notificationList.firstIndex(of: buttons[index]) {
                                                    notificationList.remove(at: index)
                                                } else {
                                                    notificationList.append(buttons[index])
                                                }
                                            }
                                        }
                                        if index != halfenButtonIndices1.last {
                                            Spacer()
                                        }
                                    }
                                }
                                HStack {
                                    let halfenButtonIndices2 = buttons.indices[buttons.count/2..<buttons.count]
                                    ForEach(halfenButtonIndices2, id: \.self) { index in
                                        ColorToggleButton(isOn:Binding(
                                            get: { notificationList.contains(buttons[index]) },
                                            set: { _ in
                                              notificationList.contains(buttons[index]) }
                                        ),
                                                          buttonText: buttons[index].toString) {
                                            if let index = notificationList.firstIndex(of: buttons[index]) {
                                                notificationList.remove(at: index)
                                            } else {
                                                notificationList.append(buttons[index])
                                            }
                                            print(notificationList)
                                        }
                                        if index != halfenButtonIndices2.last {
                                            Spacer()
                                        }
                                    }
                                }
                            }
                           
                        }
                        
                        ListItem(listTitle: "장소") {
                            NavigationLink(destination: HomeMainView()) {
                                HStack {
                                    Text(place)
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
                    }
                    .padding(.horizontal, 30)
                    
                    KakaoMapView(draw: $draw, pinList: $pinList).onAppear(perform: {
                        self.draw = true
                    }).onDisappear(perform: {
                        self.draw = false
                    })
                    .frame(width: 330, height:200)
                    .border(Color.init(hex: 0xD9D9D9), width: 1)
                    
                    Spacer()
                }
                .navigationTitle("새 일정")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            // 닫기
                        }, label: {
                            Text("닫기")
                                .font(.pretendard(.regular, size: 15))
                        })
                        .foregroundStyle(.mainText)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button(action: {
                            // 저장
                        }, label: {
                            Text("저장")
                                .font(.pretendard(.regular, size: 15))
                        })
                        .foregroundStyle(.mainText)
                    }
                }//: VStack - toolbar
//            }//: ScrollView
        }//: NavigationStack
    }
    
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
    ToDoCreateView()
}
