//
//  SettingView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/24/24.
//

import SwiftUI
import Factory

struct SettingView: View {
    
    @EnvironmentObject var appState: AppState
    @Injected(\.authInteractor) var authInteractor
    
    @State var showLogoutAlert: Bool = false
    @State var showDeleteAccountAlert: Bool = false
    @State private var isBackBtnDisabled = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        ZStack {
            
            VStack(spacing: 13){
               
                SettingComponent(title: "버전 정보", content: "1.0.4(1)")
                
                customDivider
                
                SettingComponent(title: "이용 약관", image: Image("ArrowBasic"), action: {
                    guard let url = URL(string: "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c") else {
                        return
                    }
                    
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url)
                    }
                })
                
                customDivider
                
                SettingComponent(title: "개인 정보 처리 방침", image: Image("ArrowBasic"), action: {
                    
                    guard let url = URL(string: "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32") else {
                        return
                    }
                    UIApplication.shared.open(url)
                })
                
                customDivider
                
                SettingComponent(title: "로그아웃", action: {
                    
                    showLogoutAlert = true
                })
                
                customDivider
                
                SettingComponent(title: "회원탈퇴", action: {
                    
                    showDeleteAccountAlert = true
                })
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 30)
            
            if showLogoutAlert {
                NamoAlertView(showAlert: $showLogoutAlert,
                              content: AnyView(
                                VStack(spacing: 0) {
                                    Text("로그아웃 하시겠어요?")
                                        .font(Font.pretendard(.bold, size: 16))
                                        .foregroundStyle(.mainText)
                                        .frame(height: 22)
                                }
                                .frame(height: 66)
                                .offset(y: 8)
                              ),
                              leftButtonTitle: "취소",
                              leftButtonAction: {},
                              rightButtonTitle: "확인",
                              rightButtonAction: {
                                Task {
                                    await authInteractor.logout()
                                }
                            })
            } else if showDeleteAccountAlert  {
                NamoAlertView(showAlert: $showDeleteAccountAlert,
                              content: AnyView(
                                VStack(spacing: 8) {
                                    Text("정말 계정을 삭제하시겠어요?")
                                        .font(Font.pretendard(.bold, size: 16))
                                        .foregroundStyle(.mainText)
                                        .frame(height: 22)
                                    
                                    Text("지금까지의 정보가 모두 사라집니다.")
                                        .font(Font.pretendard(.regular, size: 14))
                                        .foregroundStyle(.mainText)
                                        .frame(height: 20)
                                }
                                .frame(height: 66)
                                .offset(y: 8)
                              ),
                              leftButtonTitle: "취소",
                              leftButtonAction: {},
                              rightButtonTitle: "확인",
                              rightButtonAction: 
                                {
                    Task {
                        await authInteractor.withdrawMember()
                    }
                })
            }
        }
        .navigationTitle("설정")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image("Arrow")
                        .padding(.leading, 15)
                }
                .disabled(isBackBtnDisabled)
            }
        }
        .onChange(of: showLogoutAlert) { newValue in
            
            if !newValue {isBackBtnDisabled = false
            } else {
                isBackBtnDisabled = true
            }
        }
        .onChange(of: showDeleteAccountAlert) { newValue in
            
            if !newValue {
                isBackBtnDisabled = false
            } else {
                isBackBtnDisabled = true
            }
        }
        }
    }
    
    var customDivider: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundStyle(.textPlaceholder)
    }


#Preview {
    SettingView()
        .environmentObject(AppState())
}
