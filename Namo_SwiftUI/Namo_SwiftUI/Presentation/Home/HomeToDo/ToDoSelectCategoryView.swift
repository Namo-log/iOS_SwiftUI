//
//  ToDoSelectCategoryView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/4/24.
//


import SwiftUI
import Factory

struct ToDoCategory: Hashable {
    var categoryId: Int
    var name: String
    var color: Color
    var isSelected: Bool
}

struct ToDoSelectCategoryView: View {
    @EnvironmentObject var appState: AppState
    @Injected(\.categoryInteractor) var categoryInteractor

    @State private var categoryList: [ScheduleCategory] = [
    ]
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
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
