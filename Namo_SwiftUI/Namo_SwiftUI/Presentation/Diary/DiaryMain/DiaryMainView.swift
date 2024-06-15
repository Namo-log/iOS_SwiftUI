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
	@EnvironmentObject private var appState: AppState
    @Injected(\.diaryInteractor) var diaryInteractor
    @Injected(\.moimDiaryInteractor) var moimDiaryInteractor
    
    @State var currentDate: String = String(format: "%d.%02d", Date().toYMD().year, Date().toYMD().month)
    @State var showDatePicker: Bool = false
    @State var pickerCurrentYear: Int = Date().toYMD().year
    @State var pickerCurrentMonth: Int = Date().toYMD().month
    @State var dateIndicatorIndices: [Int] = [] // 날짜 뷰가 보여야 하는(앞의 다이어리와 날짜가 다른) 기록의 인덱스들만 저장한 것
    @State var page = 0
    @State var size = 10
    
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
						withAnimation {
							appState.isPersonalDiary.toggle()
						}
						Task {
							await loadDiaries()
						}
                    }
            })
    }
    
    var body: some View {
        ZStack {
            VStack {
                // 헤더
                HStack {
                    Button {
						withAnimation {
							showDatePicker = true
						}
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
                .padding(.top, 13)
                .padding(.leading, 20)
                .padding(.trailing, 20)
                
				if diaryState.monthDiaries.isEmpty {
					VStack(spacing: 45) {
						Image(.noDiary)
						
						Text("기록이 없습니다.\n일정에 기록을 남겨보세요!")
							.font(.pretendard(.light, size: 15))
							.lineLimit(2)
							.multilineTextAlignment(.center)
							.foregroundStyle(Color.mainText)
						
						Spacer()
						
					}
					.padding(.top, 149)
				} else {
					ScrollView {
						// 기록 목록
						LazyVStack(spacing: 20) { // infinite scroll 구현을 위해 LazyVStack을 사용
							ForEach(0..<diaryState.monthDiaries.count, id: \.self) { idx in
								let diary = diaryState.monthDiaries[idx]
								if dateIndicatorIndices.contains(idx) { // 해당되는 구간이면 날짜 뷰 보여주기
									DiaryDateItemView(startDate: diary.startDate) // 2024.03.27 날짜 뷰
								}
								DiaryItemView(diary: diary) // 그 아래 네모난 다이어리 뷰
									.onAppear {
										// 다음 페이지 불러오기
										if idx % size == 9 {
											page += 1
											print("페이지 추가 \(page)")
										}
									}
							}
						}
						.fixedSize(horizontal: false, vertical: true)
						
						Spacer()
					}
					.padding(.bottom, 90)
				}
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
                        Task {
							await loadDiaries()
                        }
                    }
                )
            }
        } // ZStack
        .task {
			await loadDiaries()
		}
        .onChange(of: page) { _ in // 페이지 바뀔 때마다 호출되는 부분
            Task {
                await loadDiaries(resetPage: false)
            }
        }
		.onReceive(NotificationCenter.default.publisher(for: .reloadDiaryViaNetwork)) { _ in
			Task {
				await loadDiaries()
			}
		}
    }
	
	private func loadDiaries(resetPage: Bool = true) async {
		if resetPage {
			page = 0
		}
		
		if appState.isPersonalDiary {
			await diaryInteractor.getMonthDiary(request: GetDiaryRequestDTO(year: pickerCurrentYear, month: pickerCurrentMonth, page: page, size: size))
		} else {
			await moimDiaryInteractor.getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO(year: pickerCurrentYear, month: pickerCurrentMonth, page: page, size: size))
		}
		dateIndicatorIndices = diaryInteractor.getDateIndicatorIndices(diaries: diaryState.monthDiaries)
	}
}

struct ScheduleInfo: Hashable {
    let scheduleId: Int
    let scheduleName: String
    let date: Date
    let place: String
    let categoryId: Int?
}

extension ScheduleInfo {
    func getSchedulePlace() -> String {
        if place.isEmpty {
            return "없음"
        } else {
            return place
        }
    }
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
    var diary: Diary!
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Rectangle()
                .fill(.textBackground)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 0)
            
            Rectangle()
                .fill(categoryInteractor.getColorWithPaletteId(id: diary.color))
                .frame(width: 10)
            
            HStack(alignment: .top, spacing: 12) {
                // 제목과 수정 버튼
                VStack(alignment: .leading, spacing: 0) {
                    Text(diary.name)
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
						.lineLimit(2)
                    
                    // 세로 여백
                    Spacer()
                    
                    // 다이어리 수정 버튼
                    NavigationLink(destination: EditDiaryView(isFromCalendar: false, memo: diary.contents ?? "", urls: diary.urls ?? [], info: ScheduleInfo(scheduleId: diary.scheduleId, scheduleName: diary.name, date: Date(timeIntervalSince1970: Double(diary.startDate)), place: diary.placeName, categoryId: diary.categoryId))) {
                        HStack(alignment: .center, spacing: 5) {
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
				.frame(width: 62)
                
                // 내용과 사진
                VStack(alignment: .leading, spacing: 12) {
                    Text(diary.contents?.replacingOccurrences(of: "\n", with: " ") ?? "")
                        .font(.pretendard(.light, size: 14))
                        .foregroundStyle(.mainText)
                        .lineLimit(5)
                        .truncationMode(.tail)
                    
                    // 사진 목록
                    // TODO: - 이미지 있는 기록이 잘 뜨는지 테스트 못 해봄
                    if let urls = diary.urls {
                        HStack(alignment: .top, spacing: 10) {
                            ForEach(urls, id: \.self) { url in
                                KFImage(URL(string: url))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 70, height: 70)
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
        .clipShape(RoundedCorners(radius: 11, corners: [.allCorners]))
        .padding(.leading, 25)
        .padding(.trailing, 25)
    }
}

//#Preview {
//    DiaryMainView()
//}
