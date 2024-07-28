//
//  MoimPlaceView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI
import PhotosUI
import Kingfisher

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
    
    @State var imageItems: [ImageItem] = []
    
    @Binding var showImageDetailViewSheet: Bool
    @Binding var selectedImageIndex: Int
    
    @Binding var imagesForImageDetail: [ImageItem]
    
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
                        NotificationCenter.default.post(name: NSNotification.Name("UpdateCalculateInfo"), object: nil, userInfo: ["currentCalculateIndex":currentCalculateIndex])
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
                    imageItems.removeAll()
                    
                    for url in activity.urls {
                        imageItems.append(ImageItem(id: nil, source: .url(url)))
                    }
                    
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
    }
    
    // 사진 선택 리스트 뷰
    private var PhotoPickerListView: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .top, spacing: 20) {
                // images의 사진들을 하나씩 이미지뷰로 띄운다
                
                ForEach(0..<imageItems.count, id: \.self) { index in
                    
                    ZStack {
                        
                        switch imageItems[index].source {
                            
                        case .url(let url):
                            
                            KFImage(URL(string: url))
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    selectedImageIndex = index
                                    showImageDetailViewSheet = true
                                    imagesForImageDetail = imageItems
                                }
                            
                        case .uiImage(let uiImage):
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .aspectRatio(contentMode: .fill)
                                .onTapGesture {
                                    selectedImageIndex = index
                                    showImageDetailViewSheet = true
                                    imagesForImageDetail = imageItems
                                }
                        }
                        
                        Image("icImageDelete")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .offset(x: 40, y: -45)
                            .shadow(radius: 5)
                            .onTapGesture {
                                
                                if index >= 0 && index < pickedImagesData.count {
                                    
                                    pickedImagesData.remove(at: index)
                                    
                                    self.imageItems.remove(at: index)
                                    
                                } else {
                                    
                                    ErrorHandler.shared.handle(type: .showAlert, error: .customError(title: "이미지 삭제 오류", message: "일시적인 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.", localizedDescription: "이미지 불러오기 실패"))
                                }
                            }
                    }
                }
                
                if imageItems.count < 3 {
                    
                    // 사진 피커 -> 최대 3장까지 선택 가능
                    PhotosPicker(selection: $pickedImageItems, maxSelectionCount: photosLimit - imageItems.count, selectionBehavior: .ordered) {
                        Image(.btnAddImg)
                            .resizable()
                            .frame(width: 100, height: 100)
                    }
                }
                
                
            } // HStack
            .padding(.top, 18)
            .onAppear {
                
                pickedImagesData.removeAll()
                imageItems.removeAll()
                
                let dispatchGroup = DispatchGroup()
                var imagesDataDictionary = [String: Data]()
//
//                imageDictionary[activity] = activity.urls.map { ImageItem(id: nil, source: .url($0)) }
                
                for url in activity.urls {
                    
                    imageItems.append(ImageItem(id: nil, source: .url(url)))
   
                    guard let url = URL(string: url) else { return }
                    
                    dispatchGroup.enter()
                    
                    DispatchQueue.global().async {
                        
                        defer { dispatchGroup.leave() }
                        
                        guard let data = try? Data(contentsOf: url) else { return }
                        
                        imagesDataDictionary[url.absoluteString] = data
                    }
                }
                
                print("imageDictionary: \(imagesDataDictionary)")

                dispatchGroup.notify(queue: .main) {

                    for url in activity.urls {

                        if let url = URL(string: url), let data = imagesDataDictionary[url.absoluteString] {
                            pickedImagesData.append(data)
                        }
                    }
                }
            }
            .onChange(of: pickedImageItems) { _ in
                Task {
                    
                    var pickedImagesDataArray: [Data] = []
                    var imagesArray: [ImageItem] = []
                    
                    for item in pickedImageItems {
                        
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            pickedImagesDataArray.append(data)
                            if let image = UIImage(data: data) {
                                imagesArray.append(ImageItem(id: nil, source: .uiImage(image)))
                            }
                        }
                        
                    }
                    
                    pickedImagesData.append(contentsOf: pickedImagesDataArray)
                    imageItems.append(contentsOf: imagesArray)
                    pickedImageItems.removeAll()
                    
                    print("pickedImageData 출력: \(pickedImagesData)")
                    
                }
            }
        } // ScrollView

    }
}
