//
//  MoimListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/25/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem
import FeatureMoimInterface

struct MoimListView: View {
    let store: StoreOf<MoimListStore>
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    ForEach(1...10, id: \.self) { _ in
                        MoimRequestCell()
                    }
                }
                .padding(20)
            }
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                
            }
        }
    }
}
