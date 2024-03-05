//
//  DiaryMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory

struct DiaryMainView: View {
    @Injected(\.appState) private var appState
    
    @State var currentDate: String = String(format: "%d.%02d", Date().toYMD().year, Date().toYMD().month)
    
    @State var showDatePicker: Bool = false
    @State var pickerCurrentYear: Int = Date().toYMD().year
    @State var pickerCurrentMonth: Int = Date().toYMD().month
    
    @State var dummyDiary = [DiaryItem(backgroundColor: .mainOrange, scheduleName: "점심 약속",
                                       content: "팀 빌딩을 앞두고 PM들끼리 모였다! 네오가 주도하셨는데, 밥 먹고 이디야에 가서 아이디어 피드백을 주고받았다. 원래 막막했었는데 도움이 많이 되었다. 팀 빌딩... 지원이 많이많이 들어왔으면 좋겠다."),
                             DiaryItem(backgroundColor: .mainOrange, scheduleName: "점심 약속",
                                       content: "팀 빌딩을 앞두고 PM들끼리 모였다! 네오가 주도하셨는데, 밥 먹고 이디야에 가서 아이디어 피드백을 주고받았다. 원래 막막했었는데 도움이 많이 되었다. 팀 빌딩... 지원이 많이많이 들어왔으면 좋겠다.")]
    @State var dummyGroupDiary = [DiaryItem(backgroundColor: .pink, scheduleName: "데모데이",
                                            content: "앱 런칭 데모데이를 진행했다. 참여진 분들과 피드백도 주고 받고, 무엇보다 우리 팀이 열심히 제작한 나모 앱을 누군가에게 보여줄 수 있다는 점이 뿌듯했다 ! 부스 정리하고 회식까지 하니 정말 다 끝난느낌...")]
    
    // 개인 / 모임 토글
    private var toggleView: some View {
        Capsule()
            .foregroundColor(.mainGray)
            .frame(width: 152, height: 30)
            .overlay(alignment: appState.isPersonalDiary ? .leading : .trailing, content: {
                Capsule()
                    .fill(.mainOrange)
                    .frame(width: 80, height: 26)
                    .overlay(
                        Text(appState.isPersonalDiary ? "개인" : "모임")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundStyle(.white)
                    )
                    .padding(.leading, 2)
                    .padding(.trailing, 2)
            })
            .overlay(alignment: appState.isPersonalDiary ? .trailing : .leading, content: {
                Text(appState.isPersonalDiary ? "모임" : "개인")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color(.mainText))
                    .padding(appState.isPersonalDiary ? .trailing : .leading, 24)
                    .onTapGesture {
                        appState.isPersonalDiary.toggle()
                    }
            })
    }
    
    var body: some View {
        ZStack {
            VStack {
                // 헤더
                HStack {
                    Button {
                        showDatePicker = true
                    } label: {
                        HStack {
                            Text(currentDate)
                                .font(.pretendard(.bold, size: 22))
                        
                            Image(.icChevronBottomBlack)
                        }
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                    
                    toggleView
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
                // 기록 목록
                if appState.isPersonalDiary ? dummyDiary.isEmpty : dummyGroupDiary.isEmpty {
                    Text("기록이 없습니다. 기록을 추가해 보세요!")
                        .font(.pretendard(.light, size: 15)) // Weight 400 -> .light
                        .padding(.top, 24)
                } else {
                    VStack(spacing: 20) {
                        ForEach(appState.isPersonalDiary ? dummyDiary : dummyGroupDiary) { diary in
                            DiaryDateItem()
                            diary
                        }
                    }
                }
                
                // TODO: - 추후 일정 화면에서 연결해야 함
                NavigationLink(destination: AddEditDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: false)) {
                  Text("기록 추가 임시 버튼")
                }
                
                Spacer()
            } // VStack
            
            if showDatePicker {
                NamoAlertView(
                    showAlert: $showDatePicker,
                    content: AnyView(
                        HStack(spacing: 0) {
                            Picker("", selection: $pickerCurrentYear) {
                                ForEach(2000...2099, id: \.self) {
                                    Text("\(String($0))년")
                                        .font(.pretendard(.regular, size: 23))
                                }
                            }
                            .pickerStyle(.inline)
                            
                            Picker("", selection: $pickerCurrentMonth) {
                                ForEach(1...12, id: \.self) {
                                    Text("\(String($0))월")
                                        .font(.pretendard(.regular, size: 23))
                                }
                            }
                            .pickerStyle(.inline)
                        }
                            .frame(height: 154)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {
                        pickerCurrentYear = Date().toYMD().year
                        pickerCurrentMonth = Date().toYMD().month
                    },
                    rightButtonTitle: "확인",
                    rightButtonAction: {
                        currentDate = String(format: "%d.%02d", pickerCurrentYear, pickerCurrentMonth)
                    }
                )
            }
        } // ZStack
    }
}

struct ScheduleInfo: Hashable {
    let scheduleName: String
    let date: String
    let place: String
}

// 다이어리 날짜 아이템
struct DiaryDateItem: View {
    var body: some View {
        HStack(spacing: 18) {
            Rectangle()
                .fill(.mainText)
                .frame(height: 1)
            Text("2024.02.25")
                .font(.pretendard(.bold, size: 15))
                .foregroundStyle(.mainText)
            Rectangle()
                .fill(.mainText)
                .frame(height: 1)
            
        }
        .padding(.top, 10)
        .padding(.leading, 35)
        .padding(.trailing, 35)
    }
}

// 다이어리 아이템
// TODO: - 내용에 따라 동적 높이 설정... 어떻게 하지
struct DiaryItem: View, Identifiable {
    let id = UUID()
    let backgroundColor: Color
    let scheduleName: String
    let content: String
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.textBackground)
                .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
            
            Rectangle()
                .fill(backgroundColor)
                .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .bottomLeft]))
                .frame(width: 10)
            
            HStack(alignment: .top, spacing: 15) {
                // 제목과 수정 버튼
                VStack(alignment: .leading, spacing: 0) {
                    Text(scheduleName)
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
                    Rectangle()
                        .fill(.clear)
                        .frame(width: 1, height: 150)
                    
                    // 다이어리 수정 버튼
                    NavigationLink(destination: AddEditDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: true)) {
                        HStack(alignment: .center, spacing: 3) {
                            Image(.icEditDiary)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 20, height: 20)
                            
                            Text("수정")
                                .font(.pretendard(.light, size: 12))
                                .foregroundStyle(.mainText)
                        }
                    }
                }
                
                // 내용과 사진
                VStack(alignment: .leading, spacing: 16) {
                    Text(content)
                        .font(.pretendard(.light, size: 14))
                        .foregroundStyle(.mainText)
                    
                    // 사진 목록
                    // TODO: - 사진이 없으면 없애야 됨
                    HStack(alignment: .top, spacing: 10) {
                        Image(.dummy)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                            .frame(width: 90, height: 90)
                        Image(.dummy)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                            .frame(width: 90, height: 90)
                    }
                }
            }
            .padding(.top, 16)
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
        .frame(height: 225)
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

#Preview {
    DiaryMainView()
}
