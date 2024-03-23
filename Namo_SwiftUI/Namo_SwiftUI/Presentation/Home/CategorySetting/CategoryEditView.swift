//
//  CategoryEditView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 3/13/24.
//

import SwiftUI
import Factory

struct CategoryEditView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var categoryList: [ScheduleCategory] = []
    
    @Injected(\.categoryInteractor) var categoryInteractor
    
    let columns: [GridItem] = Array(repeating: .init(.fixed(25), spacing: 15),  count: 5)
    
    @State private var isShare: Bool = false
    @State private var categoryTitle: String = ""
    
    @State var basicColorItems = (1...14).map {
        BasicColorItem(id: $0, state: .available)
    }
    
    @State private var selectedPaletteId: Int = 0 {
        didSet {
            basicColorItems = basicColorItems.map { item in
                
                var newItem = item
                newItem.state = item.id == selectedPaletteId ? .checked : .available
                return newItem
            }
        }
    }
    
    @State private var showTitleToast = false
    @State private var showColorToast = false
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 30) {
                
                HStack {
                    TextField("카테고리 이름", text: $categoryTitle, prompt: Text("카테고리 이름").font(Font.pretendard(.bold, size: 22)))
                        .font(Font.pretendard(.bold, size: 22))
                }
                .padding(.top, 15)
                
                HStack {
                    
                    Text("기본 색상")
                        .font(Font.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        
                        ForEach(basicColorItems.prefix(4)) { item in
                            
                            ColorCircleView(color: categoryInteractor.getColorWithPaletteId(id: item.id), selectState: item.state)
                                .frame(width: 25, height: 25)
                                .onTapGesture {
                                    self.selectedPaletteId = item.id
                                }
                        }
                    }
                }
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Text("팔레트")
                            .font(Font.pretendard(.bold, size: 15))
                            .foregroundStyle(.mainText)
                        
                        Text("기본 팔레트")
                            .font(Font.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                    }
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(basicColorItems.dropFirst(4)) { item in
                            
                            ColorCircleView(color: categoryInteractor.getColorWithPaletteId(id: item.id), selectState: item.state)
                                .frame(width: 25, height: 25)
                                .onTapGesture {
                                    self.selectedPaletteId = item.id
                                }
                        }
                    }
                }
                
                Toggle(isOn: $isShare) {
                    
                    Text("공유 설정")
                        .font(Font.pretendard(.bold, size: 15))
                        .foregroundStyle(.mainText)
                    
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(hex:0x63A4E0)))
                
                Spacer()
  
            }
            .frame(width: screenWidth - 60)
            .navigationTitle("카테고리 편집")
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        
                        appState.showCategoryDeleteBtn = false
                        appState.categoryCantDelete = false
                        
                        path.removeLast()
                        
                    } label: {
                        HStack {
                            Image("Vector 2")
                            Text("카테고리 설정")
                                .font(Font.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        if categoryTitle == "" {
                            
                            withAnimation {
                                self.showTitleToast = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.showTitleToast = false
                                }
                            }
                            
                        } else if selectedPaletteId == 0 {
                            
                            withAnimation {
                                self.showColorToast = true
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.showColorToast = false
                                }
                            }
                            
                        } else {
                            Task {
                                await categoryInteractor.editCategory(id: self.categoryList.first!.categoryId, data: postCategoryRequest(name: categoryTitle, paletteId: selectedPaletteId, isShare: isShare))
                                
                            }

                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
                                withAnimation {
                                    appState.showCategoryEditDoneToast = true
                                }
                            }
                            
                            appState.showCategoryDeleteBtn = false
                            appState.categoryCantDelete = false
                           
                            path.removeLast()
                        }
                        
                    } label: {
                        Text("저장")
                            .font(Font.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                    }
                }
            }
            .onAppear {
                
                self.categoryList = categoryInteractor.setCategories()
                
                appState.showCategoryDeleteBtn = true
                
                self.categoryTitle = self.categoryList.first!.name
                self.selectedPaletteId = self.categoryList.first!.paletteId
                self.isShare = self.categoryList.first!.isShare
            }

            VStack {
                
                Spacer()
                
                if showTitleToast {
                    
                    ToastView(toastMessage: "카테고리 이름을 입력해주세요.", bottomPadding: 150)
                }
                
                if appState.showCategoryCantDeleteToast {
                    
                    ToastView(toastMessage: "기본 카테고리는 삭제할 수 없습니다.", bottomPadding: 150)
                }
            }
        }
    }
}

#Preview {
    CategoryEditView(path: .constant(NavigationPath()))
}
