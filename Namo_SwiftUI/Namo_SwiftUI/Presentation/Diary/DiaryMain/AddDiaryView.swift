//
//  AddDiaryView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 2/25/24.
//

import SwiftUI

import Factory
import PhotosUI

struct AddDiaryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Injected(\.appState) private var appState
    
    let info: ScheduleInfo
    let isEditing: Bool
    
    @State var placeholderText: String = "메모 입력"
    @State var memo = ""
    @State var typedCharacters = 0
    @State var characterLimit = 200
    
    @State var images: [UIImage] = [] // 보여질 사진 목록
    @State var photosPickerItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    @State var photosLimit = 3 // 선택가능한 최대 사진 개수
    
    @State var isDeleting: Bool = false
    
    var backButton : some View {
        Button{
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Image(.icBack)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 24, height: 14)
        }
        .disabled(isDeleting) // Alert 떴을 때 클릭 안 되게
    }
    
    var trashButton : some View {
        Button{
            isDeleting = true
        } label: {
            Image(.btnTrash)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 30, height: 30)
        }
        .disabled(isDeleting) // Alert 떴을 때 클릭 안 되게
    }
    
    var body: some View {
        ZStack() {
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
                    
                    // 메모 입력 부분
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
                    
                    // 글자수 체크
                    HStack() {
                        Spacer()
                        
                        Text("\(typedCharacters) / \(characterLimit)")
                            .font(.pretendard(.bold, size: 12))
                            .foregroundStyle(.textUnselected)
                    } // HStack
                    .padding(.top, 10)
                    
                    // 사진 목록
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
                
                // 모임 기록 보러가기 버튼
                if !appState.isPersonalDiary {
                    Button {
                        print("모임 기록 보러가기")
                    } label: {
                        ZStack() {
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(.black, lineWidth: 1)
                                .foregroundStyle(.white)
                                .frame(width: 192, height: 40)
                            HStack() {
                                Image(.btnDiary)
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                Text("모임 기록 보러가기")
                                    .foregroundStyle(.black)
                                    .font(.pretendard(.light, size: 15))
                            }
                        }
                    }
                    .padding(.bottom, 25)
                }
                
                // 기록 저장 또는 기록 수정 버튼
                Button {
                    print(isEditing ? "기록 수정" : "기록 저장")
                    self.presentationMode.wrappedValue.dismiss()
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
            
            // 쓰레기통 클릭 시 Alert 띄우기
            if isDeleting {
                Color.black.opacity(0.3)
                    .ignoresSafeArea(.all, edges: .all)
                
                NamoAlertView(
                    showAlert: $isDeleting,
                    content: AnyView(
                        Text("기록을 정말 삭제하시겠어요?")
                            .font(.pretendard(.bold, size: 16))
                            .foregroundStyle(.mainText)
                            .padding(.top, 24)
                    ),
                    leftButtonTitle: "취소",
                    leftButtonAction: {},
                    rightButtonTitle: "삭제") {
                        print("기록 삭제")
                    }
            }
        } // ZStack
    }
}

#Preview {
    AddDiaryView(info: ScheduleInfo(scheduleName: "코딩 스터디", date: "2022.06.28(화) 11:00", place: "가천대 AI관 404호"), isEditing: false)
}
