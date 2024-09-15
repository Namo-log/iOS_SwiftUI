//
//  TOSListView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem
import SharedUtil

struct TOSListView: View {
    @State var toggle: Bool = true
    
    var body: some View {
        VStack {
            HStack {
                Image(asset: toggle ? SharedDesignSystemAsset.Assets.isSelectedTrue : SharedDesignSystemAsset.Assets.isSelectedFalse)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        // 전체 동의 버튼 탭
                        toggle.toggle()
                    }
                Text("전체 동의")
                    .padding(.leading)
                    .font(Font.pretendard(.regular, size: 18))
                
                Spacer()
            }
            .padding(.leading, 15)
            .padding(.bottom, 20)
            
            Rectangle()
                .fill(Color(asset: SharedDesignSystemAsset.Assets.textPlaceholder))
                .frame(width: screenWidth-90, height: 0.5)
            
//            CheckItem(toggleText: "(필수) 이용약관", linkURL: "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c", toggleValue: $agreeVM.state.required1)
//            
//            CheckItem(toggleText: "(필수) 개인정보 수집 및 이용", linkURL: "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32", toggleValue: $agreeVM.state.required2)
        }
        .frame(width: screenWidth-90)
    }
}

extension TOSListView {
    
    /// 약관 동의에 사용되는 약관 모델입니다.
    public struct AgreementItem {
        /// 약관 제목
        public let title: String
        /// 약관 링크
        public let URL: String?
        /// 필수 여부
        public let isRequired: Bool
    }
    
    /// 약관 목록 아이템뷰입니다.
    struct CheckItem: View {
        
        let text: String
        let linkURL: String?
        @Binding var toggleValue: Bool
        
        var body: some View {
            
            VStack {
                HStack {
                    Image(asset: toggleValue ? SharedDesignSystemAsset.Assets.isSelectedTrue : SharedDesignSystemAsset.Assets.isSelectedFalse)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .onTapGesture {
                            toggleValue.toggle()
                        }
                    
                    Group {
                        Text(text)
                            .font(Font.pretendard(.regular, size: 18))
                            .padding(.leading)
                        
                        Spacer()
                        
                        Image(asset: SharedDesignSystemAsset.Assets.arrowBasic)
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
}
