//
//  KakaoMapView.swift
//  FeatureKakaoMap
//
//  Created by 권석기 on 10/15/24.
//

import SwiftUI
import KakaoMapsSDK
import SharedUtil

public struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    
    public init(draw: Binding<Bool>) {
        self._draw = draw        
    }
    
    public func makeUIView(context: Context) -> some KMViewContainer {
        SDKInitializer.InitSDK(appKey: SecretConstants.kakaoMapNativeAppKey)
        let view: KMViewContainer = KMViewContainer()
        view.sizeToFit()
        context.coordinator.createController(view)
        
        return view
    }
    
    public func updateUIView(_ uiView: UIViewType, context: Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                context.coordinator.controller?.prepareEngine()
                context.coordinator.controller?.activateEngine()
            }
        }
        else {
            context.coordinator.controller?.resetEngine()
        }
    }
    
    public func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator()
    }
    
    public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        
        public override init() {
            first = true
            super.init()
        }
        
        public func addViews() {
            let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001)
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
            
            controller?.addView(mapviewInfo)
        }
        
        // KMController 객체 생성 및 event delegate 지정
        public func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }    
        
        public var controller: KMController?
        public var first: Bool
    }
}
