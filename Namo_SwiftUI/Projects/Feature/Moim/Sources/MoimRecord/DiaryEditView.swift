//
//  DiaryEditView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem

public struct DiaryEditView: View {
    @State private var showingParticipants = false
    @State private var text = ""
    @FocusState private var textEditorFocused: Bool
    
    public init() {}
    
    public var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    dateView
                    
                    participantListView
                    
                    diaryEditView
                    
                    addRecordButton
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 25)
            }
            
            Spacer()
            
            Button(action: {}, label: {
                Text("기록 저장")
                    .font(.pretendard(.bold, size: 15))
                    .frame(maxWidth: .infinity, minHeight: 82)
                    .foregroundColor(.white)
            })
            .background(Color.mainOrange)
        }
        .namoNabBar(center: {
            Text("나모 3기 회식")
                .font(.pretendard(.bold, size: 22))
                .foregroundStyle(.black)
        }, left: {
            Button(action: {}, label: {
                Image(asset: SharedDesignSystemAsset.Assets.icArrowLeftThick)
            })
        })
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension DiaryEditView {
    private var dateView: some View {
        HStack(spacing: 25) {
            VStack {
                Text("AUG")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                
                Text("07")
                    .font(.pretendard(.bold, size: 36))
                    .foregroundStyle(Color.mainText)
            }
            .padding(20)
            .background {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .black.opacity(0.15), radius: 8)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 12) {
                    Text("날짜")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    
                    Text("2024.08.07 (수) 08:00")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                }
                
                HStack(spacing: 12) {
                    Text("장소")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    Text("없음")
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                }
            }
            
            Spacer()
        }.padding(.vertical, 20)
    }
    
    private var participantListView: some View {
        VStack(spacing: 0) {
            HStack {
                Text("참석자 (10)")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                
                Spacer()
                
                Button(action: {
                    showingParticipants.toggle()
                }, label: {
                    Image(asset: SharedDesignSystemAsset.Assets.icUp)
                        .rotationEffect(.degrees(showingParticipants ? 180 : 0))
                        .animation(.none)
                })
            }
            
            if showingParticipants {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(alignment: .center) {
                        Circle()
                            .frame(width: 42, height: 42)
                            .foregroundColor(Color.mainText)
                            .overlay {
                                Image(asset: SharedDesignSystemAsset.Assets.icCalendar)
                                    .renderingMode(.template)
                                    .foregroundColor(Color.white)
                            }
                        
                        ForEach(0..<10, id: \.self) { _ in
                            Text("코코아")
                                .font(.pretendard(.bold, size: 11))
                                .foregroundStyle(Color.mainText)
                                .background {
                                    Circle()
                                        .stroke(Color.mainText, lineWidth: 2)
                                        .frame(width: 42, height: 42)
                                }
                                .padding(.horizontal, 8)
                        }
                    }
                    .frame(height: 60)
                }
            }
            
        }
    }
    
    private var diaryEditView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                // header
                HStack {
                    Text("일기장")
                        .font(.pretendard(.bold, size: 18))
                        .foregroundStyle(Color.mainText)
                    
                    Spacer()
                    
                    Image(asset: SharedDesignSystemAsset.Assets.icPrivate)
                        .renderingMode(.template)
                        .foregroundColor(Color.textPlaceholder)
                }
                
                // heart
                HStack {
                    Text("재미도")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    Spacer()
                    
                    HStack(spacing: 4) {
                        Image(asset: SharedDesignSystemAsset.Assets.icHeartSelected)
                        Image(asset: SharedDesignSystemAsset.Assets.icHeartSelected)
                        Image(asset: SharedDesignSystemAsset.Assets.icHeart)
                    }
                }
                .padding(.top, 24)
                
                // texteditor
                VStack(spacing: 10) {
                    ZStack(alignment: .topLeading) {
                        TextEditor(text: $text)
                            .focused($textEditorFocused)
                            .lineSpacing(5)
                            .font(.pretendard(.regular, size: 14))
                            .foregroundColor(Color.mainText)
                            .scrollContentBackground(.hidden)
                            .frame(height: 160)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                        
                        if text.isEmpty && !textEditorFocused {
                            Text("내용 입력")
                                .font(.pretendard(.bold, size: 14))
                                .foregroundStyle(Color.textUnselected)
                                .padding(.top, 18)
                                .padding(.bottom, 12)
                                .padding(.horizontal, 16)
                        }
                    }
                    .background(Color.itemBackground)
                    .cornerRadius(10)
                    .padding(.top, 16)
                    
                    HStack {
                        Spacer()
                        Text("\(text.count) / 200")
                            .font(.pretendard(.bold, size: 12))
                            .foregroundStyle(Color.textUnselected)
                    }
                }
                
                HStack {
                    Image(asset: SharedDesignSystemAsset.Assets.noPicture)
                        .resizable()
                        .frame(width: 92, height: 92)
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
            .padding(20)
        }
        .background(.white)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.15),
                radius: 6)
    }
    
    private var addRecordButton: some View {
        Button(action: {}, label: {
            HStack(spacing: 12) {
                Image(asset: SharedDesignSystemAsset.Assets.icDiary)
                Text("활동 추가")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(.black)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(.white)
        })
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 1)
        )
    }
}


