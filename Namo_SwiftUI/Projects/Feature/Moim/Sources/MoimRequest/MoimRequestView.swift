//
//  MoimRequestView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem
import FeatureFriend
import ComposableArchitecture

public struct MoimRequestView: View {
    
    private enum Tab: CaseIterable {
        case moimRequest
        case friendRequest
        
        var tabName: String {
            switch self {
            case .moimRequest:
                "모임 요청"
            case .friendRequest:
                "친구 요청"
            }
        }
        
        var index: Int {
            switch self {
            case .moimRequest:
                0
            case .friendRequest:
                1
            }
        }
    }
    
    let store: StoreOf<MoimRequestStore>
    
    @State private var selectedTab: Tab = .moimRequest
    @State private var tabSizes: [CGRect] = []
    
    private var padding: CGFloat = 10
    
    private var isTabSize: Bool {
        tabSizes.count == Tab.allCases.count
    }
    
    public init(store: StoreOf<MoimRequestStore>) {
        self.store = store
    }
    
    public var body: some View {
        VStack {
  
        }
        .namoNabBar(center: {
            Text("새로운 요청")
                .font(.pretendard(.bold, size: 16))
                .foregroundStyle(.black)
        }, left: {
            Button(action: {
                store.send(.backButtonTap)
            }, label: {
                Image(asset: SharedDesignSystemAsset.Assets.icArrowLeftThick)
            })
        })
    }
    
}

