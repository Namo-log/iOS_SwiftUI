//
//  KakaoMapView.swift
//  FeatureKakaoMap
//
//  Created by 권석기 on 10/15/24.
//

import SwiftUI
import KakaoMapsSDK
import SharedUtil
import SharedDesignSystem
import ComposableArchitecture
import FeaturePlaceSearchInterface
import DomainPlaceSearchInterface
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
    
    public class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
        
        public init(store: StoreOf<PlaceSearchStore>) {
            first = true
            self.store = ViewStoreOf<PlaceSearchStore>(store, observe: { $0 })
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
            let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
            mapView.eventDelegate = self
            store.publisher
                .searchList
                .sink { [weak self] placeList in
                    guard let self = self else { return }
                    guard let firstLocation = placeList.first,
                          let longitude = Double(firstLocation.x),
                          let  latitude = Double(firstLocation.y) else { return }
                    
                    moveCamera(longitude: longitude, latitude: latitude)
                    createLabelLayer()
                    createPoiStyle()
                    createPois(placeList)
                }
                .store(in: &cancellables)
            
            store.publisher
                .id
                .sink(receiveValue: selectedPoi)
                .store(in: &cancellables)
        }
        
        private func selectedPoi(poiID: String) {
            let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
            let manager = mapView.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            
            guard let pois = layer?.getAllPois(),
            let index = pois.firstIndex(where: { $0.itemID == poiID }) else { return }
            
            let latitude = pois[index].position.wgsCoord.latitude
            let longitude = pois[index].position.wgsCoord.longitude
            
            moveCamera(longitude: longitude, latitude: latitude, durationInMillis: 300)
        }
        
        private func moveCamera(longitude: Double, latitude: Double, durationInMillis: UInt = 1500) {
            let mapView: KakaoMap = controller?.getView("mapview") as! KakaoMap
            let cameraUpdate = CameraUpdate.make(cameraPosition: CameraPosition(target: MapPoint(longitude: longitude, latitude: latitude), height: 200, rotation: 0, tilt: 0))
            
            mapView.animateCamera(cameraUpdate: cameraUpdate, options: CameraAnimationOptions(
                autoElevation: true, // autoElevation 컨펌 필요
                consecutive: true,
                durationInMillis: durationInMillis))
        }
        
        private func createLabelLayer() {
            let view: KakaoMap = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: layerOption)
        }
        
        func createPoiStyle() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            
            // 검색 시 기본 핀
            
            let iconStyle = PoiIconStyle(symbol: UIImage(systemName: "pin"))
            let poiStyle = PoiStyle(styleID: "defaultStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle, level: 0)])
            
            // 핀 탭시 변경되는 스타일
            let iconStyle2 = PoiIconStyle(symbol: UIImage(named: "pin.fill"))
            let poiStyle2 = PoiStyle(styleID: "selectedStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle2, level: 0)])
            
            manager.addPoiStyle(poiStyle)
            manager.addPoiStyle(poiStyle2)
        }
        
        func createPois(_ placeList: [LocationInfo]) {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            
            let pois = layer?.getAllPois().map { $0.map { return $0.itemID} } ?? []
            layer?.removePois(poiIDs: pois)
            
            for place in placeList {
                guard let longitude = Double(place.x),
                      let latitude = Double(place.y) else { return }
                let poiOption = PoiOptions(styleID: "defaultStyle", poiID: place.id)
                
                poiOption.rank = 0
                poiOption.clickable = true
                
                let poi1 = layer?.addPoi(option:poiOption, at: MapPoint(longitude: longitude, latitude: latitude))
                
                poi1?.show()
            }
            
            layer?.showAllPois()
        }
        
        public func poiDidTapped(kakaoMap: KakaoMap, layerID: String, poiID: String, position: MapPoint) {
            // 카메라 이동
            moveCamera(longitude: position.wgsCoord.longitude, latitude: position.wgsCoord.latitude, durationInMillis: 300)
            
            // id 저장
            store.send(.poiTapped(poiID))            
        }
        
        private var cancellables = Set<AnyCancellable>()
        public var controller: KMController?
        public var first: Bool
        private let store: ViewStoreOf<PlaceSearchStore>
    }
}
