//
//  CircleItemView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/19/24.
//

import SwiftUI

struct CircleItemView<Content: View>: View {
    
    let content: () -> Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(.white)
                .frame(width: 40, height: 40)
                .shadow(radius: 2)
            content()
        }
        
    }
}
