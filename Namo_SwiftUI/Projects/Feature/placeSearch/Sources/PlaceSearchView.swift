//
//  PlaceSearchView.swift
//  FeaturePlaceSearch
//
//  Created by 권석기 on 10/20/24.
//

import SwiftUI
import SharedDesignSystem
import ComposableArchitecture
import FeaturePlaceSearchInterface

public struct PlaceSearchView: View {
    @Perception.Bindable private var store: StoreOf<PlaceSearchStore>
    @State var draw: Bool = false
    
    
    public init(store: StoreOf<PlaceSearchStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            VStack(spacing: 0) {
                KakaoMapView(store: store, draw: $draw).onAppear(perform: {
                    self.draw = true
                }).onDisappear(perform: {
                    self.draw = false
                }).frame(maxWidth: .infinity, maxHeight: 380)
                
                VStack {
                    HStack(spacing: 32) {
                        
                        VStack {
                            HStack {
                                Image(asset: SharedDesignSystemAsset.Assets.icSearchGray)
                                
                                TextField("장소 입력", text: $store.searchText)
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundStyle(Color.mainText)
                            }
                            
                            Divider()
                        }
                        
                        
                        Button(action: {
                            store.send(.searchButtonTapped)
                        }, label: {
                            Text("검색")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 6)
                                .background(Color.namoOrange)
                                .cornerRadius(4)
                        })
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    ScrollView {
                        LazyVStack(spacing: 20) {
                            ForEach(store.searchList, id: \.id) { place in
                                Button(action: {
                                    store.send(.poiTapped(place.id))
                                }, label: {
                                    PlaceCell(placeName: place.placeName,
                                              placeAddress: place.addressName,
                                              isSelected: place.id == store.id)
                                })
                            }
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 24)
                        .padding(.bottom, 8)                        
                    }
                }
                .background(.white)
                .clipShape(RoundedCorners(radius: 15, corners: [.topLeft, .topRight]))
                .shadow(color: .black.opacity(0.15), radius: 8, x: 0, y: 0)
                .offset(y: -8)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

//#Preview {
//    PlaceSearchView()
//}
