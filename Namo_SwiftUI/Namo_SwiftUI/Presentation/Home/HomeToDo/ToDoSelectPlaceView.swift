//
//  ToDoSelectPlaceView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/10/24.
//

import SwiftUI
import Factory

struct ToDoSelectPlaceView: View {
    
    @EnvironmentObject var appState: AppState
    @EnvironmentObject var scheduleState: ScheduleState
    let placeUseCase = PlaceUseCase.shared
    let scheduleUseCase = ScheduleUseCase.shared
    let moimUseCase = MoimUseCase.shared
    
    /// 본 화면의 표시 여부 state
    @Binding var isShowSheet: Bool
    /// 이전 화면의 kakaoMap draw 여부 state
    @Binding var preMapDraw: Bool
    /// 장소의 추가/수정 여부
    @State var isRevise: Bool
    
    /// KakaoMap draw State
    @State var draw: Bool = true
    /// 장소 검색 textField Text state
    @State var searchText: String = ""
    /// 취소/확인 버튼 show state
    @State var showBtns: Bool = false
    /// 임시 저장용 Place
    @State var tempPlace: Place?
    /// 장소 선택 창이 모임 일정용인지
    let isGroup: Bool
    
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KakaoMapView(draw: $draw, pinList: $appState.placeState.placeList, selectedPlace: $appState.placeState.selectedPlace).onAppear(perform: {
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            })
            .frame(height:380)
            .backgroundStyle(.black)
            .zIndex(0)
            
