////
////  EditMoimDiaryView.swift
////  Namo_SwiftUI
////
////  Created by 서은수 on 3/5/24.
////
//
//import SwiftUI
//import Factory
//
//import CoreNetwork
//import SharedDesignSystem
//import SharedUtil
//
//// 모임 기록 추가 및 수정 화면
//struct EditMoimDiaryView: View {
//    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
//    @EnvironmentObject var appState: AppState
//    @EnvironmentObject var diaryState: DiaryState
//    let moimDiaryUseCase = MoimDiaryUseCase.shared
////    let scheduleUseCase = ScheduleUseCase.shared
//    
//    @State private var showParticipants: Bool = true
//    @State private var showAddPlaceButton: Bool = true
//    @State private var showCalculateAlert: Bool = false
//    @State var activities = [ActivityDTO()]
//    @State var currentCalculateIndex: Int = 0
//    @State var cost: String = ""
//    @State var activityImages: [[ImageItem]] = [[], [], []]
//	@State var deleteImageIds: [[Int]] = [[], [], []]
//    
//    let info: ScheduleInfo
//    let moimUser: [GroupUser]
//    let gridColumn: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
//    
//    @State var selectedUser: [GroupUser] = []
//    @State var finalUserIdList: [[Int]] = [[], [], []] // API 호출 시 최종적으로 들어가는 정산 참여자 id
//	
//	// 삭제된 활동 API call 하기 위해 저장
//	@State var deleteActivities: [ActivityDTO] = []
//    
//    /// 활동 이름 입력 요구 토스트 뷰 활성화 여부
//    @State var showActivityNameToastView: Bool = false
//    
//    /// 활동 정산 금액 입력 요구 토스트 뷰 활성화 여부
//    @State var showActivityMoneyToastView: Bool = false
//    
//    /// 이미지 상세보기 화면 활성화 여부
//    @State var showImageDetailViewSheet: Bool = false
//    
//    /// 이미지 상세보기 화면에 전달할 이미지 인덱스
//    @State var selectedImageIndex: Int = 0
//    
//    /// 이미지 상세보기 페이지에 전달할 이미지 목록
//    @State var imagesForImageDetail: [ImageItem] = []
//    
//    /// 컨텐츠가 바뀌었는지 여부
//    @State var isChangedContents: Bool = false
//    /// 컨텐츠가 바뀌었을 때 저장하지 않고 뒤로가기할 시 나타나는 Alert
//    @State var showIsChangedAlert: Bool = false
//    
//    // 모임 정산 Alert
//    var groupCalculateAlertView: some View {
//        NamoAlertViewWithTopButton(
//            showAlert: $showCalculateAlert,
//            title: "정산 페이지",
//            leftButtonTitle: "닫기",
//            leftButtonAction: {
//                showCalculateAlert = false
//            },
//            rightButtonTitle: "저장",
//            rightButtonAction: {
//				activities[currentCalculateIndex].money = Int(cost) ?? 0
//				activities[currentCalculateIndex].participants = selectedUser.map({$0.userId})
//				finalUserIdList[currentCalculateIndex] = selectedUser.map({$0.userId})
//                showCalculateAlert = false
//                return true
//            },
//            content: AnyView(
//                VStack(spacing: 20) {
//                    HStack(spacing: 0) {
//                        Text("총 금액")
//                            .font(.pretendard(.bold, size: 15))
//                        Spacer()
//                        HStack(spacing: 0) {
//                            TextField("금액 입력", text: $cost)
//                                .keyboardType(.numberPad)
//                                .multilineTextAlignment(.trailing)
//                            
//                            if (cost != "") {
//                                Text(" 원")
//                            }
//                        }
//                        .frame(width: (screenWidth-90)/2, height: 30)
//                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                        .padding(.trailing, 10)
//                        .background(Color(asset: SharedDesignSystemAsset.Assets.mainGray))
//                        .clipShape(RoundedRectangle(cornerRadius: 8))
//                        .font(.pretendard(.regular, size: 15))
//                        
//                    }
//                    
//                    HStack {
//                        Text("인원 수")
//                            .font(.pretendard(.bold, size: 15))
//                        Spacer()
//                        HStack {
//                            Text("÷")
//                                .font(.pretendard(.regular, size: 15))
//                            Spacer()
//                            Text("\(selectedUser.count) 명")
//                                .font(.pretendard(.regular, size: 15))
//                        }
//                        .frame(width: (screenWidth-90)/2)
//                        .overlay(alignment: .bottom) {
//                            Rectangle()
//                                .fill(Color.black)
//                                .frame(height: 1)
//                                .offset(y: 10)
//                        }
//                    }
//                    
//                    HStack {
//                        Text("인당 금액")
//                            .font(.pretendard(.bold, size: 15))
//                        Spacer()
//                        if selectedUser.count == 0 {
//                            Text("0 원")
//                                .font(.pretendard(.regular, size: 15))
//                        } else {
//                            Text("\((Int(cost) ?? 0) / selectedUser.count) 원")
//                                .font(.pretendard(.regular, size: 15))
//                        }
//                    }
//                    
//                    LazyVGrid(columns: gridColumn) {
//                        ForEach(moimUser, id: \.userId) { user in
//                            HStack(spacing: 20) {
//                                Button(
//                                    action: {
//                                        if selectedUser.contains(where: {$0.userId == user.userId}) {
//                                            selectedUser.removeAll(where: {$0.userId == user.userId})
//                                        } else {
//                                            selectedUser.append(user)
//                                        }
//                                    }, label: {
//										Image(asset: selectedUser.contains(where: {$0.userId == user.userId}) ? SharedDesignSystemAsset.Assets.isSelectedTrue : SharedDesignSystemAsset.Assets.isSelectedFalse)
//                                            .resizable()
//                                            .frame(width: 20, height: 20)
//                                    }
//                                )
//                                
//                                Text(user.userName)
//                                Spacer()
//                            }
//                        }
//                    }
//                    
//                }
//                    .padding(.top, 25)
//                    .padding(.bottom, 33)
//                    .onChange(of: selectedUser) { _ in
//                        isChangedContents = true
//                    }
//            )
//        )
//    }
//    
//    var body: some View {
//        ZStack() {
//            VStack(alignment: .center, spacing: 0) {
//                ScrollView(.vertical) {
//                    VStack(alignment: .leading, spacing: 0) {
//                        // 날짜와 장소 정보
//                        DatePlaceInfoView(date: info.date, place: info.place)
//                        
//                        // 참석자
//                        HStack(alignment: .top) {
//                            Text("참석자 (\(moimUser.count))")
//                                .font(.pretendard(.bold, size: 15))
//                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                            Spacer()
//							Image(asset: showParticipants ? SharedDesignSystemAsset.Assets.upChevronBold : SharedDesignSystemAsset.Assets.downChevronBold)
//                                .renderingMode(.template)
//                        }
//                        .onTapGesture {
//                            withAnimation(.easeInOut(duration: 0.2)) {
//                                self.showParticipants.toggle()
//                            }
//                        }
//                        .padding(.top, 25)
//                        
//                        // 참석자 동그라미 뷰
//                        if showParticipants {
//                            HStack(spacing: 10) {
//                                ForEach(moimUser, id: \.self) { user in
//                                    Circle()
//                                        .stroke(Color(asset: SharedDesignSystemAsset.Assets.textUnselected), lineWidth: 2)
//                                        .frame(width: 42, height: 42)
//                                        .overlay {
//                                            Text(user.userName)
//                                                .font(.pretendard(.bold, size: 11))
//                                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.textPlaceholder))
//                                        }
//                                }
//                            }
//                            .padding(.top, 15)
//                        }
//                        
//                        // 장소 뷰
//						ForEach(0..<activities.count, id: \.self) { index in
//                            MoimPlaceView(showCalculateAlert: $showCalculateAlert,
//                                          activity: $activities[index],
//                                          name: $activities[index].name,
//                                          currentCalculateIndex: $currentCalculateIndex,
////                                          pickedImagesData: $activityImages[index],
//										  deleteImageIds: $deleteImageIds[index],
//										  imageItems: $activityImages[index],
//                                          showImageDetailViewSheet: $showImageDetailViewSheet,
//                                          selectedImageIndex: $selectedImageIndex,
//                                          imagesForImageDetail: $imagesForImageDetail,
//                                          isChangedContents: $isChangedContents,
//                                          showIsChangedAlert: $showIsChangedAlert,
//                                          index: index,
//                                          deleteAction: {
//                                deleteActivities.append(activities.remove(at: index))
//                                finalUserIdList.remove(at: index)
//                            })
//                        }
//                    } // VStack - leading
//                    .padding(.top, 12)
//                    .padding(.leading, 25)
//                    .padding(.trailing, 25)
//                    
//                    // 활동 추가 버튼
//                    if showAddPlaceButton {
//                        Button {
//							if activities.count == 2 {
//                                showAddPlaceButton = false
//                            }
//                            
//                            if activities.count < 3 {
//                                withAnimation(.easeIn(duration: 0.2)) {
//									activities.append(ActivityDTO(id: 0, name: "", money: 0, participants: [], images: []))
//                                }
//                            }
//                        } label: {
//							BlackBorderRoundedView(text: "활동 추가", image: Image(asset: SharedDesignSystemAsset.Assets.icMap), width: 136, height: 40)
//                                .padding(.top, 25)
//                        }
//                    }
//                } // ScrollView
//                
//                EditSaveDiaryView
//            } // VStack - center
//            
//            // 쓰레기통 클릭 시 Alert 띄우기
//            if appState.isDeletingDiary {
//                Color.black.opacity(0.3)
//                    .ignoresSafeArea(.all, edges: .all)
//                
//                AlertViewOld(
//                    showAlert: $appState.isDeletingDiary,
//                    content: AnyView(
//                        VStack(alignment: .center, spacing: 10) {
//                            Text("모임 기록을 정말 삭제하시겠어요?")
//                                .font(.pretendard(.bold, size: 16))
//                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                .padding(.top, 24)
//                            Text("삭제한 모임 기록은\n개인 기록 페이지에서도 삭제됩니다.")
//                                .font(.pretendard(.light, size: 14))
//                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                .multilineTextAlignment(.center)
//                        }
//                        .padding(.bottom, 5)
//                    ),
//                    leftButtonTitle: "취소",
//                    leftButtonAction: {},
//                    rightButtonTitle: "삭제") {
//                        print("모임 기록 삭제")
//                        Task {
//                            // 모임 기록 삭제
//                            await moimDiaryUseCase.deleteMoimDiary(moimScheduleId: info.scheduleId)
//                            
//                            await MainActor.run {
//                                NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil)
//                            }
//                            
//                            self.presentationMode.wrappedValue.dismiss()
//                        }
//                    }
//            }
//            
//            // 정산 Alert 뷰
//            if showCalculateAlert {
//                groupCalculateAlertView
//            }
//            
//            if showActivityNameToastView {
//                
//                ToastViewNew(toastMessage: "활동 이름을 입력해주세요!", bottomPadding: screenHeight / 7)
//                    .onAppear {
//                        
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            
//                            withAnimation {
//                                showActivityNameToastView = false
//                            }
//                        }
//                    }
//            }
//            
//            if showActivityMoneyToastView {
//                
//                ToastViewNew(toastMessage: "모임 참여자를 선택해주세요!", bottomPadding: screenHeight / 7)
//                    .onAppear {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                            
//                            withAnimation {
//                                showActivityMoneyToastView = false
//                            }
//                        }
//                    }
//            }
//            
//            if showIsChangedAlert {
//                
//                AlertViewOld(showAlert: $showIsChangedAlert,
//                             content: AnyView(
//                                
//                                VStack(spacing: 8) {
//                                    
//                                    Text("편집한 내용이 저장되지 않습니다.")
//                                        .font(Font.pretendard(.bold, size: 16))
//                                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                        .padding(.top, 24)
//                                    
//                                    Text("정말 나가시겠어요?")
//                                        .font(Font.pretendard(.regular, size: 14))
//                                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                        .padding(.bottom, 3)
//                                    
//                                }
//                                
//                             ),
//                             leftButtonTitle: "취소",
//                             rightButtonTitle: "확인",
//                             rightButtonAction: {
//                    self.presentationMode.wrappedValue.dismiss()
////                    scheduleUseCase.setScheduleToCurrentSchedule(schedule: nil)
////                    scheduleUseCase.setScheduleToCurrentMoimSchedule(schedule: nil, users: nil)
//                })
//            }
//            
//            
//        } // ZStack
//        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(
//            leading: DismissButton(isDeletingDiary: $appState.isDeletingDiary, isChangedContents: $isChangedContents, showIsChangedAlert: $showIsChangedAlert),
//            trailing: appState.isEditingDiary ? TrashView() : nil
//        )
//        .navigationTitle(info.scheduleName)
//        .ignoresSafeArea(edges: .bottom)
////        .fullScreenCover(isPresented: $showImageDetailViewSheet) {
////            
////            ImageDetailView(isShowImageDetailScreen: $showImageDetailViewSheet, imageIndex: $selectedImageIndex, images: imagesForImageDetail)
////            
////        }
//        .onAppear {
//            Task {
//                self.activities.removeAll()
//				if appState.isEditingDiary {
//					await moimDiaryUseCase.getOneMoimDiary(moimScheduleId: info.scheduleId)
//				}
//                self.activities = diaryState.currentMoimDiaryInfo.moimActivityDtos ?? []
//                
//                // 화면 진입 시 활동의 개수가 2개 이상(3개)라면 활동 추가 버튼을 보이지 않게 함.
//                if activities.count > 2 {
//                    showAddPlaceButton = false
//                }
//            }
//        }
//        .onAppear (perform : UIApplication.shared.hideKeyboard)
//        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("UpdateCalculateInfo"))) { noti in
//            if let userInfo = noti.userInfo, let currentCalculateIndex = userInfo["currentCalculateIndex"] as? Int {
//                Task {
//                    if currentCalculateIndex < activities.count {
//                        self.cost = String(activities[currentCalculateIndex].money)
//                        self.selectedUser.removeAll()
//                        for i in activities[currentCalculateIndex].participants {
//                            self.selectedUser.append(GroupUser(userId: i, userName: "", color: 0))
//                        }
//                    } else {
//                        self.cost = "0"
//                        self.selectedUser = []
//                    }
//                }
//            }
//        }
//        .onDisappear {
//            diaryState.currentMoimDiaryInfo = .init()
//        }
//        .onChange(of: activities.count) { _ in
//            
//            if activities.count <= 2 {
//                showAddPlaceButton = true
//                
//            }
//        }
//    }
//    
//    // 모임 기록 수정 완료 버튼 또는 기록 저장 버튼
//    private var EditSaveDiaryView: some View {
//        Button {
//            
//            // 수정 화면이라면
//            if appState.isEditingDiary {
//                Task {
//                    
//                    // 활동 중 하나라도 이름이 입력되지 않았다면
//                    if hasNoActivtyName(activities: activities) {
//                        
//                        withAnimation {
//                            showActivityNameToastView = true
//                        }
//                        
//                        // 활동 중 하나라도 정산 금액이 입력되지 않았다면
//                    } else if hasNoActivityParticipants(activities: activities) {
//                        
//                        withAnimation {
//                            showActivityMoneyToastView = true
//                        }
//                        
//                    } else {
//                        
//                        // 활동 편집
//                        for i in 0..<activities.count {
//                            if activities.indices.contains(i) {
//                                let moimActivityId = activities[i].moimActivityId
//								var imagesData = activityImages[i].compactMap { item in
//									if case let .uiImage(image) = item.source {
//										return image.jpegData(compressionQuality: 0.2)
//									}
//									return nil
//								}
//								if finalUserIdList[i].isEmpty {
//									finalUserIdList[i] = activities[i].participants
//								}
//								
//								let req = EditMoimDiaryPlaceReqDTO(name: activities[i].name, money: String(activities[i].money), participants: finalUserIdList[i], imgs: imagesData)
//                                if moimActivityId == 0 {
//                                    let res = await moimDiaryUseCase.createMoimDiaryPlace(moimScheduleId: info.scheduleId, req: req)
//                                } else {
//									let res = await moimDiaryUseCase.changeMoimDiaryPlace(activityId: moimActivityId, req: req, deleteImageIds: deleteImageIds[i])
//
//                                }
//                            }
//                        }
//                        
//                        // 활동 삭제
//                        for activity in deleteActivities {
//                            let _ = await moimDiaryUseCase.deleteMoimDiaryPlace(activityId: activity.moimActivityId)
//                        }
//                        DispatchQueue.main.async {
//                            NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil, userInfo: nil)
//                        }
//                        
//                        self.presentationMode.wrappedValue.dismiss()
//                        
//                    }
//                }
//            // 추가 화면이라면
//            } else {
//                
//                Task {
//                    
//                    // 활동 중 하나라도 이름이 입력되지 않았다면
//                    if hasNoActivtyName(activities: activities) {
//                        
//                        withAnimation {
//                            showActivityNameToastView = true
//                        }
//
//                        // 활동 중 하나라도 정산 금액이 입력되지 않았다면
//                    } else if hasNoActivityParticipants(activities: activities) {
//                        
//                        withAnimation {
//                            showActivityMoneyToastView = true
//                        }
//                        
//                    } else {
//                        
//                        // 활동 추가
//                        for i in 0..<activities.count {
//							var imagesData = activityImages[i].compactMap { item in
//								if case let .uiImage(image) = item.source {
//									return image.jpegData(compressionQuality: 0.2)
//								}
//								return nil
//							}
//							
//							let req = EditMoimDiaryPlaceReqDTO(name: activities[i].name, money: String(activities[i].money), participants: activities[i].participants, imgs: imagesData)
//                            let _ = await moimDiaryUseCase.createMoimDiaryPlace(moimScheduleId: info.scheduleId, req: req)
//                        }
//                        
//                        // 활동 삭제
//                        for activity in deleteActivities {
//                            let _ = await moimDiaryUseCase.deleteMoimDiaryPlace(activityId: activity.moimActivityId)
//                        }
//                        
//                        DispatchQueue.main.async {
//                            NotificationCenter.default.post(name: .reloadGroupCalendarViaNetwork, object: nil, userInfo: nil)
//                        }
//                        
//                        self.presentationMode.wrappedValue.dismiss()
//                        
//                    }
//                }
//            }
//
//        } label: {
//            ZStack() {
//                Rectangle()
//					.fill(appState.isEditingDiary ? .white : Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
//                    .frame(height: 60 + 10) // 하단의 Safe Area 영역 칠한 거 높이 10으로 가정
//                    .shadow(color: .black.opacity(0.25), radius: 7)
//                
//                Text(appState.isEditingDiary ? "기록 수정" : "기록 저장")
//                    .font(.pretendard(.bold, size: 15))
//                    .foregroundStyle(appState.isEditingDiary ? Color(asset: SharedDesignSystemAsset.Assets.mainOrange) : .white)
//                    .padding(.bottom, 10) // Safe Area 칠한만큼
//            }
//        }
//    }
//    
//    // 활동 이름이 입력되지 않았음을 검사하는 메소드
//    func hasNoActivtyName(activities: [ActivityDTO]) -> Bool {
//        
//        let activityNames = activities.map { $0.name }
//        return activityNames.contains { $0 == "" }
//    }
//    
//    // 활동의 참여자가 입력되지 않았음을 검사하는 메소드
//    func hasNoActivityParticipants(activities: [ActivityDTO]) -> Bool {
//        
//        let activityParticipants = activities.map { $0.participants }
//        
//        return activityParticipants.contains { $0 == [] }
//    }
//}
//
