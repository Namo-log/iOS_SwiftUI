//
//  ImageDetailView.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/26/24.
//

import SwiftUI
import Kingfisher

enum ImageSource: Equatable, Hashable {
    
    case url(String)
    case uiImage(UIImage)
}

struct ImageItem: Hashable {
    
    let id: Int?
    let source: ImageSource
}

struct ImageDetailView: View {
    
    // 이미지 상세보기 뷰 활성화 여부
    @Binding var isShowImageDetailScreen: Bool
    
    // 전달받는 이미지 인덱스
    @State var imageIndex: Int = 0
    
    // 이미지 배열
    @State var images: [ImageItem] = []
    
    // 이미지 다운로드 성공 Alert
    @State private var showImageDownloadSuccessAlert: Bool = false
    
    var body: some View {
        
        ZStack {
                    
            // 검은 배경
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // 이미지 TabView
            // 이전 화면에서 넘겨받은 이미지 인덱스와 바인딩
            // 전체 이미지 중 선택한 순서의 이미지가 현재 인덱스
            TabView(selection: $imageIndex) {
        
                ForEach(0..<images.count, id: \.self) { index in
                    
                    switch images[index].source {
                        
                    case .url(let url):
                        
                        KFImage(URL(string: url))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth)
                        
                    case .uiImage(let uiImage):
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenWidth)
                        
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                
                ZStack {
                    
                    HStack(spacing: 0) {
            
                        /// 뒤로 가기 버튼
                        Button {
                            
                            isShowImageDetailScreen = false
                            
                        } label: {
                            Image("icBackArrowWhite")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 30, height: 22)
                        }
            
                        Spacer()
                        
                        /// 사진 다운로드 버튼
                        Button {
                            
                            switch images[imageIndex].source {
                                
                            case .url(let url):
                                
                                guard let url = URL(string: url) else { return }
                                
                                URLSession.shared.dataTask(with: url) { data, response, error in
                                    
                                    guard let imageData = data, error == nil else { return }
                                    
                                    DispatchQueue.main.async {
                                        
                                        if let image = UIImage(data: imageData) {
                                            
                                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)

                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {

                                                showImageDownloadSuccessAlert = true
                                            }
                                        }
                                    }
                                }.resume()
                                
                            case .uiImage(let uiImage):
                                
                                // 이미지를 사진 앨범에 저장
                                UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)

                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {

                                    showImageDownloadSuccessAlert = true
                                }
                                
                            }

                        } label: {
                            
                            Image("icImageDownload")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 26, height: 26)
                        }
                    }
                    .padding()
                    .foregroundStyle(.clear)
                    
                    HStack {
                        
                        // 현재 보고 있는 사진의 인덱스
                        Text("\(imageIndex + 1)")
                            .foregroundStyle(.white)
                            .font(Font.pretendard(.bold, size: 18))
                        
                        Text(" / ")
                            .foregroundStyle(.textPlaceholder)
                            .font(Font.pretendard(.bold, size: 18))
                        
                        // UIImage 타입 배열의 크기
                        Text("\(images.count)")
                            .foregroundStyle(.textPlaceholder)
                            .font(Font.pretendard(.bold, size: 18))
                    }
                }
                
                Spacer()
                
            } // VStack
     
            if showImageDownloadSuccessAlert {
                
                VStack {
                    
                    Spacer()
                    
                    Text("이미지가 저장되었습니다.")
                        .font(Font.pretendard(.bold, size: 14))
                        .foregroundStyle(.white)
                        .padding(.horizontal, 55)
                        .padding(.vertical, 16)
                        .background(.black)
                        .cornerRadius(10)
                        .offset(y: -100)
                        .onAppear {
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                
                                showImageDownloadSuccessAlert = false
                            }
                        }
                }
            }
        } // ZStack
    }
}

#Preview {
    ImageDetailView(isShowImageDetailScreen: .constant(true))
}
