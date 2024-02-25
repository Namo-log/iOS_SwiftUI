//
//  AddDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 2/25/24.
//

import SwiftUI
import PhotosUI

struct AddDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let info: ScheduleInfo
    let isEditing: Bool
    
    @State var placeholderText: String = "메모 입력"
    @State var memo = ""
    @State var typedCharacters = 0
    @State var characterLimit = 200
    
    @State var images: [UIImage] = [] // 보여질 사진 목록
    @State var photosPickerItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    @State var photosLimit = 3 // 선택가능한 최대 사진 개수
    
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(.icBack)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 14)
        }
    }
    
    var trashButton : some View {
        Button{
            print("기록 삭제")
        } label: {
            Image(.btnTrash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
        }
    }
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(alignment: .leading) {
                HStack(alignment: .center, spacing: 0) {
                    ZStack(alignment: .center) {
                        Circle()
                            .fill(.white)
                            .frame(width: 80, height: 80)
                            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 7)
                        
                        VStack(alignment: .center, spacing: 0) {
                            Text("JUNE")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundStyle(.mainText)
                            Text("28")
                                .font(.pretendard(.bold, size: 36))
                                .foregroundStyle(.mainText)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("날짜")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundStyle(.mainText)
                        Text("장소")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundStyle(.mainText)
                    }
                    .padding(.leading, 25)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(info.date)
                            .font(.pretendard(.light, size: 15))
                            .foregroundStyle(.mainText)
                        Text(info.place)
                            .font(.pretendard(.light, size: 15))
                            .foregroundStyle(.mainText)
                    }
                    .padding(.leading, 12)
                } // HStack
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(.textBackground)
                        .clipShape(RoundedCorners(radius: 10, corners: [.allCorners]))
                    
                    Rectangle()
                        .fill(.pink)
                        .clipShape(RoundedCorners(radius: 10, corners: [.topLeft, .bottomLeft]))
                        .frame(width: 10)
                    
                    // Place Holder
                    if self.memo.isEmpty {
                        TextEditor(text: $placeholderText)
                            .font(.pretendard(.medium, size: 15))
                            .foregroundColor(.textPlaceholder)
                            .disabled(true)
                            .padding(.leading, 20)
                            .padding(.top, 5)
                            .padding(.bottom, 5)
                            .padding(.trailing, 16)
                            .scrollContentBackground(.hidden) // 컨텐츠 영역의 하얀 배경 제거
                            .lineLimit(7)
                    }
                    TextEditor(text: $memo)
                        .font(.pretendard(.medium, size: 15))
                        .foregroundColor(.mainText)
                        .opacity(self.memo.isEmpty ? 0.25 : 1)
                        .padding(.leading, 20)
                        .padding(.top, 5)
                        .padding(.bottom, 5)
                        .padding(.trailing, 16)
                        .scrollContentBackground(.hidden) // 컨텐츠 영역의 하얀 배경 제거
                        .lineLimit(7)
                        .onChange(of: memo) { res in
                            typedCharacters = memo.count
                            memo = String(memo.prefix(characterLimit))
                        }
                } // ZStack
                .frame(height: 150)
                
                HStack() {
                    Spacer()
                    
                    Text("\(typedCharacters) / \(characterLimit)")
                        .font(.pretendard(.bold, size: 12))
                        .foregroundStyle(.textUnselected)
                } // HStack
                .padding(.top, 10)
                
                ScrollView(.horizontal) {
                    HStack(alignment: .top, spacing: 20) {
                        // images의 사진들을 하나씩 이미지뷰로 띄운다
                        ForEach(0..<images.count, id: \.self) { i in
                            Image(uiImage: images[i])
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                        }
                        
                        // 사진 피커 -> 최대 3장까지 선택 가능
                        PhotosPicker(selection: $photosPickerItems, maxSelectionCount: photosLimit, selectionBehavior: .ordered) {
                            Image(.btnAddImg)
                                .resizable()
                                .frame(width: 100, height: 100)
                        }
                    } // HStack
                    .padding(.top, 18)
                    .onChange(of: photosPickerItems) { _ in
                        Task {
                            // 앞서 선택된 것들은 지우고
                            images.removeAll()
                            
                            // 선택된 사진들 images에 추가
                            for item in photosPickerItems {
                                if let data = try? await item.loadTransferable(type: Data.self) {
                                    if let image = UIImage(data: data) {
                                        images.append(image)
                                    }
                                }
                            }
                        }
                    }
                } // ScrollView
            } // VStack
            .padding(.top, 12)
            .padding(.leading, 25)
            .padding(.trailing, 25)
            
            Spacer()
            
            Button {
                print(isEditing ? "기록 수정" : "기록 저장")
            } label: {
                ZStack() {
                    Rectangle()
                        .fill(isEditing ? .white : .mainOrange)
                        .frame(height: 60 + 10) // 하단의 Safe Area 영역 칠한 거 높이 10으로 가정
                        .shadow(color: .black.opacity(0.25), radius: 7)
                    
                    Text(isEditing ? "기록 수정" : "기록 저장")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(isEditing ? .mainOrange : .white)
                        .padding(.bottom, 10) // Safe Area 칠한만큼
                }
            }
        } // VStack
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton, trailing: isEditing ? trashButton : nil)
        .navigationTitle(info.scheduleName)
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    AddDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: false)
//    AddDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: true)
}
