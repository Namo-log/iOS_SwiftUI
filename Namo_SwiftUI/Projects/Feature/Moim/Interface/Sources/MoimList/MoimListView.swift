//
//  MoimListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI

public struct MoimListView: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...10, id: \.self) { _ in
                    MoimListCell()
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal, 25)
        }        
    }
}
