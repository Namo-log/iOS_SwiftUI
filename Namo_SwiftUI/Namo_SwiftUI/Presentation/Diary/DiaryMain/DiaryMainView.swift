//
//  DiaryMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

import Factory
import Kingfisher

struct DiaryMainView: View {
    @EnvironmentObject var diaryState: DiaryState
    @Injected(\.appState) private var appState
    @Injected(\.diaryInteractor) var diaryInteractor
    
    @State var currentDate: String = String(format: "%d.%02d", Date().toYMD().year, Date().toYMD().month)
    @State var showDatePicker: Bool = false
    @State var pickerCurrentYear: Int = Date().toYMD().year
    @State var pickerCurrentMonth: Int = Date().toYMD().month
    var prevDate: Int = 0
    
    //    @State var dummyDiary = [DiaryItem(backgroundColor: .mainOrange, scheduleName: "점심 약속",
    //                                       content: "팀 빌딩을 앞두고 PM들끼리 모였다! 네오가 주도하셨는데, 밥 먹고 이디야에 가서 아이디어 피드백을 주고받았다. 원래 막막했었는데 도움이 많이 되었다. 팀 빌딩... 지원이 많이많이 들어왔으면 좋겠다."),
    //                             DiaryItem(backgroundColor: .mainOrange, scheduleName: "점심 약속",
    //                                       content: "팀 빌딩을 앞두고 PM들끼리 모였다! 네오가 주도하셨는데, 밥 먹고 이디야에")]
    //    @State var dummyGroupDiary = [DiaryItemView(backgroundColor: .pink, scheduleName: "데모데이", content: "앱 런칭 데모데이를 진행했다. 참여진 분들과 피드백도 주고 받고, 무엇보다 우리 팀이 열심히 제작한 나모 앱을 누군가에게 보여줄 수 있다는 점이 뿌듯했다 ! 부스 정리하고 회식까지 하니 정말 다 끝난느낌...dfsdfdfdfsdfsdfadsffs")]
    
    
    
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
                
                ScrollView {
                    // 기록 목록
                    //                    if appState.isPersonalDiary {
                    //                        Text("기록이 없습니다. 기록을 추가해 보세요!")
                    //                            .font(.pretendard(.light, size: 15)) // Weight 400 -> .light
                    //                            .padding(.top, 24)
                    //                    } else {
                    VStack(spacing: 20) {
                        ForEach(diaryState.monthDiaries, id: \.scheduleId) { diary in
                            // 앞의 기록과 날짜가 다를 때만 날짜 뷰를 추가해야 함
                            // 이 방법이 최선인가?
                            if prevDate != diary.startDate {
                                DiaryDateItemView(startDate: diary.startDate)
                            }
                            DiaryItemView(backgroundColorId: diary.color, scheduleName: diary.name, content: diary.contents, urls: diary.urls ?? [])
                        }
                    }
                    .fixedSize(horizontal: false, vertical: true)
                    //                    }
                    
                    Spacer()
                } // VStack
            }
            
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
                        Task {
                            // TODO: - 페이징 처리
                            // TODO: - Date가 바뀔 때마다 하고 싶은데 여기 넣는 게 최선인가...
                            await diaryInteractor.getMonthDiary(request: GetDiaryRequestDTO(year: pickerCurrentYear, month: pickerCurrentMonth, page: 0, size: 3))
                        }
                    }
                )
            }
        } // ZStack
        .task {
            // TODO: - 페이징 처리
            await diaryInteractor.getMonthDiary(request: GetDiaryRequestDTO(year: pickerCurrentYear, month: pickerCurrentMonth, page: 0, size: 3))
        }
    }
}

struct ScheduleInfo: Hashable {
    let scheduleName: String
    let date: Date
    let place: String
    let participants: Int = 6
}

// 다이어리 날짜 아이템
struct DiaryDateItemView: View {
    let startDate: Int
    
    var body: some View {
        HStack(spacing: 18) {
            Rectangle()
                .fill(.mainText)
                .frame(height: 1)
            Text(Date(timeIntervalSince1970: Double(startDate)).toYMDString())
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
struct DiaryItemView: View {
    @EnvironmentObject var appState: AppState
    @Injected(\.categoryInteractor) var categoryInteractor
    
    var backgroundColorId: Int
    var scheduleName: String
    var content: String
    var urls: [String]
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.textBackground)
                .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
            
            Rectangle()
                .fill(categoryInteractor.getColorWithPaletteId(id: backgroundColorId))
                .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .bottomLeft]))
                .frame(width: 10)
            
            HStack(alignment: .top, spacing: 15) {
                // 제목과 수정 버튼
                VStack(alignment: .leading, spacing: 0) {
                    Text(scheduleName)
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
                    
                    // 세로 여백
                    Spacer()
                    
                    // 다이어리 수정 버튼
                    NavigationLink(destination: EditDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: Date(), place: "가천대 AI관 404호"))) {
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
                    .simultaneousGesture(TapGesture().onEnded {
                        appState.isEditingDiary = true
                    })
                }
                
                // 내용과 사진
                VStack(alignment: .leading, spacing: 16) {
                    Text(content)
                        .font(.pretendard(.light, size: 14))
                        .foregroundStyle(.mainText)
                    
                    // 사진 목록
                    // TODO: - 이미지 있는 기록이 잘 뜨는지 테스트 못 해봄
                    if !urls.isEmpty {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(urls, id: \.self) { url in
                                KFImage(URL(string: url))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 90, height: 90)
                                    .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                            }
                        }
                    }
                }
            }
            .padding(.top, 16)
            .padding(.leading, 20)
            .padding(.trailing, 16)
            .padding(.bottom, 16)
        }
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

#Preview {
    DiaryMainView()
}
