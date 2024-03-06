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
    @Injected(\.categoryInteractor) var categoryInteractor
    
    /// 화면에 표시되기 위한 categoryList State
    @State private var categoryList: [ScheduleCategory] = []
    /// 현재화면 dismiss
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
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
                                    self.appState.scheduleState.scheduleTemp.categoryId = category.categoryId
                                } else {
                                    categoryList[index].isSelected = false
                                }
                            }
                            dismiss()
                        }
                    }
                    
                    //MARK: "카테고리 편집"
                    HStack {
                        Image(systemName: "square.grid.2x2")
                            .renderingMode(.template)
                            .foregroundStyle(.mainText)
                        Text("카테고리 편집")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                    }
                    .lineSpacing(12)
        
                }//: VStack
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 20, trailing: 30))
                .navigationTitle("카테고리")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true) // Back버튼 지우기
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            dismiss()
                        }, label: {
                            Text("닫기")
                                .font(.pretendard(.regular, size: 15))
                        })
                        .foregroundStyle(.mainText)
                    }
                }//: toolbar
            }//: ScrollView
        }//: NavigationStack
        .onAppear {
            // 카테고리 최신화 후, 카테고리 리스트에 반영
            Task {
                await self.categoryInteractor.getCategories()
                self.categoryList = self.appState.categoryState.categoryList.map { category in
                    
                    return ScheduleCategory(
                        categoryId: category.categoryId,
                        name: category.name,
                        paletteId: category.paletteId,
                        isShare: category.isShare,
                        color: categoryInteractor.getColorWithPaletteId(id: category.paletteId),
                        isSelected: self.appState.scheduleState.scheduleTemp.categoryId == category.categoryId ? true : false
                    )
                    
                }
            }
        }
    }
}



#Preview {
    ToDoSelectCategoryView()
        .environmentObject(AppState())
}
