//
//  ToDoSelectPlaceView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/10/24.
//

import SwiftUI

struct ToDoSelectPlaceView: View {
    
    @State var draw: Bool = true
    @State var pinList: [Place] = [
        Place(id: 0, x: 0.0, y: 1.1, name: "탐앤탐스 탐스커버리 건대점", address: "서울 광진구 뭐시기", rodeAddress: "뭐시기 뭐시기"),
        Place(id: 1, x: 0.0, y: 1.1, name: "zxcv", address: "zcxv", rodeAddress: "zxcv"),
        Place(id: 2, x: 0.0, y: 1.1, name: "qwre", address: "qwer", rodeAddress: "reqw"),
        Place(id: 3, x: 0.0, y: 1.1, name: "vcbx", address: "xvbc", rodeAddress: "xbcv")
    ]
    @State var searchText: String = ""
    @State var showBtns: Bool = false
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            KakaoMapView(draw: $draw, pinList: $pinList).onAppear(perform: {
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            })
            .frame(width: 300, height:100)
            .backgroundStyle(.black)
            .zIndex(0)
            
            VStack(alignment: .leading) {
                circleItemView()
                    .padding(.all, 12)
                Spacer()
                if showBtns {
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
                        Button(action: {}) {
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
               
                placeListView(searchText: $searchText, pinList: $pinList)
                    .frame(height: 480)
                    .clipShape(.rect(cornerRadius: 15, style: .continuous))
                    .shadow(radius: 12)
            } //: Vstack
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private struct placeListView: View {
        @Binding var searchText: String
        @Binding var pinList: [Place]
        
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
                        ForEach(pinList, id: \.id) { place in
                            placeListItemView(place: place)
                                .shadow(radius: 3)
                                .padding(.vertical, 10)
                                .padding(.horizontal, 20)
                        }
                    }
                    
                    Spacer()
                }
            }
        }
    }
    
    private struct placeListItemView: View {
        @State var place: Place
        
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
        }
    }
    
    private struct circleItemView: View {
        var body: some View {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 40, height: 40)
                    .shadow(radius: 2)
                Image(systemName: "arrow.left")
                    .renderingMode(.template)
                    .foregroundStyle(.mainOrange)
                    .font(.system(size: 20))
            }
            
        }
    }
}

#Preview {
    ToDoSelectPlaceView()
        
}
