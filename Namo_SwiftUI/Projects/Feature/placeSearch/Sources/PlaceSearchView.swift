//
//  PlaceSearchView.swift
//  FeaturePlaceSearch
//
//  Created by 권석기 on 10/20/24.
//

import SwiftUI
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
            KakaoMapView(draw: $draw).onAppear(perform: {
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            }).frame(maxWidth: .infinity, maxHeight: 380)
            HStack {
                TextField("", text: $store.searchText)
                    .textFieldStyle(.roundedBorder)
                Button(action: {
                    store.send(.searchButtonTapped)
                }, label: {
                    Text("검색")
                })
            }
            
            Spacer()
        }
        .padding(.horizontal, 30)
    }
}

//#Preview {
//    PlaceSearchView()
//}
