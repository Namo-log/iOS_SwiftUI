////
////  SettingView.swift
////  Namo_SwiftUI
////
////  Created by 고성민 on 2/24/24.
////
//
//import SwiftUI
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//
//struct SettingView: View {
//    
//    @StateObject var settingVM: SettingViewModel = .init()
//    @EnvironmentObject var appState: AppState
//    @Environment(\.dismiss) var dismiss
//
//    var body: some View {
//        
//        ZStack {
//            
//            VStack(spacing: 13){
//               
//                SettingComponent(title: "버전 정보", content: version)
//                
//                customDivider
//                
//                SettingComponent(title: "이용 약관", image: Image("ArrowBasic"), action: {
//                    guard let url = URL(string: "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c") else {
//                        return
//                    }
//                    
//                    DispatchQueue.main.async {
//                        UIApplication.shared.open(url)
//                    }
//                })
//                
//                customDivider
//                
//                SettingComponent(title: "개인 정보 처리 방침", image: Image("ArrowBasic"), action: {
//                    
//                    guard let url = URL(string: "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32") else {
//                        return
//                    }
//                    UIApplication.shared.open(url)
//                })
//                
//                customDivider
//                
//                SettingComponent(title: "로그아웃", action: {
//                    
//                    settingVM.state.showLogoutAlert = true
//                })
//                
//                customDivider
//                
//                SettingComponent(title: "회원탈퇴", action: {
//                    
//                    settingVM.state.showDeleteAccountAlert = true
//                })
//                
//                Spacer()
//            }
//            .padding(.horizontal, 16)
//            .padding(.top, 30)
//            
//            if settingVM.state.showLogoutAlert {
//                AlertViewOld(showAlert: $settingVM.state.showLogoutAlert,
//                              content: AnyView(
//                                VStack(spacing: 0) {
//                                    Text("로그아웃 하시겠어요?")
//                                        .font(Font.pretendard(.bold, size: 16))
//										.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                        .frame(height: 22)
//                                }
//                                .frame(height: 66)
//                                .offset(y: 8)
//                              ),
//                              leftButtonTitle: "취소",
//                              leftButtonAction: {
//                    settingVM.state.showLogoutAlert = false
//                },
//                              rightButtonTitle: "확인",
//                              rightButtonAction: {
//                    settingVM.action(.onTapLogoutBtn)
//                            })
//            } else if settingVM.state.showDeleteAccountAlert  {
//                AlertViewOld(showAlert: $settingVM.state.showDeleteAccountAlert,
//                              content: AnyView(
//                                VStack(spacing: 8) {
//                                    Text("정말 계정을 삭제하시겠어요?")
//                                        .font(Font.pretendard(.bold, size: 16))
//                                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                    
//                                    VStack {
//                                        Text("지금까지의 정보는")
//                                            .font(Font.pretendard(.regular, size: 14))
//                                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                        
//                                        Text("3일 뒤 모두 사라집니다.")
//                                            .font(Font.pretendard(.regular, size: 14))
//                                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                                    }
//                                }
//                                .padding(.top, 24)
//                              ),
//                              leftButtonTitle: "취소",
//                              leftButtonAction: {
//                    settingVM.state.showDeleteAccountAlert = false
//                },
//                              rightButtonTitle: "확인",
//                              rightButtonAction: 
//                                {
//                    settingVM.action(.onTapDeleteAccountBtn)
//                })
//            }
//        }
//        .navigationTitle("설정")
//        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .topBarLeading) {
//                Button {
//                    dismiss()
//                    appState.isTabbarOpaque = false
//                } label: {
//                    Image("Arrow")
//                        .padding(.leading, 15)
//                }
//                .disabled(settingVM.state.isBackBtnDisabled)
//            }
//        }
//        .onChange(of: settingVM.state.showLogoutAlert) { newValue in
//            
//            settingVM.action(.onChangeShowAlert(value: newValue))
//        }
//        .onChange(of: settingVM.state.showDeleteAccountAlert) { newValue in
//            
//            settingVM.action(.onChangeShowAlert(value: newValue))
//        }
//        .background(CustomNavigationBar(backgroundColor: settingVM.state.navigationBarColor))
//    }
//    
//    var customDivider: some View {
//        Rectangle()
//            .frame(height: 1)
//            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.textPlaceholder))
//    }
//}
//
//
//
//#Preview {
//    SettingView()
//        .environmentObject(AppState())
//}
