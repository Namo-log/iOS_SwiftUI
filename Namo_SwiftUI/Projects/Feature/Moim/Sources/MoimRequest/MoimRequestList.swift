//
//  MoimRequestList.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI

struct MoimRequestList: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10, id: \.self) { index in
                    MoimRequestItem()
                        .padding(.top, 20)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    MoimRequestList()
}
