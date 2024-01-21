//
//  AgreeMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/20/24.
//

import SwiftUI

// 약관 동의 화면

struct AgreeMainView: View {
    
    @State var allAgree: Bool = false
    @State var required1: Bool = false
    @State var required2: Bool = false
    @State var optional1: Bool = false
    @State var optional2: Bool = false
    
    @State var isActive: Bool = false
 
    var body: some View {
 
        // 필수 사항 동의가 됐을 경우 로그인 화면으로 이동
        if isActive {
            
            LoginView()
        } else {
            VStack {
                
                HStack {
                    Text("서비스 이용을 위한")
                        .font(Font.pretendard(.regular, size: 20))
                    Text("약관 동의")
                        .font(Font.pretendard(.bold, size: 20))
                }
                .padding(.top, 80)
                
                Spacer()
                
                HStack {
                    Image(systemName: required1 && required2 && optional1 && optional2 ? "checkmark.circle.fill" : "circle")
                        .onTapGesture {
                            self.required1 = true
                            self.required2 = true
                            self.optional1 = true
                            self.optional2 = true
                        }
                    Text("전체 동의")
                        .padding(.leading)
                    
                    Spacer()
                }
                .padding(.leading, 50)
                .padding(.bottom, 10)
                .padding(.top, -30)
                
                Rectangle()
                    .fill(.black)
                    .frame(width: screenWidth-75, height: 0.5)
                
                CheckItem(toggleText: "(필수) 이용약관", linkURL: "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c", toggleValue: $required1)
                
                CheckItem(toggleText: "(필수) 개인정보 수집 및 이용", linkURL: "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32", toggleValue: $required2)
                CheckItem(toggleText: "(선택) 위치 서비스 이용 약관", linkURL: nil, toggleValue: $optional1)
                CheckItem(toggleText: "(선택) 앱 푸시 알림 수신 동의", linkURL: nil, toggleValue: $optional2)

                Spacer()
                
                Button {
                    
                    isActive.toggle()
                    
                } label: {
                    
                    Text("확인")
                        .foregroundStyle(required1 && required2 ? .white : .mainOrange)
                        .font(Font.pretendard(.bold, size: 17))
                        .frame(width: screenWidth-50, height: 55)
                        .background(required1 && required2 ? Color.mainOrange : .textBackground)
                }
                .disabled(!(required1 && required2))
                .cornerRadius(15)
                .padding(.bottom, 25)
            }
            .navigationBarBackButtonHidden(true)
        }
            
    }
}

struct CheckItem: View {
    
    let toggleText: String
    let linkURL: String?
    @Binding var toggleValue: Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: toggleValue ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    toggleValue.toggle()
                }
            
            Group {
                Text(toggleText)
                    .padding(.leading)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray)
                    .hidden(linkURL == nil)
            }
            .onTapGesture {
                if let urlString = linkURL, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
            .disabled(linkURL == nil)
        }
        .padding(.top, 10)
        .padding(.leading, 50)
        .padding(.trailing, 50)
    }
}

struct OptionalItem: View {
    
    let toggleText: String
    @Binding var toggleValue: Bool
    
    var body: some View {
        
        HStack {
            Image(systemName: toggleValue ? "checkmark.circle.fill" : "circle")
                .onTapGesture {
                    toggleValue.toggle()
                }
            Text(toggleText)
                .padding(.leading)
            
            Spacer()
        }
        .padding(.leading, 50)
    }
}

#Preview {
    AgreeMainView()
}
