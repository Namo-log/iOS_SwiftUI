//
//  ParticipantListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI

struct ParticipantListView: View {
    
    var body: some View {
        let item = GridItem(.flexible(), spacing: 0, alignment: .leading)
        let columns = Array(repeating: item, count: 3)
        
        LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
            ForEach(0..<10, id: \.self) { index in
                Participant()                    
            }
        }
    }
}

#Preview {
    ParticipantListView()
}
