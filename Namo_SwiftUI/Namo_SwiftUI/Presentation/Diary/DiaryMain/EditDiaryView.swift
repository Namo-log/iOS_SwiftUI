//
//  EditDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 2/25/24.
//

import SwiftUI

import Factory
import PhotosUI

// 개인 / 모임 기록 추가 및 수정 화면
struct EditDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var diaryState: DiaryState
    @EnvironmentObject var scheduleState: ScheduleState
    @Injected(\.categoryInteractor) var categoryInteractor
    @Injected(\.diaryInteractor) var diaryInteractor
    @Injected(\.moimDiaryInteractor) var moimDiaryInteractor
    
    @State var memo: String
    @State var placeholderText: String = "메모 입력"
    @State var typedCharacters = 0
    @State var characterLimit = 200
    @State var pickedImagesData: [Data?] = []
    @State var images: [UIImage] = [] // 보여질 사진 목록
    @State var pickedImageItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    
    let urls: [String]
    let info: ScheduleInfo
    let moimMember: [MoimUser] = []
    let photosLimit = 3 // 선택가능한 최대 사진 개수
    
    var body: some View {
        ZStack() {
            VStack(alignment: .center) {
                VStack(alignment: .leading) {
                    // 날짜와 장소 정보
                    DatePlaceInfoView(date: info.date, place: info.getSchedulePlace())
                    
                    // 메모 입력 부분
                    ZStack(alignment: .topLeading) {
                        Rectangle()
                            .fill(.textBackground)
                            .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                        
                        Rectangle()
                            .fill(categoryInteractor.getColorWithPaletteId(id: appState.categoryPalette[info.categoryId ?? 0] ?? 0))
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
                            .onAppear {
                                typedCharacters = memo.count
                            }
                            .onChange(of: memo) { res in
                                typedCharacters = memo.count
                                memo = String(memo.prefix(characterLimit))
                                diaryState.currentDiary.contents = String(memo.prefix(characterLimit))
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
                    
                    // TODO: - 사진 목록 diaryState에 연결
                    // 사진 목록
                    PhotoPickerListView
                } // VStack
                .padding(.top, 12)
                .padding(.leading, 25)
                .padding(.trailing, 25)
                
                Spacer()
                
                // 모임 기록 보러가기 버튼
                if !appState.isPersonalDiary {
                    // 활동 정보 연결되면 아래 코드로 테스트
                    NavigationLink(destination: EditMoimDiaryView(activities: diaryState.currentMoimDiaryInfo.moimActivityDtos ?? [], images: pickedImagesData, info: info, moimUser: diaryState.currentMoimDiaryInfo.getMoimUsers())) {
                        BlackBorderRoundedView(text: "모임 기록 보러가기", image: Image(.icDiary), width: 192, height: 40)
                    }
                    .padding(.bottom, 25)
                    .simultaneousGesture(TapGesture().onEnded{
                        Task {
                            await moimDiaryInteractor.getOneMoimDiary(moimScheduleId: info.scheduleId)
                        }
                    })
                }
                
                // 기록 저장 또는 기록 수정 버튼
                EditSaveDiaryView
            } // VStack
            .navigationBarTitleDisplayMode(.inline)
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
                        Task {
                            let _ = await diaryInteractor.deleteDiary(scheduleId: info.scheduleId)
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
        } // ZStack
//        .onAppear {
//            Task {
//                // 기록 개별 조회 API 호출
//                await moimDiaryInteractor.getOneMoimDiaryDetail(moimScheduleId: info.scheduleId)
//                // memo 값 연결
//                memo = diaryState.currentDiary.contents ?? ""
//                for url in diaryState.currentDiary.urls ?? [] {
//                    guard let url = URL(string: url) else { return }
//                    
//                    DispatchQueue.global().async {
//                        guard let data = try? Data(contentsOf: url) else { return }
//                        images.append(UIImage(data: data)!)
//                        print(images.description)
//                    }
//                }
////                    images = diaryState.currentDiary.urls
//            }
//        }
        .onAppear (perform : UIApplication.shared.hideKeyboard)
    }
    
    // 기록 수정 완료 버튼 또는 기록 저장 버튼
    private var EditSaveDiaryView: some View {
        Button {
            print(appState.isEditingDiary ? "기록 수정" : "기록 저장")
            if appState.isEditingDiary {
                Task {
                    if appState.isPersonalDiary {
                        // 개인 기록 수정 API 호출
                        await diaryInteractor.changeDiary(scheduleId: info.scheduleId, content: memo, images: pickedImagesData)
                    } else {
                        print("모임 기록(에 대한 개인 메모) edit API 호출")
                        // 모임 기록(에 대한 개인 메모) edit API 호출
                        await moimDiaryInteractor.editMoimDiary(scheduleId: info.scheduleId, req: ChangeMoimDiaryRequestDTO(text: memo))
                    }
                }
            } else {
                Task {
                    if appState.isPersonalDiary {
                        await diaryInteractor.createDiary(scheduleId: scheduleState.currentSchedule.scheduleId ?? -1, content: diaryState.currentDiary.contents ?? "", images: pickedImagesData)
                    } else {
                        print("모임 기록(에 대한 개인 메모) edit API 호출")
                        // 모임 기록(에 대한 개인 메모) edit API 호출
                        await moimDiaryInteractor.editMoimDiary(scheduleId: info.scheduleId, req: ChangeMoimDiaryRequestDTO(text: memo))
                    }
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
    
    // 사진 선택 리스트 뷰
    private var PhotoPickerListView: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 20) {
                // images의 사진들을 하나씩 이미지뷰로 띄운다
                ForEach(0..<images.count, id: \.self) { i in
                    Image(uiImage: images[i])
                        .resizable()
                        .frame(width: 100, height: 100)
                        .aspectRatio(contentMode: .fill)
                }
                
                if appState.isPersonalDiary {
                    // 사진 피커 -> 최대 3장까지 선택 가능
                    PhotosPicker(selection: $pickedImageItems, maxSelectionCount: photosLimit, selectionBehavior: .ordered) {
                        Image(.btnAddImg)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
            } // HStack
            .padding(.top, 18)
            .onChange(of: pickedImageItems) { _ in
                Task {
                    // 앞서 선택된 것들은 지우고
                    pickedImagesData.removeAll()
                    images.removeAll()
                    
                    // 선택된 사진들 images에 추가
                    for item in pickedImageItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            pickedImagesData.append(data)
                            if let image = UIImage(data: data) {
                                images.append(image)
                            }
                        }
                    }
                }
            }
            .onAppear {
                images.removeAll()
                
                for url in urls {
                    guard let url = URL(string: url) else { return }
                    
                    DispatchQueue.global().async {
                        guard let data = try? Data(contentsOf: url) else { return }
                        pickedImagesData.append(data)
                        images.append(UIImage(data: data)!)
                        print(images.description)
                    }
                }
            } // ScrollView
        }
    }
}
