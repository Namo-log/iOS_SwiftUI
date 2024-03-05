//
//  PhotoPickerListView.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/5/24.
//

import SwiftUI

import PhotosUI

// 사진 선택 리스트 뷰
struct PhotoPickerListView: View {
    
    @State var images: [UIImage] = []// 보여질 사진 목록
    @State var photosPickerItems: [PhotosPickerItem] = [] // 선택된 사진 아이템
    @State var photosLimit = 3 // 선택가능한 최대 사진 개수
    
    var body: some View {
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
    }
}

#Preview {
    PhotoPickerListView()
}
