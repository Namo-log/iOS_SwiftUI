//
//  MoimPlaceView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import PhotosUI

// 모임 기록에서 장소 뷰
struct MoimPlaceView: View {
    @State private var dragOffset: CGSize = .zero
    @State private var isAddingViewVisible = false
    @Binding var showCalculateAlert: Bool
    @Binding var activity: ActivityDTO {
      didSet {
        print("@CHANGED - \(activity)")
      }
    }
    @Binding var name: String
    @Binding var currentCalculateIndex: Int
    @Binding var pickedImagesData: [Data?]
    @State var images: [UIImage] = [] // 보여질 사진 목록
    @State var pickedImageItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    
    let index: Int
    let photosLimit = 3 // 선택가능한 최대 사진 개수
	let deleteAction: () -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 0) {
                // 장소 레이블
                HStack(alignment: .top, spacing: 0) {
                    TextField(
                        "\(activity.name)",
                        text: $name,
                        prompt: Text("활동 \(index+1)").foregroundColor(.textPlaceholder)
                    )
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(.mainText)
                    
                    Spacer()
                    HStack() {
                        Text("총 \(activity.money)원")
                            .font(.pretendard(.light, size: 15))
                            .foregroundStyle(.mainText)
                        Image(.rightChevronLight)
                    }
                    .onTapGesture {
                        self.currentCalculateIndex = self.index
                        withAnimation {
                            self.showCalculateAlert = true
                        }
                    }
                }
                .padding(.top, 20)
                
                // 사진 선택 리스트
                PhotoPickerListView
            }
            .padding(.bottom, 25)
            .offset(x: dragOffset.width, y: 0)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        if !isAddingViewVisible {
                            if value.translation.width > -20 && value.translation.width < 0 {
                                self.dragOffset = value.translation
                                withAnimation {
                                    isAddingViewVisible = true
                                }
                            }
                        } else {
                            if value.translation.width < 20 && value.translation.width > 0 {
                                self.dragOffset = .zero
                                withAnimation {
                                    isAddingViewVisible = false
                                }
                            }
                        }
                    }
            ) // gesture
            .onAppear {
                if activity.name.isEmpty {
                    activity.name = ""
                }
            }
            
            if isAddingViewVisible {
                Button {
                    deleteAction()
                    self.dragOffset = .zero
                } label: {
                    Rectangle()
                        .fill(Color(.mainOrange))
                        .frame(width: 65, height: 136)
                        .overlay {
                            Image(.icTrashWhite)
                                .resizable()
                                .frame(width: 24, height: 24)
                        }
                }
            }
        }
        .onAppear(perform: {
            for url in activity.urls {
                guard let url = URL(string: url) else { return }
                DispatchQueue.global().async {
                    guard let data = try? Data(contentsOf: url) else { return }
                    pickedImagesData.append(data)
                    images.append(UIImage(data: data)!)
                    print(images.description)
                }
            }
        })
    }
    
    // 사진 선택 리스트 뷰
    private var PhotoPickerListView: some View {
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
                PhotosPicker(selection: $pickedImageItems, maxSelectionCount: photosLimit, selectionBehavior: .ordered) {
                    Image(.btnAddImg)
                        .resizable()
                        .frame(width: 100, height: 100)
                }
            } // HStack
            .padding(.top, 18)
            .onChange(of: pickedImageItems) { _ in
                Task {
                    // 앞서 선택된 것들은 지우고
                    pickedImagesData.removeAll()
                    images.removeAll()
                    
//                    activity.toUrlString(dataList: pickedImagesData)

                    // 선택된 사진들 images에 추가
                    for item in pickedImageItems {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            pickedImagesData.append(data)
                            if let image = UIImage(data: data) {
                                images.append(image)
//                                activity.toUrlString(dataList: pickedImagesData)
                            }
                        }
                    }
                }
            }
        } // ScrollView
    }
}
