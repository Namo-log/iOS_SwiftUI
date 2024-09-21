//
//  OnboardingView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

// 온보딩 화면

struct OnboardingView: View {
    
    let onboardingSetences: [String] = ["소중한 나의 일정과 기록,\n 어떻게 관리하시나요?", "중요한 일정을 잊지 않도록\n 캘린더에 표시", "일정을 사진과 글로 기록하고\n 한 눈에 모아보세요", "그룹 캘린더에서 친구들 일정 확인 후\n 손쉽게 모임 일정을 잡고", "사진 공유와 금액 정산까지 효율적으로"]
    
    @StateObject var onboardingVM: OnboardingViewModel = .init()
    
    var body: some View {
        
        if !onboardingVM.state.goToLogin {
            
            VStack {
                
                HStack {
                    ForEach(1..<6, id: \.self) {index in
                        
                        Circle()
                            .fill(onboardingVM.state.onboardingIndex == index ? Color(asset: SharedDesignSystemAsset.Assets.mainOrange) : Color(asset: SharedDesignSystemAsset.Assets.textUnselected))
                            .frame(width: 10, height: 10)
                            .padding(8)
                    }
                }
                .padding(.top, 50)
                
                TabView(selection: $onboardingVM.state.onboardingIndex) {
                    
                    ForEach(1..<6, id: \.self) { index in
                        
                        VStack {
                            
                            Text(onboardingSetences[index-1])
                                               .multilineTextAlignment(.center)
                                               .font(Font.pretendard(.bold, size: 18))
                                               .font(.system(size: 20))
                            
                            Spacer()
                        
                            
                            LottieView(fileName: "onboarding\(onboardingVM.state.onboardingIndex)")
                                            .frame(width: onboardingVM.state.onboardingIndex == 2 ? screenWidth - 90 : screenWidth - 50,
                                                   height: onboardingVM.state.onboardingIndex == 2 ? screenWidth - 90 : screenWidth - 50)
                                            .id(onboardingVM.state.onboardingIndex)

                                            .padding(.bottom, onboardingVM.state.onboardingIndex == 2 ? 20 : 0)
                                            .padding(.top, -60)
                                            .tag(index)
                            
                            Spacer()
                            
                            }
                        }
                }
                .tabViewStyle(PageTabViewStyle())
                .padding(.top, 35)
                
                if onboardingVM.state.onboardingIndex != 5 {
                    
                    HStack {
                        Spacer()
                        
                        Button {

                            withAnimation(.easeInOut(duration: 0.5)) {
                                onboardingVM.state.onboardingIndex = 5
                            }
                        } label: {
							Image(asset: SharedDesignSystemAsset.Assets.btnSkip)
                        }
                        .hidden(onboardingVM.state.onboardingIndex == 5)
                        .padding(.trailing, 35)
                    }
                    .padding(.bottom, 15)
                    
                } else {
                    
                    VStack {
                        
                        HStack(spacing: 0) {
                            Text("나의 모임 기록 ")
                                .font(Font.pretendard(.regular, size: 18))
                            Text("나모")
                                .font(Font.pretendard(.bold, size: 18))
                        }
                        Text("지금 바로 시작하세요")
                            .font(Font.pretendard(.regular, size: 18))
                    }
                    .padding(.bottom, 30)
                }
                
                Button {

                    withAnimation(.easeInOut(duration: 0.25)) {
                        
                        onboardingVM.onTapNextBtn()
                        
                    }

                } label: {
                    
                    if onboardingVM.state.onboardingIndex == 5 {
                        
                        Text("시작하기")
                            .foregroundStyle(.white)
                            .font(Font.pretendard(.bold, size: 18))
                            .frame(width: screenWidth-50, height: 55)
                            .background(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
                            .cornerRadius(15)
                        
                    } else {
                        
                        Text("다음")
							.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
                            .font(Font.pretendard(.bold, size: 18))
                            .frame(width: screenWidth-50, height: 55)
                            .background(Color.itemBackground)
                            .cornerRadius(15)
                    }
                }
                .padding(.bottom, 25)
            }
            .padding(.vertical, 30)
            
        } else {
            LoginView()
        }
    }
}

#Preview {
    OnboardingView()
        .environmentObject(AppState())
}
