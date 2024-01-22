//
//  OnboardingView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

// 온보딩 화면

struct OnboardingView: View {
    
    @State var onboardingIndex = 1
    @State var onboardingSetences: [String] = ["소중한 나의 일정과 기록,\n 어떻게 관리하시나요?", "중요한 일정을 잊지 않도록\n 캘린더에 표시", "일정을 사진과 글로 기록하고\n 한 눈에 모아보세요", "그룹 캘린더에서 친구들 일정 확인 후\n 손쉽게 모임 일정을 잡고", "사진 공유와 금액 정산까지 효율적으로"]
    
    var body: some View {
        
        VStack {
            
            HStack {
                ForEach(1..<6, id: \.self) {index in
                    
                    Circle()
                        .fill(onboardingIndex == index ? Color.mainOrange : Color.textUnselected)
                        .frame(width: 10, height: 10)
                        .padding(8)
                }
            }
            .padding(.top, 50)
            
            TabView(selection: $onboardingIndex) {
                
                ForEach(1..<6, id: \.self) { index in
                    
                    VStack {
                        
                        Text(onboardingSetences[index-1])
                                           .multilineTextAlignment(.center)
                                           .font(Font.pretendard(.bold, size: 18))
                                           .font(.system(size: 20))
                        
                        Spacer()
                    
                        
                        LottieView(fileName: "onboarding\(onboardingIndex)")
                                        .frame(width: onboardingIndex == 2 ? screenWidth - 90 : screenWidth - 50,
                                               height: onboardingIndex == 2 ? screenWidth - 90 : screenWidth - 50)
                                        .id(onboardingIndex)

                                        .padding(.bottom, onboardingIndex == 2 ? 20 : 0)
                                        .padding(.top, -60)
                                        .tag(index)
                        
                        Spacer()
                        
                        }

                    }
            }
            .tabViewStyle(PageTabViewStyle())
            .padding(.top, 35)
            
            if onboardingIndex != 5 {
                
                HStack {
                    Spacer()
                    
                    Button {

                        withAnimation(.easeInOut(duration: 0.5)) {
                            onboardingIndex = 5
                        }
                    } label: {

                        Image(.btnSkip)
                    }
                    .hidden(onboardingIndex == 5)
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
                    
                    if onboardingIndex == 5 {
                        
                        // 화면 이동 로직.
                        // 화면 이동에 대한 플로우가 바뀌어서 아직 화면 이동 로직은 구현하지 않았습니다.
                        
                    } else {
                        onboardingIndex += 1
                    }
                }

            } label: {
                
                if onboardingIndex == 5 {
                    
                    Text("시작하기")
                        .foregroundStyle(.white)
                        .font(Font.pretendard(.bold, size: 18))
                        .frame(width: screenWidth-50, height: 55)
                        .background(Color.mainOrange)
                        .cornerRadius(15)
                    
                } else {
                    
                    Text("다음")
                        .foregroundStyle(Color(.mainOrange))
                        .font(Font.pretendard(.bold, size: 18))
                        .frame(width: screenWidth-50, height: 55)
                        .background(Color.textBackground)
                        .cornerRadius(15)
                }
            }
            .padding(.bottom, 25)
        }
    }
}

#Preview {
    OnboardingView()
}
