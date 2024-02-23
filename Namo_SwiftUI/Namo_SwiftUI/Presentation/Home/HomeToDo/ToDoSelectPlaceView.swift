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
    @State var draw: Bool = true

    @State var searchText: String = ""
    @State var showBtns: Bool = false
    
    @Binding var isShowSheet: Bool
    @Binding var preMapDraw: Bool
    
    @Injected(\.placeInteractor) var placeInteractor
    @Injected(\.scheduleInteractor) var scheduleInteractor
    
//    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KakaoMapView(draw: $draw, pinList: $appState.placeState.placeList, selectedPlace: $appState.placeState.selectedPlace).onAppear(perform: {
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            })
            .frame(height:580)
            .backgroundStyle(.black)
            .zIndex(0)
            
            VStack(alignment: .leading) {
                CircleItemView {
                    Image(systemName: "arrow.left")
                        .renderingMode(.template)
                        .foregroundStyle(.mainOrange)
                        .font(.system(size: 20))
                }
                .padding(.all, 12)
                .onTapGesture {
                    placeInteractor.clearPlaces(isSave: false)
                    self.dismissThis()
                }
                Spacer()
                if appState.placeState.selectedPlace != nil {
                    HStack {
                        
                        Spacer()
                        Button(action: {
                            placeInteractor.selectPlace(place: nil)
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
                            scheduleInteractor.setPlaceToScheduleTemp()
                            placeInteractor.clearPlaces(isSave: true)
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
               
                placeListView(searchText: $searchText, pinList: $appState.placeState.placeList, selectedPlace: $appState.placeState.selectedPlace)
                    .frame(height: 280)
                    .clipShape(.rect(cornerRadius: 15, style: .continuous))
                    .shadow(radius: 12)
            } //: Vstack
            .ignoresSafeArea(.all, edges: .bottom)
        }
        .background(.white)
        .transition(.move(edge: .trailing))
    }
    
    /// 현재 SelectPlace 화면을 dismiss하고, 표시될 ToDoCreateView의 draw를 준비합니다.
    private func dismissThis() {
        self.preMapDraw = true
        withAnimation {
            self.isShowSheet = false
        }
    }
    
    private struct placeListView: View {
        @Injected(\.placeInteractor) var placeInteractor
        @Binding var searchText: String
        @Binding var pinList: [Place]
        @Binding var selectedPlace: Place?
        
        var body: some View {
            ZStack {
                Color.white.ignoresSafeArea(.all)
                VStack(alignment: .leading) {
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
                                await placeInteractor.getPlaceList(query:searchText)
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
                    
                    ScrollView {
                        VStack(spacing: 0) {
                            ForEach($pinList, id: \.id) { place in
                                placeListItemView(place: place, selectedPlace: $selectedPlace)
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
    
    private struct placeListItemView: View {
        @Binding var place: Place
        @Binding var selectedPlace: Place?
        
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
                    ColorCircleView(color: .mainOrange, selectState: .checked)
                        .frame(width: 20, height: 20)
                        .padding(.horizontal, 10)
                }
            }
            .background(.textBackground)
            .clipShape(.rect(cornerRadius: 10, style: .continuous))
            .onTapGesture {
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
