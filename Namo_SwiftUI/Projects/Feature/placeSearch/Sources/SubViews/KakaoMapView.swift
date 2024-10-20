//
//  KakaoMapView.swift
//  FeatureKakaoMap
//
//  Created by 권석기 on 10/15/24.
//

import SwiftUI
import KakaoMapsSDK
import SharedUtil
import ComposableArchitecture
import FeaturePlaceSearchInterface
import Combine
public struct KakaoMapView: UIViewRepresentable {
    let store: StoreOf<PlaceSearchStore>
    
    @Binding var draw: Bool
    
    public init(store: StoreOf<PlaceSearchStore>, draw: Binding<Bool>) {
        self.store = store
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
        return KakaoMapCoordinator(store: store)
    }
    
    public class KakaoMapCoordinator: NSObject, MapControllerDelegate {
        
        public init(store: StoreOf<PlaceSearchStore>) {
            first = true
            self.store = store
            self.viewStore = ViewStoreOf<PlaceSearchStore>(store, observe: { $0 })
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
        
        public func addViewSucceeded(_ viewName: String, viewInfoName: String) {
            viewStore.publisher
                .searchList
                .sink { [weak self] placeList in
                    guard let self = self else { return }
                    guard let firstLocation = placeList.first,
                          let longitude = Double(firstLocation.x),
                          let  latitude = Double(firstLocation.y) else { return }
                    
                    moveCamera(longitude: longitude, latitude: latitude)
                }
                .store(in: &cancellables)
        }
        
        private func moveCamera(longitude: Double, latitude: Double) {
            let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
            let cameraUpdate = CameraUpdate.make(cameraPosition: CameraPosition(target: MapPoint(longitude: longitude, latitude: latitude), height: 200, rotation: 0, tilt: 0))
            
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(
                autoElevation: true, // autoElevation 컨펌 필요
                consecutive: true,
                durationInMillis: 1500))
        }
        
        private var cancellables = Set<AnyCancellable>()
        public var controller: KMController?
        public var first: Bool
        public let store: StoreOf<PlaceSearchStore>
        private let viewStore: ViewStoreOf<PlaceSearchStore>
    }
}
