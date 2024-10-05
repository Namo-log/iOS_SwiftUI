////
////  CustomMainView.swift
////  Namo_SwiftUI
////
////  Created by 고성민 on 1/18/24.
////
//
//import SwiftUI
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//
//struct CustomMainView: View {
//    
//    @EnvironmentObject var appState: AppState
//    let categoryUseCase = CategoryUseCase.shared
//    
//    let categories: [String] = ["팔레트", "폰트", "MY"]
//    @State private var selectedItem: String = "팔레트"
//    @Namespace private var categoryNamespace
//    
//    let columns: [GridItem] = Array(repeating: .init(.fixed(25), spacing: 15),  count: 5)
//    
//    var body: some View {
//        
//        VStack(spacing: 0) {
//        
//            HStack {
//
//                Text("Custom")
//                    .font(Font.pretendard(.bold, size: 22))
//                    .padding(.leading, 20)
//
//                Spacer()
//
//                NavigationLink(destination: SettingView()) {
//                    Image("settings")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 24, height: 24)
//                        .padding(.trailing, 25)
//                }
//            }
//            .frame(height: 59)
//
//            HStack {
//
//                ForEach(categories, id: \.self) { item in
//
//                    ZStack {
//
//                        if selectedItem == item {
//
//                            RoundedRectangle(cornerRadius: 10)
//                                .fill(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
//                                .frame(width: 100, height: 2)
//                                .matchedGeometryEffect(id: "id", in: categoryNamespace)
//                                .offset(y: 15)
//                        }
//
//                        Text(item)
//                            .font(Font.pretendard(.bold, size: 18))
//                            .foregroundStyle(selectedItem == item ? Color(asset: SharedDesignSystemAsset.Assets.mainOrange) : Color(asset: SharedDesignSystemAsset.Assets.textUnselected))
//
//                    }
//                    .frame(maxWidth: .infinity)
//                    .frame(height: 50)
//                    .onTapGesture {
//
//                        withAnimation(.spring()) {
//                            selectedItem = item
//                        }
//                    }
//                }
//            }
//            .padding(.horizontal, 20)
//            .frame(height: 30)
//
//            TabView(selection: $selectedItem) {
//
//                basicPalette
//                    .tag("팔레트")
//
//                VStack {
//
//                    Image("mongi 1")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 158, height: 150)
//
//
//                    Text("커스텀 폰트는 열심히 준비중이몽몽~!")
//                        .font(Font.pretendard(.regular, size: 15))
//                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                        .padding(.top, 6)
//                }
//                .tag("폰트")
//
//                basicPalette
//                    .tag("MY")
//            }
//            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
//            .animation(.default, value: selectedItem)
//        }
//    }
//    
//    var basicPalette: some View {
//        
//        VStack {
//            Rectangle()
//                .cornerRadius(15)
//                .frame(width: screenWidth - 50, height: 100)
//                .foregroundStyle(Color.itemBackground)
//                .overlay {
//                    
//                    HStack(alignment: .top) {
//                        Text("기본 팔레트")
//                            .font(Font.pretendard(.bold, size: 18))
//                            .padding(.leading, 15)
//                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                        
//                        Spacer()
//                        
//                        LazyVGrid(columns: columns, spacing: 15) {
//                            ForEach(1...10, id: \.self) { id in
//                                
//                                Circle()
//                                    .fill(categoryUseCase.getColorWithPaletteId(id: id))
//                                    .frame(width: 25, height: 25)
//                                    .onTapGesture {
//                                        // 추후에 추가될 코드
//                                    }
//                            }
//                        }
//                        .padding(.trailing, 15)
//                    }
//                }
//            Spacer()
//        }
//        .padding(.top, 30)
//    }
//}
//
//#Preview {
//    CustomMainView()
//        .environmentObject(AppState())
//}
