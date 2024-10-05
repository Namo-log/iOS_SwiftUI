//
//  CategoryAddView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 3/13/24.
//

import SwiftUI
import Factory

import SharedDesignSystem
import SharedUtil
import CoreNetwork

struct BasicColorItem: Hashable, Identifiable {
    var id: Int
    var state: ColorCirclePresentMode
}

struct ColorItem: Hashable {
    var color: Color
    var state: ColorCirclePresentMode
}

struct CategoryAddView: View {
    
	let categoryUseCase = CategoryUseCase.shared
    
    // 새 카테고리 제목
    @State private var categoryTitle: String = ""
    
    // 카테고리 공유 여부
    @State private var isShare: Bool = false
    
    @State var basicColorItems = (1...14).map {
        BasicColorItem(id: $0, state: .available)
    }
    
    // 카테고리 색상
    @State private var selectedPaletteId: Int = 0 {
        didSet {
            basicColorItems = basicColorItems.map { item in
                
                var newItem = item
                newItem.state = item.id == selectedPaletteId ? .checked : .available
                return newItem
            }
        }
    }
    
    /// 조건이 충족되지 않을 시 나타나는 토스트 메시지
    @State private var showTitleToast = false   // 카테고리 제목 토스트
    @State private var showColorToast = false   // 카테고리 색상 토스트
    
    @Binding var path: NavigationPath
    
    // LazyGrid Column
    let columns: [GridItem] = Array(repeating: .init(.fixed(25), spacing: 15),  count: 5)

    var body: some View {
        
        ZStack {
            
            VStack(spacing: 30) {
                
                HStack {
                    TextField("새 카테고리", text: $categoryTitle, prompt: Text("새 카테고리").font(Font.pretendard(.bold, size: 22)))
                        .font(Font.pretendard(.bold, size: 22))
                }
                .padding(.top, 15)
                
                HStack {
                    
                    Text("기본 색상")
                        .font(Font.pretendard(.bold, size: 15))
                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                    
                    Spacer()
                    
                    HStack(spacing: 20) {
                        
                        ForEach(basicColorItems.prefix(4)) { item in
                            
                            ColorCircleView(color: categoryUseCase.getColorWithPaletteId(id: item.id), selectState: item.state)
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
                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                        
                        Text("기본 팔레트")
                            .font(Font.pretendard(.regular, size: 15))
                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                    }
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(basicColorItems.dropFirst(4)) { item in
                            
                            ColorCircleView(color: categoryUseCase.getColorWithPaletteId(id: item.id), selectState: item.state)
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
                        .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                    
                }
                .toggleStyle(SwitchToggleStyle(tint: Color(hex:0x63A4E0)))
                
                Spacer()
                
            }
            .frame(width: screenWidth - 60)
            .navigationTitle("새 카테고리")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button {
                        path.removeLast()
                    } label: {
                        HStack {
                            Image("vector2")
                            Text("카테고리 설정")
                                .font(Font.pretendard(.regular, size: 15))
                                .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                        // 카테고리 제목이 비어있을 경우
                        if categoryTitle == "" {
                            
                            // 카테고리 제목 토스트 활성화
                            withAnimation {
                                self.showTitleToast = true
                            }
                            
                            // 2초뒤 카테고리 제목 토스트 비활성화
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.showTitleToast = false
                                }
                            }
                            
                        // 카테고리 색이 지정 안됐을 경우
                        } else if selectedPaletteId == 0 {
                            
                            // 카테고리 색상 토스트 활성화
                            withAnimation {
                                self.showColorToast = true
                            }
                            
                            // 2초뒤 카테고리 색상 토스트 비활성화
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    self.showColorToast = false
                                }
                            }
                        } else {
                            
                            Task {
                                
                                // 카테고리 생성 API 호출
								let result = await categoryUseCase.addCategory(data: postCategoryRequest(categoryName: categoryTitle, colorId: selectedPaletteId, isShared: isShare))
                                
                                // 생성이 성공했을 경우에만
                                if result {
                                    
                                    // 카테고리 생성 후 이전 화면으로 되돌아감
                                    path.removeLast()
                                }
                            }
                        }
                    } label: {
                        Text("저장")
                            .font(Font.pretendard(.regular, size: 15))
                            .foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
                    }
                }
            }
            
            VStack {
                
                Spacer()
                
                // 카테고리 관련 토스트 뷰
                if showTitleToast {
                    
                    ToastView(toastMessage: "카테고리 이름을 입력해주세요.", bottomPadding: 150)
                }
                
                if showColorToast {
                    
                    ToastView(toastMessage: "카테고리 색상을 선택해주세요.", bottomPadding: 150)
                }
            }
        }
    }
}

#Preview {
    CategoryAddView(path: .constant(NavigationPath()))
}
