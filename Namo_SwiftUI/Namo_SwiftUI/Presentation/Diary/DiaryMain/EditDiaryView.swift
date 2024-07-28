//
//  EditDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 2/25/24.
//

import SwiftUI

import Factory
import PhotosUI
import Kingfisher

// 개인 / 모임 기록 추가 및 수정 화면
struct EditDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var diaryState: DiaryState
    @EnvironmentObject var scheduleState: ScheduleState
    let categoryUseCase = CategoryUseCase.shared
    let diaryUseCase = DiaryUseCase.shared
    let moimDiaryUseCase = MoimDiaryUseCase.shared
    
    @State var isFromCalendar: Bool
    @State var memo: String
    @State var placeholderText: String = "메모 입력"
    @State var typedCharacters = 0
    @State var characterLimit = 200
    @State var pickedImagesData: [Data?] = []

    /// 화면에 보여질 이미지 목록
    @State var images: [ImageItem] = []
    
    @State var pickedImageItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    
    /// 이미지 상세보기 화면 활성화 여부
    @State var showImageDetailViewSheet: Bool = false
    /// 이미지 상세보기 페이지에 전달할 인덱스
    @State var selectedImageIndex: Int = 0
    
    let urls: [String]
    let info: ScheduleInfo
    let moimMember: [GroupUser] = []
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
                        
                        Rectangle()
                            .fill(categoryUseCase.getColorWithPaletteId(id: appState.categoryPalette[info.categoryId ?? 0] ?? 0))
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
                    .clipShape(RoundedCorners(radius: 11, corners: [.allCorners]))
                    
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
                    NavigationLink(destination: EditMoimDiaryView(activities: diaryState.currentMoimDiaryInfo.moimActivityDtos ?? [], info: info, moimUser: diaryState.currentMoimDiaryInfo.getMoimUsers())) {
                        BlackBorderRoundedView(text: "모임 기록 보러가기", image: Image(.icDiary), width: 192, height: 40)
                    }
                    .padding(.bottom, 25)
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
            .fullScreenCover(isPresented: $showImageDetailViewSheet) {
                ImageDetailView(isShowImageDetailScreen: $showImageDetailViewSheet, imageIndex: $selectedImageIndex, images: images)
            }
            
            // 쓰레기통 클릭 시 Alert 띄우기
            if appState.isDeletingDiary {
                Color.black.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
                
                AlertViewOld(
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
                            
                            if appState.isPersonalDiary {
                             
                                let _ = await diaryUseCase.deleteDiary(scheduleId: info.scheduleId)
                                
                            } else {
                                
                                let _ = await moimDiaryUseCase.deleteMoimDiaryOnPersonal(scheduleId: info.scheduleId)
                            }
                            
                            self.presentationMode.wrappedValue.dismiss()
                        }
                    }
            }
            
        } // ZStack
        .onAppear {
            if isFromCalendar {
                // 아래의 작업은 캘린더에서 이 화면으로 넘어올 때만 필요해서 해당 불값을 추가함...

                Task {
                    // 개인 기록일 경우
                    if appState.isPersonalDiary {
                        
                        // 기존의 imagesNew 배열을 비움
                        images.removeAll()
                        pickedImagesData.removeAll()
                        
                        await diaryUseCase.getOneDiary(scheduleId: info.scheduleId)

                    } else {
                        await moimDiaryUseCase.getOneMoimDiaryDetail(moimScheduleId: info.scheduleId)
                    }
                    // memo 값 연결
                    memo = diaryState.currentDiary.contents ?? ""
 
                    // MARK: images(ImageItem)과 pickedImagesData의 싱크를 맞추기 위함
                    
                    let dispatchGroup = DispatchGroup()
                    var imagesDataDictionary = [String: Data]()
                    
                    for url in diaryState.currentDiary.urls ?? [] {
                        
                        images.append(ImageItem(id: nil, source: .url(url)))
                        
                        guard let url = URL(string: url) else { return }
                        
                        dispatchGroup.enter()
                        
                        DispatchQueue.global().async {
                            
                            defer { dispatchGroup.leave() }
                            
                            // 서버로부터 받아온 url을 data 타입으로 변환
                            guard let data = try? Data(contentsOf: url) else { return }
                            
                            imagesDataDictionary[url.absoluteString] = data
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        
                        for url in diaryState.currentDiary.urls ?? [] {
                            
                            if let url = URL(string: url), let data = imagesDataDictionary[url.absoluteString] {
                                pickedImagesData.append(data)
                            }
                            
                        }
                        
                    }
                }
            }
        }
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
                        await diaryUseCase.changeDiary(scheduleId: info.scheduleId, content: memo, images: pickedImagesData)
                    } else {
                        print("모임 기록(에 대한 개인 메모) edit API 호출")
                        // 모임 기록(에 대한 개인 메모) edit API 호출
                        await moimDiaryUseCase.editMoimDiary(scheduleId: info.scheduleId, req: ChangeMoimDiaryRequestDTO(text: memo))
                    }
					NotificationCenter.default.post(name: .reloadDiaryViaNetwork, object: nil)
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            } else {
                Task {
                    if appState.isPersonalDiary {
                        await diaryUseCase.createDiary(scheduleId: scheduleState.currentSchedule.scheduleId ?? -1, content: diaryState.currentDiary.contents ?? "", images: pickedImagesData)
                    } else {
                        print("모임 기록(에 대한 개인 메모) edit API 호출")
                        // 모임 기록(에 대한 개인 메모) edit API 호출
                        await moimDiaryUseCase.editMoimDiary(scheduleId: info.scheduleId, req: ChangeMoimDiaryRequestDTO(text: memo))
                    }
                    
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            
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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 20) {

                ForEach(0..<images.count, id: \.self) { index in
                    
                    ZStack {
                        
                        /// 이미지 출처가 서버일 경우 KF, 사용자 앨범일 경우 UIImage로 화면에 띄움
                        
                        switch images[index].source {
                            
                        case .url(let url):
                            
                            KFImage(URL(string: url))
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    selectedImageIndex = index
                                    showImageDetailViewSheet = true
                                }
                            
                            
                        case .uiImage(let uiImage):
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    selectedImageIndex = index
                                    showImageDetailViewSheet = true
                                }
                        }
                        
                        // 이미지 삭제 버튼은 개인 기록에만 있음
                        // 모임 기록은 모임 기록 편집 페이지에서만 가능
                        if appState.isPersonalDiary {
                            
                            Image("icImageDelete")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 30)
                                .offset(x: 40, y: -45)
                                .shadow(radius: 5)
                                .onTapGesture {
                      
                                    // 서버로 보내는 이미지 배열에서 인덱스의 이미지 삭제
                                    if index >= 0 && index <  pickedImagesData.count {
                                        
                                        pickedImagesData.remove(at: index)
                                        
                                        // 이미지 배열에서 해당하는 인덱스의 이미지 삭제
                                        images.remove(at: index)
                                        
                                        // 이미지를 제대로 불러오지 못했을 경우 에러 처리
                                    } else {
                                        
                                        ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "이미지 삭제 오류", message: "일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", localizedDescription: "이미지 불러오기 실패"))
                                    }
                                    
//                                    // 앨범에서 선택된 이미지들 목록 비우기
//                                    pickedImageItems.removeAll()
                                }
                        }
                    }
                }
                
                // 개인 기록일 경우 (모임 기록은 이 화면에서 이미지 수정 불가이기 때문)
                if appState.isPersonalDiary {
                    
                    // 사진이 2장 이하일 때만 사진 추가할 수 있는 앨범 표시
                    if images.count < 3 {
                        
                        // 사진 피커 -> 최대 3장까지 선택 가능
                        PhotosPicker(selection: $pickedImageItems, maxSelectionCount: photosLimit - images.count, selectionBehavior: .ordered) {
                            Image(.btnAddImg)
                                .resizable()
                                .frame(width: 100, height: 100)
                            
                        }
                    }
                }
            } // HStack
            .padding(.top, 18)
            // 사진 리스트가 화면에 나타날 때
            .onAppear {

                pickedImagesData.removeAll()
                images.removeAll()
                
                // MARK: images(ImageItem)과 pickedImagesData의 싱크를 맞추기 위함
                
                let dispatchGroup = DispatchGroup()
                var imagesDataDictionary = [String: Data]()
                
                // 서버로부터 받아온 이미지 url 배열 순회
                for url in urls {
                    
                    // 화면에 보이는 이미지 배열에 하나씩 추가
                    images.append(ImageItem(id: nil, source: .url(url)))
                    
                    guard let url = URL(string: url) else { return }
                    
                    // 디스패치 그룹
                    dispatchGroup.enter()
                    
                    DispatchQueue.global().async {
                        
                        // 디스패치 그룹이 닫히도록 보장
                        defer { dispatchGroup.leave() }
                        
                        // 서버로부터 받아온 url을 data 타입으로 변환
                        guard let data = try? Data(contentsOf: url) else { return }
                        
                        imagesDataDictionary[url.absoluteString] = data
                    }
                }
                
                print("EditDiaryView imagesDictionary \(imagesDataDictionary.count)")
                
                dispatchGroup.notify(queue: .main) {
                    
                    for url in urls {
                        
                        if let url = URL(string: url), let data = imagesDataDictionary[url.absoluteString] {
                            pickedImagesData.append(data)
                        }
                    }
                }
            }
            // 앨범에서 사진을 선택할 경우
            .onChange(of: pickedImageItems) { _ in

                Task {
                    var pickedImagesDataArray: [Data] = []
                    var imagesArray: [ImageItem] = []

                    for item in pickedImageItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            pickedImagesDataArray.append(data)
                            if let image = UIImage(data: data) {
                                imagesArray.append(ImageItem(id: nil, source: .uiImage(image)))
                            }
                        }
                    }

                    pickedImagesData.append(contentsOf: pickedImagesDataArray)
                    images.append(contentsOf: imagesArray)
                    pickedImageItems.removeAll()
                }
            }
        }
    }
}
