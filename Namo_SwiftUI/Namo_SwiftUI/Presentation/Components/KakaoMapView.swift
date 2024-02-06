//
//  KakaoMapView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/6/24.
//

import Foundation
import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    
    /// UIView를 상속한 KMViewContainer를 생성한다.
    /// 뷰 생성과 함께 KMControllerDelegate를 구현한 Coordinator를 생성하고, 엔진을 생성 및 초기화한다.
    func makeUIView(context: Self.Context) -> KMViewContainer {
        //need to correct view size
        let view: KMViewContainer = KMViewContainer(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        context.coordinator.createController(view)
        context.coordinator.controller?.initEngine()
        
        return view
    }

    
    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    /// draw가 true로 설정되면 엔진을 시작하고 렌더링을 시작한다.
    /// draw가 false로 설정되면 렌더링을 멈추고 엔진을 stop한다.
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // DispatchQueue가 있어야 엔진이 동작합니다
                context.coordinator.controller?.startEngine()
                context.coordinator.controller?.startRendering()
            }
        }
        else {
            context.coordinator.controller?.stopRendering()
            context.coordinator.controller?.stopEngine()
        }
    }
    
    /// Coordinator 생성
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }

    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
    
    /// Coordinator 구현. KMControllerDelegate를 adopt한다.
    class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        
        var controller: KMController?
        var first: Bool

        override init() {
            first = true
            super.init()
        }
        
         // KMController 객체 생성 및 event delegate 지정
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        func addViews() {
            let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
            //지도(KakaoMap)를 그리기 위한 viewInfo를 생성
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName:"openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 7)
            
            //KakaoMap 추가.
            if controller?.addView(mapviewInfo) == Result.OK {
                print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
            }
        }
    }
}
