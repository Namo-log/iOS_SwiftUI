//
//  ParticipantListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI

struct ParticipantListView: View {
    
    var body: some View {
        Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 12) {
            ForEach(0..<10, id: \.self) { index in
                
            }
        }
    }
}

#Preview {
    ParticipantListView()
}
