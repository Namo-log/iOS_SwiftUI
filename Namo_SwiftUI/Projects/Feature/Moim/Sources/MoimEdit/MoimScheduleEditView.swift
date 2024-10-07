//
//  MoimCreateView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem
import PhotosUI
import ComposableArchitecture
import FeatureMoimInterface
import SharedUtil
import Kingfisher

public struct MoimScheduleEditView: View {
    @Perception.Bindable private var store: StoreOf<MoimEditStore>
    @ObservedObject private var viewStore: ViewStoreOf<MoimEditStore>
    
    public init(store: StoreOf<MoimEditStore>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: {$0})
    }
    
    
    /// 편집여부에 따라 보여지는 텍스트 설정
    private var title: String {
        switch viewStore.mode {
        case .compose:
            "새 모임 일정"
        case .edit:
            "모임 일정 편집"
        case .view:
            "모임 일정"
        }
    }
    
    private var buttonTitle: String {
        switch viewStore.mode {
        case .compose:
            "생성"
        case .edit:
            "저장"
        case .view:
            ""
        }
    }
    
    public  var body: some View {
        WithPerceptionTracking {
            // title
            titleView
                .padding(.horizontal, 20)
            
            // content
            ScrollView {
                
                VStack(spacing: 30) {
                    // textField
                    TextField("내 모임", text: viewStore.$title)
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
                    shoeScheduleButton
                }
                .padding(.horizontal, 30)
            }
            .padding(.bottom, 13)
        }
        .padding(.top, 15)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            store.send(.viewOnAppear)
        }
    }
}

extension MoimScheduleEditView {
    
    private var shoeScheduleButton: some View {
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
    
    private var titleView: some View {
        HStack(alignment: .center, spacing: 0) {
            Button(action: {
                store.send(.cancleButtonTapped)
            }, label: {
                Text("취소")
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            })
            
            Spacer()
            
            Text(title)
                .font(.pretendard(.bold, size: 15))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            Button(action: {
                store.send(.createButtonTapped)
            }) {
                Text(buttonTitle)
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            .opacity(viewStore.mode == .view ? 0 : 1)
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
            
            PhotosPicker(selection: viewStore.$coverImageItem, matching: .images) {
                if let coverImage = viewStore.coverImage {
                    Image(uiImage: coverImage)
                        .resizable()
                        .frame(width: 55, height: 55)
                        .cornerRadius(8)
                } else if !viewStore.imageUrl.isEmpty {
                    KFImage(URL(string: viewStore.imageUrl))
                        .resizable()
                        .frame(width: 55, height: 55)
                        .cornerRadius(8)
                } else {
                    Image(asset: SharedDesignSystemAsset.Assets.addPicture)
                        .resizable()
                        .frame(width: 55, height: 55)
                }
            }
        }
    }
    
    private var settingView: some View {
        VStack(spacing: 20) {
            VStack {
                HStack {
                    Text("시작")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
                    Spacer()
                    
                    Text(viewStore.startDate.toYMDEHM())
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                        .onTapGesture {
                            viewStore.send(.startPickerTapped)
                        }
                }
                
                if viewStore.isStartPickerPresented {
                    DatePicker("startTimeDatePicker", selection: viewStore.$startDate)
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
                    Text(viewStore.endDate.toYMDEHM())
                        .font(.pretendard(.regular, size: 15))
                        .foregroundStyle(Color.mainText)
                        .onTapGesture {
                            viewStore.send(.endPickerTapped)
                        }
                }
                
                if viewStore.isEndPickerPresented {
                    DatePicker("endTimeDatePicker", selection: viewStore.$endDate)
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
                        Text(viewStore.locationName)
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
            
            FlexibleGridView(data: viewStore.participants) { participant in
                Participant(name: participant.nickname,
                            color: Color.paletteColor(id: participant.colorId ?? 1),
                            isOwner: participant.isOwner)
            }
        }
    }
}
