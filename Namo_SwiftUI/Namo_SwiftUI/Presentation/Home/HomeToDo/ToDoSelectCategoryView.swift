//
//  ToDoSelectCategoryView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/4/24.
//


import SwiftUI
import Factory


/// 일정의 카테고리를 선택 시 표시되는 화면 입니다.
struct ToDoSelectCategoryView: View {
    
    @EnvironmentObject var appState: AppState
	@EnvironmentObject var scheduleState: ScheduleState
    let categoryUseCase = CategoryUseCase.shared
    
    /// 화면에 표시되기 위한 categoryList State
    @State private var categoryList: [ScheduleCategory] = []
    
    /// NavigationPath
    @Binding var path: NavigationPath

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                //MARK: 카테고리 목록
                ForEach(categoryList, id: \.self) { category in
                    HStack {
                        ColorCircleView(color: category.color, selectState: category.isSelected ?? false ? .checked : .available)
                            .frame(width: 20, height: 20)
                        Text(category.name)
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                        Spacer()
                    }
                    .lineSpacing(12)
                    .onTapGesture {
                        for index in categoryList.indices {
                            if  categoryList[index].hashValue == category.hashValue {
                                categoryList[index].isSelected = true
                                self.scheduleState.currentSchedule.categoryId = category.categoryId
                            } else {
                                categoryList[index].isSelected = false
                            }
                        }
                        // 뒤로 가기
                        path.removeLast()
                    }
                }
                
                //MARK: "카테고리 편집"
                
                Button {
                    
                    path.append(CategoryViews.CategorySettingView)
                    
                } label: {
                    HStack {
                        Image(systemName: "square.grid.2x2")
                            .renderingMode(.template)
                            .foregroundStyle(.mainText)
                        Text("카테고리 편집")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                    }
                    .lineSpacing(12)
                }
                
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 100)
                
            }//: VStack
            .padding(EdgeInsets(top: 10, leading: 30, bottom: 20, trailing: 30))
            .navigationTitle("카테고리")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) // Back버튼 지우기
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        // 뒤로 가기
                        path.removeLast()
                    }, label: {
                        Text("닫기")
                            .font(.pretendard(.regular, size: 15))
                    })
                    .foregroundStyle(.mainText)
                }
            }//: toolbar
        }//: ScrollView
        .onAppear {
            
            self.categoryList = self.categoryUseCase.setCategories()
        }
    }
}



#Preview {
    ToDoSelectCategoryView(path: .constant(NavigationPath()))
        .environmentObject(AppState())
}
