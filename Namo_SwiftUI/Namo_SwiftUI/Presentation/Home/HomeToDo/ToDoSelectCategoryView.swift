//
//  ToDoSelectCategoryView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/4/24.
//


import SwiftUI

struct ToDoCategory: Hashable {
    var name: String
    var color: Color
    var isSelected: Bool
}

struct ToDoSelectCategoryView: View {

    @State private var categoryList: [ToDoCategory] = [
        ToDoCategory(name: "일정", color: .blue, isSelected: true),
        ToDoCategory(name: "약속", color: .mainOrange, isSelected: false),
        ToDoCategory(name: "알바", color: .indigo, isSelected: false),
        ToDoCategory(name: "기념일", color: .yellow, isSelected: false)
    ]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(categoryList, id: \.self) { category in
                        HStack {
                            ColorCircleView(color: category.color, selectState: category.isSelected ? .checked : .available)
                                .frame(width: 20, height: 20)
                            Text(category.name)
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                            Spacer()
                        }
                        .lineSpacing(12)
                        .onTapGesture {
                            if let index = categoryList.firstIndex(where: {
                                $0.hashValue == category.hashValue
                            }) {
                                categoryList[index]
                                    .isSelected
                                    .toggle()
                            }
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
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button(action: {
                            // 닫기
                        }, label: {
                            Text("닫기")
                                .font(.pretendard(.regular, size: 15))
                        })
                        .foregroundStyle(.mainText)
                    }
                }//: toolbar
            }//: ScrollView
        }//: NavigationStack
    }
}



#Preview {
    ToDoSelectCategoryView()
}
