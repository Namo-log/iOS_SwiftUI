//
//  AgreeSubView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/21/24.
//

import SwiftUI

struct AgreeSubView: View {

    @ObservedObject var agreeVM: AgreeViewModel
    
    var body: some View {
        
        VStack {
            HStack {
                Image(agreeVM.state.required1 && agreeVM.state.required2 ? .isSelectedTrue : .isSelectedFalse)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        // 전체 동의 버튼 탭
                        agreeVM.action(.onTapAllAgreementBtn)
                    }
                Text("전체 동의")
                    .padding(.leading)
                    .font(Font.pretendard(.regular, size: 18))
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
            
            Rectangle()
                .fill(.textPlaceholder)
                .frame(width: screenWidth-90, height: 0.5)
            
            CheckItem(toggleText: "(필수) 이용약관", linkURL: "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c", toggleValue: $agreeVM.state.required1)
            
            CheckItem(toggleText: "(필수) 개인정보 수집 및 이용", linkURL: "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32", toggleValue: $agreeVM.state.required2)
        }
        .frame(width: screenWidth-90)
    }
}

struct CheckItem: View {
    
    let toggleText: String
    let linkURL: String?
    @Binding var toggleValue: Bool
    
    var body: some View {
        
        VStack {
            HStack {
                Image(toggleValue ? .isSelectedTrue : .isSelectedFalse)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        toggleValue.toggle()
                    }
                
                Group {
                    Text(toggleText)
                        .font(Font.pretendard(.regular, size: 18))
                        .padding(.leading)
                    
                    Spacer()
                    
					Image(.arrowBasic)
                        .hidden(linkURL == nil)
                }
                .onTapGesture {
                    if let urlString = linkURL, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                        
                        DispatchQueue.main.async {
                            UIApplication.shared.open(url)
                        }   
                    }
                }
                .disabled(linkURL == nil)
            }
            .padding(.top, 20)
            .padding(.leading, 15)
        }
        .frame(width: screenWidth - 90)
    }
}

#Preview {
    AgreeSubView(agreeVM: AgreeViewModel())
}
