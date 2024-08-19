//
//  SettingComponent.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/24/24.
//

import SwiftUI
import Common

struct SettingComponent: View {
    
    var title: String
    var content: String?
    var image: Image?
    var action: (() -> Void)?
    
    var body: some View {
        
        HStack {
            
            Text(title)
                .font(Font.pretendard(.bold, size: 15))
                .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
            
            Spacer()
            
            if let content = content {
                
                Text(content)
                    .font(Font.pretendard(.bold, size: 15))
                    .foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
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
