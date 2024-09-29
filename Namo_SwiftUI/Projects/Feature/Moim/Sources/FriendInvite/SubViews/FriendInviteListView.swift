//
//  FriendInviteListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI

struct FriendInviteListView: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(0..<10, id:\.self) { _ in
                    FriendAddItem(isSelected: .constant(false))
                }
            } .padding(.horizontal, 25)
        }
        .padding(.top, 16)
    }
}

#Preview {
    FriendInviteListView()
}
