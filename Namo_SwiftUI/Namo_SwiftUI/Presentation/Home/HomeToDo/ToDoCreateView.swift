//
//  ToDoCreateView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/24/24.
//

import SwiftUI

struct ToDoCreateView: View {
    
    @State private var ToDoTitle: String = ""
    @State private var categoryColor: Color = .mainOrange
    @State private var categoryName: String = "일정"
    
    init() {
        // SwiftUI의 NavigationTitle는 Font가 적용되지 않습니다.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Pretendard-Bold", size: 15)!]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("일정 이름", text: $ToDoTitle)
                    .font(.pretendard(.bold, size: 22))
                    .padding(EdgeInsets(top: 18, leading: 30, bottom: 15, trailing: 30))
                
                VStack(alignment: .leading, spacing: 20) {
                    ListItem(listTitle: "카테고리") {
                        HStack {
                            ColorCircleView(color: categoryColor)
                                .frame(width: 13, height: 13)
                            NavigationLink(categoryName, destination: HomeMainView())
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                            Image("vector3")
                                .renderingMode(.template)
                                .foregroundStyle(.mainText)
                        }
                        .lineSpacing(12)
                    }
                    .padding(.vertical, 14)

                    ListItem(listTitle: "시작") {
                        Text("2023.01.25 (목) 01:25 AM")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                            .onTapGesture {
                                print("show timepicker1")
                            }
                    }
                    ListItem(listTitle: "종료") {
                        Text("2023.01.25 (목) 01:25 AM")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(.mainText)
                            .onTapGesture {
                                print("show timepicker2")
                            }
                    }
                    ListItem(listTitle: "알림") {
                        HStack {
                            Text("5분 전")
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                                .onTapGesture {
                                    print("show noticeIntervalList")
                                }
                            Image("vector3")
                                .renderingMode(.template)
                                .foregroundStyle(.mainText)
                        }
                        .lineSpacing(12)
                    }
                    ListItem(listTitle: "장소") {
                        HStack {
                            NavigationLink("탐앤탐스 탐스커버리 건대점", destination: HomeMainView())
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.mainText)
                            Image("vector3")
                                .renderingMode(.template)
                                .foregroundStyle(.mainText)
                        }
                        .lineSpacing(12)
                    }
                    .padding(.vertical, 14)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .navigationTitle("새 일정")
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
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // 저장
                    }, label: {
                        Text("저장")
                            .font(.pretendard(.regular, size: 15))
                    })
                    .foregroundStyle(.mainText)
                }
            }//: VStack - toolbar
            
        }//: NavigationStack
    }
    
    private struct ListItem<Content: View>: View {
        
        var listTitle: String
        var content: () -> Content
        
        var body: some View {
            HStack {
                Text(listTitle)
                    .font(.pretendard(.bold, size: 15))
                Spacer()
                content()
            }
        }
    }
    

}



#Preview {
    ToDoCreateView()
}
