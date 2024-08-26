//
//  NamoPopupView.swift
//  SharedDesignSystem
//
//  Created by 권석기 on 8/26/24.
//

import SwiftUI

public struct NamoPopupView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack {
                        Text("닫기")
                        
                        Spacer()
                        
                        Text("게스트 초대")
                        
                        Spacer()
                                                
                    }
                }                                
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding(.horizontal, 30)
        }
    }
}

//#Preview {
//    NamoPopupView()
//}
