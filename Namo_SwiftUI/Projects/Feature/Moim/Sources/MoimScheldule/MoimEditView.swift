//
//  MoimCreateView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem

struct MoimEditView: View {
    @State private var text = ""
    
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
                        .padding(.top, 14)
                    
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
            }
            .padding(.horizontal, 20)
            
            Button(action: {}, label: {
                Text("새 모임 시작하기")
                    .font(.pretendard(.bold, size: 15))
                    .frame(maxWidth: .infinity, minHeight: 72, alignment: .center)
                    .foregroundColor(.white)
            })
            .background(Color.mainOrange)
        }
        .padding(.top, 15)
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
            
            Image(asset: SharedDesignSystemAsset.Assets.addPictrue)
                .resizable()
                .frame(width: 55, height: 55)
        }
    }
    
    private var settingView: some View {
        VStack(spacing: 20) {
            HStack {
                Text("시작")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                Spacer()
                Text("2024.08.07 (수) 08:00 AM")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            
            HStack {
                Text("종료")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                Spacer()
                Text("2024.08.07 (수) 08:00 AM")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            
            HStack {
                Text("장소")
                    .font(.pretendard(.bold, size: 15))
                    .foregroundStyle(Color.mainText)
                Spacer()
                Text("없음")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
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
            }
            
            ParticipantListView()
        }
    }
}

//#Preview {
//    MoimComposeView()
//}