            VStack(alignment: .leading) {
                //MARK: 뒤로 가기 버튼
                CircleItemView {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundStyle(.mainOrange)
                        .font(.system(size: 20))
                }
                .padding(.all, 12)
                .onTapGesture {
                    if !isRevise {
                        if let tempPlace = self.tempPlace {
                            placeUseCase.appendPlaceList(place: tempPlace)
                        } else {
                            placeUseCase.selectPlace(place: nil)
                            placeUseCase.clearPlaces(isSave: false)
                        }
                    }
                    self.dismissThis()
                }
                
                Spacer()
                
                //MARK: 취소/확인 버튼
                if appState.placeState.selectedPlace != nil {
                    HStack {
                        
                        Spacer()
                        Button(action: {
                            if !isRevise {
                                if let tempPlace = self.tempPlace {
                                    placeUseCase.selectPlace(place: tempPlace)
                                } else {
                                    placeUseCase.selectPlace(place: nil)
                                }
                            }
                            self.dismissThis()
                        }) {
                            Text("취소")
                                .font(.pretendard(.bold, size: 15))
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 7, leading: 57, bottom: 7, trailing: 57))
                                .foregroundStyle(.mainOrange)
                                .background(
                                    RoundedRectangle(cornerRadius: 15, style: .circular)
                                        .stroke(.mainOrange, lineWidth: 1)
                                        .background(in: .capsule, fillStyle: .init())
                                        
                                )
                            
                        }
                        Spacer(minLength: 20)
                        Button(action: {
                            if self.isGroup {
                                print("모임에 잘 저장")
                                moimUseCase.setPlaceToCurrentMoimSchedule()
                            } else {
                                scheduleUseCase.setPlaceToCurrentSchedule()
                            }
                            placeUseCase.clearPlaces(isSave: true)
                            self.dismissThis()
                        }) {
                            Text("확인")
                                .font(.pretendard(.bold, size: 15))
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 7, leading: 57, bottom: 7, trailing: 57))
                                .foregroundStyle(.mainOrange)
                                .background(
                                    RoundedRectangle(cornerRadius: 15, style: .circular)
                                        .stroke(.mainOrange, lineWidth: 1)
                                        .background(in: .capsule, fillStyle: .init())
                                        
                                )
                            
                        }
                        Spacer()
                    }
                    .padding(.bottom, 16)
                } //: HStack
               
                //MARK: 지도 아래 검색창 + 장소 리스트 뷰
                placeListView(searchText: $searchText, pinList: $appState.placeState.placeList, selectedPlace: $appState.placeState.selectedPlace, isRevise: $isRevise)
                    .frame(height: 430)
                    .clipShape(.rect(cornerRadius: 15, style: .continuous))
                    .shadow(radius: 12)
            } //: Vstack
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(.white)
        .transition(.move(edge: .trailing))
        .onAppear(perform: {
            Task {
                if isRevise {
                    if isGroup {
                        let temp = self.scheduleState.currentMoimSchedule
                        let result = await placeUseCase.getPlaceList(query: temp.locationName)
                        if let target = result?.first(where: { $0.x == temp.x && $0.y == temp.y }) {
                            placeUseCase.clearPlaces(isSave: false)
                            placeUseCase.appendPlaceList(place: target)
                            placeUseCase.selectPlace(place: target)
                        }
                    } else {
                        let temp = self.scheduleState.currentSchedule
                        let result = await placeUseCase.getPlaceList(query: temp.locationName)
                        if let target = result?.first(where: { $0.x == temp.x && $0.y == temp.y }) {
                            placeUseCase.clearPlaces(isSave: false)
                            placeUseCase.appendPlaceList(place: target)
                            placeUseCase.selectPlace(place: target)
                        }
                    }
                }
            }
        })
    }
    
    /// 현재 SelectPlace 화면을 dismiss하고, 표시될 ToDoEditView의 draw를 준비합니다.
    private func dismissThis() {
        self.preMapDraw = true
        withAnimation {
            self.isShowSheet = false
        }
    }
    
    /// 장소 선택 화면 하단의 검색창 + 장소 리스트를 표시하는 뷰입니다.
    private struct placeListView: View {
        let placeUseCase = PlaceUseCase.shared
        @Binding var searchText: String
        @Binding var pinList: [Place]
        @Binding var selectedPlace: Place?
        @Binding var isRevise: Bool
        
        var body: some View {
            ZStack {
                Color.white.ignoresSafeArea(.all)
                VStack(alignment: .leading) {
                    //MARK: 검색 창
                    HStack {
                        VStack {
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundStyle(.mainText)
                                TextField("장소 입력", text: $searchText)
                                    .foregroundStyle(.mainText)
                            }
                            Color.textPlaceholder
                                .frame(height: 1)
                        }
                        .padding(.trailing, 20)
                        
                        Button(action: {
                            Task {
                                await placeUseCase.fetchPlaceList(query:searchText)
                            }
                        }) {
                            Text("검색")
                                .font(.pretendard(.bold, size: 15))
                                .lineLimit(1)
                                .padding(EdgeInsets(top: 5, leading: 16, bottom: 5, trailing: 16))
                                .foregroundStyle(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                                        .foregroundStyle(.mainOrange)
                                )
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    
                    //MARK: 결과 리스트
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach($pinList, id: \.id) { place in
                                placeListItemView(place: place, selectedPlace: $selectedPlace, isRevise: $isRevise)
                                    .shadow(radius: 3)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .toolbar(.hidden, for: .navigationBar) // 네비게이션 바 hide
        }
    }
    
    /// placeListView에 들어가는 item Cell 뷰입니다
    private struct placeListItemView: View {
        @Binding var place: Place
        @Binding var selectedPlace: Place?
        @Binding var isRevise: Bool
        
        var body: some View {
            HStack {
                VStack(alignment: .leading) {
                    Text(place.name)
                        .font(.pretendard(.bold, size: 14))
                        .padding(.bottom, 3)
                    Text(place.rodeAddress)
                        .font(.pretendard(.regular, size: 12))
                        .padding(.bottom, 1)
                    Text(place.address)
                        .font(.pretendard(.regular, size: 12))
                }
                .padding(.all, 12)
                Spacer()
                if let selectedPlace = self.selectedPlace, place.id == selectedPlace.id {
                    Image(.checkMark)
                        .renderingMode(.template)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundStyle(.mainOrange)
                        .padding(.vertical, 25)
                        .padding(.trailing, 20)
                }
            }
            .background(.textBackground)
            .clipShape(.rect(cornerRadius: 10, style: .continuous))
            .onTapGesture {
                isRevise = false
                NotificationCenter.default.post(name: NSNotification.Name("SendPlace"), object: nil, userInfo: ["place":place])
            }
        }
    }
    
}
//
//#Preview {
//    ToDoSelectPlaceView()
//        
//}
