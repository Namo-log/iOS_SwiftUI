//
//  CategorySettingView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 3/13/24.
//

import SwiftUI
import Factory

struct CategorySettingView: View {
    
    @EnvironmentObject var appState: AppState
    
    @Injected(\.categoryInteractor) var categoryInteractor
    
    @State private var categoryList: [ScheduleCategory] = []
    
    @Binding var path: NavigationPath
    
    let columns: [GridItem] = Array(repeating: .init(.fixed((screenWidth - 70) / 2), spacing: 25),  count: 2)
    
    var body: some View {
        
        ZStack {
            ScrollView(.vertical) {
                
                VStack {
                    HStack {
                        Text("캘린더")
                            .font(Font.pretendard(.bold, size: 22))
                            .foregroundStyle(.mainText)
                        
                        Spacer()
                    }
                    .frame(width: screenWidth - 60)
                    .padding(.top, 10)
                    
                    Rectangle()
                        .frame(width: screenWidth - 60, height: 35)
                        .foregroundStyle(.textBackground)
                        .cornerRadius(10)
                        .overlay(
                            HStack {
                                Text("팔레트")
                                    .font(Font.pretendard(.bold, size: 15))
                                    .foregroundStyle(.mainText)
                                    .padding(.leading, 15)
                                
                                Spacer()
                                
                                HStack {
                                    Text("기본 팔레트")
                                        .font(Font.pretendard(.regular, size: 15))
                                        .foregroundStyle(.mainText)
                                    Image("Vector 1")
                                }
                                .padding(.trailing, 15)
                            }
                        )
                    
                    LazyVGrid(columns: columns) {
                        
                        ForEach(categoryList.indices, id: \.self) { index in
                            
                            Rectangle()
                                .foregroundStyle(.textBackground)
                                .frame(width: (screenWidth - 80) / 2, height: 50)
                                .cornerRadius(15)
                                .onTapGesture {

                                    if index == 0 || index == 1 {
                                        self.appState.categoryCantDelete = true
                                    }
                                    
                                    path.append(CategoryViews.CategoryEditView)
                                    self.appState.categoryState.categoryList.removeAll()
                                    self.appState.categoryState.categoryList.append(ScheduleCategory(categoryId: categoryList[index].categoryId, name: categoryList[index].name, paletteId: categoryList[index].paletteId, isShare: categoryList[index].isShare))
                                }
                                .overlay(

                                    HStack {

                                        ColorCircleView(color: categoryList[index].color)
                                            .frame(width: 20, height: 20)

                                        Spacer()

                                        Text(categoryList[index].name)
                                            .font(.pretendard(.regular, size: 15))
                                            .foregroundStyle(.mainText)

                                        Image("Vector 1")
                                    }
                                    .padding(.horizontal, 15)
                                )
                        }
                    }
                    
                    Button {
                        
                        path.append(CategoryViews.CategoryAddView)
                        
                    } label: {
                        Image("addNewCategory")
                            .resizable()
                            .scaledToFit()
                            .frame(width: screenWidth - 60, height: 50)
                    }
                    
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(height: 125)
                    
                }
            }
            .navigationTitle("카테고리 설정")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        path.removeLast()
                        
                    } label: {
                        HStack {
                            Image("Vector 2")
                            Text("일정")
                                .font(Font.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                        }
                    }
                }
            }
            .onAppear {
                
                categoryInteractor.showCategoryDoneToast()
                
                Task {
                    
                    await self.categoryInteractor.getCategories()
                    
                    self.categoryList = categoryInteractor.setCategories()
                }
            }
            
            VStack {
                Spacer()
                
                if appState.showCategoryDeleteDoneToast {
                    
                    ToastView(toastMessage: "카테고리가 삭제되었습니다.", bottomPadding: 150)
                }
                
                if appState.showCategoryEditDoneToast {
                    
                    ToastView(toastMessage: "카테고리가 수정되었습니다.", bottomPadding: 150)
                }
            }
        }
    }
}

#Preview {
    CategorySettingView(path: .constant(NavigationPath()))
}
