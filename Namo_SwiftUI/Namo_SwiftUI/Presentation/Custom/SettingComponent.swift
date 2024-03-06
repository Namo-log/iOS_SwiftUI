//
//  SettingComponent.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/24/24.
//

import SwiftUI

struct SettingComponent: View {
    
    @State var title: String
    @State var content: String?
    @State var image: Image?
    @State var action: (() -> Void)?
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .font(Font.pretendard(.bold, size: 15))
                .foregroundStyle(.mainText)
            
            Spacer()
            
            if let content = content {
                
                Text(content)
                    .font(Font.pretendard(.bold, size: 15))
                    .foregroundStyle(.mainText)
            } else if let image = image {
                image
            }
        }
        .padding(.top, 8)
        .background(.white)
        .onTapGesture {

            guard let action = action else {return}
            
            action()
        }
    }
}

#Preview {
    SettingComponent(title: "버전 정보")
}
