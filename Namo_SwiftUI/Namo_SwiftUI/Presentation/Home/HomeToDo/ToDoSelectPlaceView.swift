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
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KakaoMapView(draw: $draw, pinList: $appState.scheduleState.placeList).onAppear(perform: {
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
                    dismiss()
                }
                Spacer()
                if !showBtns {
                    HStack {
                        
                        Spacer()
                        Button(action: {}) {
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
                            print(appState.scheduleState.placeList)
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
               
                placeListView(searchText: $searchText, pinList: $appState.scheduleState.placeList)
                    .frame(height: 280)
                    .clipShape(.rect(cornerRadius: 15, style: .continuous))
                    .shadow(radius: 12)
            } //: Vstack
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private struct placeListView: View {
        @Binding var searchText: String
        @Binding var pinList: [Place]
        @Injected(\.scheduleInteractor) var scheduleInteractor
        
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
                                // Interactor + Repository로 추후 변경
                                APIManager.shared.KakaoMapAPIRequest(query: searchText) { result,err  in
                                    let searchResult = result?.documents.map {$0.toPlace()} ?? []
                                    pinList = searchResult
                                }
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
                        ForEach($pinList, id: \.id) { place in
                            placeListItemView(place: place, onTapGesture: {
//                                let poiId = String(place.wrappedValue.id)
//                                kakaoMapCoordinator.selectPoi(poiID: poiId)
                            })
                                .shadow(radius: 3)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
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
        var onTapGesture: () -> Void
        
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
            }
            .background(.textBackground)
            .clipShape(.rect(cornerRadius: 10, style: .continuous))
            .onTapGesture {
                onTapGesture()
                NotificationCenter.default.post(name: NSNotification.Name("SendPlace"), object: nil, userInfo: ["place":place])
            }
        }
    }
    
}

#Preview {
    ToDoSelectPlaceView()
        
}
