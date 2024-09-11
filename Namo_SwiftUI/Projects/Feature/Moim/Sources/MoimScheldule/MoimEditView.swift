//
//  MoimCreateView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem
import PhotosUI

struct MoimEditView: View {
    @State private var text = ""
    @State private var coverImageItem: PhotosPickerItem?
    @State private var coverImage: Image?
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var showingStartPicker = false
    @State private var showingEndPicker = false
    
    var body: some View {
        VStack(spacing: 0) {
            // title
            titleView
                .padding(.horizontal, 20)
            
            // content
            ScrollView {
                
                VStack(spacing: 30) {
                    // textField
                    TextField("내 모임", text: $text)
                        .font(.pretendard(.bold, size: 22))
                        .foregroundStyle(Color.mainText)
                        .padding(.top, 20)
                    
                    // imagePicker
                    imagePickerView
                    
                    // 장소, 시간
                    settingView
                    
                    // 친구 초대
                    participantListView
                    
                    // 일정보기 버튼
                    Button(action: {}, label: {
                        HStack(spacing: 12) {
                            Image(asset: SharedDesignSystemAsset.Assets.icCalendar)
                            Text("초대한 친구 일정 보기")
                                .font(.pretendard(.regular, size: 15))
                                .foregroundStyle(.black)
                        }
                        .background(.white)
                        .padding(.vertical, 11)
                        .padding(.horizontal, 20)
                    })
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.black, lineWidth: 1)
                    )
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom, 13)
            
            Button(action: {}, label: {
                Text("새 모임 시작하기")
                    .font(.pretendard(.bold, size: 15))
                    .frame(maxWidth: .infinity, minHeight: 82)
                    .foregroundColor(.white)
            })
            .background(Color.mainOrange)
        }
        .padding(.top, 15)
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension MoimEditView {
    
    private var titleView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {}, label: {
                Text("취소")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            })
            
            Spacer()
            
            Text("새 모임 일정")
                .font(.pretendard(.bold, size: 15))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Text("  ")
        }
    }
    
    private var imagePickerView: some View {
        HStack(spacing: 0) {
            VStack(alignment: .leading, spacing: 10) {
                Text("커버 이미지")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                
                Text("추후 변경 가능")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            
            Spacer()
            
            PhotosPicker(selection: $coverImageItem, matching: .images) {
                if let coverImage = coverImage {
                    coverImage
                        .resizable()
                        .frame(width: 55, height: 55)
                        .cornerRadius(8)
                } else {
                    Image(asset: SharedDesignSystemAsset.Assets.addPictrue)
                        .resizable()
                        .frame(width: 55, height: 55)
                }
            }
        }.onChange(of: coverImageItem, perform: { value in
            Task {
                if let loaded = try? await coverImageItem?.loadTransferable(type: Image.self) {
                    coverImage = loaded
                }
            }
        })
    }
    
    private var settingView: some View {
        VStack(spacing: 20) {
            VStack {
                HStack {
                    Text("시작")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    Spacer()
                    
                    Text("2024.08.07 (수) 08:00 AM")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                        .onTapGesture {
                            withAnimation {
                                showingStartPicker.toggle()
                            }
                        }
                }
                
                if showingStartPicker {
                    DatePicker("startTimeDatePicker", selection: $startDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .tint(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
                }
            }
            
            
            VStack {
                HStack {
                    Text("종료")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    Spacer()
                    Text("2024.08.07 (수) 08:00 AM")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                        .onTapGesture {
                            withAnimation {
                                showingEndPicker.toggle()
                            }
                        }
                }
                
                if showingEndPicker {
                    DatePicker("endTimeDatePicker", selection: $endDate)
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                        .tint(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
                }
            }
            
            HStack {
                Text("장소")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 8) {
                        Text("없음")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundStyle(Color.mainText)
                        
                        Image(asset: SharedDesignSystemAsset.Assets.icRight)
                    }
                }
            }
        }
    }
    
    private var participantListView: some View {
        VStack(spacing: 12) {
            HStack {
                Text("친구 초대하기")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                Spacer()
                    
                Button(action: {}) {
                    Image(asset: SharedDesignSystemAsset.Assets.icRight)
                }                
            }
            
            ParticipantListView()
        }
    }
}

//#Preview {
//    MoimComposeView()
//}
