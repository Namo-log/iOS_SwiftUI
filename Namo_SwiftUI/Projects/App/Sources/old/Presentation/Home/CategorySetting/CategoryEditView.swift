////
////  CategoryEditView.swift
////  Namo_SwiftUI
////
////  Created by 고성민 on 3/13/24.
////
//
//import SwiftUI
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//import CoreNetwork
//
//struct CategoryEditView: View {
//    
//    @EnvironmentObject var appState: AppState
//    
//    @State private var categoryList: [ScheduleCategory] = []
//    
//	let categoryUseCase = CategoryUseCase.shared
//    
//    let columns: [GridItem] = Array(repeating: .init(.fixed(25), spacing: 15),  count: 5)
//    
//    @State private var isShare: Bool = false
//    @State private var categoryTitle: String = ""
//    
//    @State var basicColorItems = (1...14).map {
//        BasicColorItem(id: $0, state: .available)
//    }
//    
//    @State private var selectedPaletteId: Int = 0 {
//        didSet {
//            basicColorItems = basicColorItems.map { item in
//                
//                var newItem = item
//                newItem.state = item.id == selectedPaletteId ? .checked : .available
//                return newItem
//            }
//        }
//    }
//    
//    // 카테고리 제목을 입력하지 않았을 경우 나타나는 토글창 여부
//    @State private var showTitleToast = false
//    
//    // 카테고리 색을 지정하지 않았을 경우 나타나는 토글창 여부
//    @State private var showColorToast = false
//    
//    @Binding var path: NavigationPath
//    
//    var body: some View {
//        
//        ZStack {
//            VStack(spacing: 30) {
//                
//                HStack {
//                    TextField("카테고리 이름", text: $categoryTitle, prompt: Text("카테고리 이름").font(Font.pretendard(.bold, size: 22)))
//                        .font(Font.pretendard(.bold, size: 22))
//                }
//                .padding(.top, 15)
//                
//                HStack {
//                    
//                    Text("기본 색상")
//                        .font(Font.pretendard(.bold, size: 15))
//                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                    
//                    Spacer()
//                    
//                    HStack(spacing: 20) {
//                        
//                        ForEach(basicColorItems.prefix(4)) { item in
//                            
//                            ColorCircleView(color: categoryUseCase.getColorWithPaletteId(id: item.id), selectState: item.state)
//                                .frame(width: 25, height: 25)
//                                .onTapGesture {
//                                    self.selectedPaletteId = item.id
//                                }
//                        }
//                    }
//                }
//                
//                HStack(alignment: .top) {
//                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        
//                        Text("팔레트")
//                            .font(Font.pretendard(.bold, size: 15))
//                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                        
//                        Text("기본 팔레트")
//                            .font(Font.pretendard(.regular, size: 15))
//                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                    }
//                    
//                    Spacer()
//                    
//                    LazyVGrid(columns: columns, spacing: 15) {
//                        ForEach(basicColorItems.dropFirst(4)) { item in
//                            
//                            ColorCircleView(color: categoryUseCase.getColorWithPaletteId(id: item.id), selectState: item.state)
//                                .frame(width: 25, height: 25)
//                                .onTapGesture {
//                                    self.selectedPaletteId = item.id
//                                }
//                        }
//                    }
//                }
//                
//                Toggle(isOn: $isShare) {
//                    
//                    Text("공유 설정")
//                        .font(Font.pretendard(.bold, size: 15))
//                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                    
//                }
//                .toggleStyle(SwitchToggleStyle(tint: Color(hex:0x63A4E0)))
//                
//                Spacer()
//  
//            }
//            .frame(width: screenWidth - 60)
//            .navigationTitle("카테고리 편집")
//            .navigationBarBackButtonHidden(true)
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    
//                    Button {
//                        
//                        appState.showCategoryDeleteBtn = false
//                        appState.categoryCantDelete = false
//                        
//                        path.removeLast()
//                        
//                    } label: {
//                        HStack {
//                            Image("vector2")
//                            Text("카테고리 설정")
//                                .font(Font.pretendard(.regular, size: 15))
//                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                        }
//                    }
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        
//                        // 카테고리 제목이 비어있을 경우
//                        if categoryTitle == "" {
//                            
//                            // 카테고리 제목 토스트 활성화
//                            withAnimation {
//                                self.showTitleToast = true
//                            }
//                            
//                            // 2초뒤 카테고리 제목 토스트 비활성화
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                                withAnimation {
//                                    self.showTitleToast = false
//                                }
//                            }
//                            
////                        } else if selectedPaletteId == 0 {
////                            
////                            withAnimation {
////                                self.showColorToast = true
////                            }
////                            
////                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
////                                withAnimation {
////                                    self.showColorToast = false
////                                }
////                            }
//                            
//                        } else {
//                            
//                            // 카테고리 수정 API 호출
//                            Task {
//                                
//                                let result = await categoryUseCase.editCategory(id: self.categoryList.first!.categoryId, data: postCategoryRequest(name: categoryTitle, paletteId: selectedPaletteId, isShare: isShare))
//                                
//                                // 수정이 성공했을 경우에만
//                                if result {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.125) {
//                                        withAnimation {
//                                            appState.showCategoryEditDoneToast = true
//                                        }
//                                    }
//                                    
//                                    // 카테고리 삭제 관련 State 비활성화
//                                    appState.showCategoryDeleteBtn = false
//                                    appState.categoryCantDelete = false
//                                    
//                                    // 카테고리 수정 후 이전 화면으로 되돌아감
//                                    path.removeLast()
//                                    
//                                } else {
//                                    
//                                }
//                            }
//                        }
//                        
//                    } label: {
//                        Text("저장")
//                            .font(Font.pretendard(.regular, size: 15))
//                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//                    }
//                }
//            }
//            .onAppear {
//                
//                // 수정할 기존 카테고리 항목들을 화면에 표시
//                self.categoryList = categoryUseCase.setCategories()
//                self.categoryTitle = self.categoryList.first!.name
//                self.selectedPaletteId = self.categoryList.first!.paletteId
//                self.isShare = self.categoryList.first!.isShare
//                
//                // 카테고리 삭제 버튼 활성화
//                appState.showCategoryDeleteBtn = true
//            }
//
//            VStack {
//                
//                Spacer()
//                
//                // 카테고리 관련 토스트 뷰
//                if showTitleToast {
//                    
//                    ToastView(toastMessage: "카테고리 이름을 입력해주세요.", bottomPadding: 150)
//                }
//                
//                if appState.showCategoryCantDeleteToast {
//                    
//                    ToastView(toastMessage: "기본 카테고리는 삭제할 수 없습니다.", bottomPadding: 150)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    CategoryEditView(path: .constant(NavigationPath()))
//}
