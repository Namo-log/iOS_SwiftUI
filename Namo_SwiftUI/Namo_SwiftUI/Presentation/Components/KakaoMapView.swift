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
    @Binding var pinList: [Place]
    
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
                /// pinList 업데이트
                context.coordinator.updatePois(pinList: pinList)
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
    class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate {
        
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
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName:"openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 16)
            
            //KakaoMap 추가.
            if controller?.addView(mapviewInfo) == Result.OK {
                print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
                if let mapView = controller?.getView("mapview") as? KakaoMap {
                    mapView.eventDelegate = self // EventDelegate 전달
                }
                // map Layer 기본 설정
                createLabelLayer()
                createPoiStyle()
                // 기본 핀 추가
//                createPois()
            }
        }
        
        // KakaoMapEventDelegate - poi가 탭되었을 때 이벤트
        func poiDidTapped(kakaoMap: KakaoMap, layerID: String, poiID: String, position: MapPoint) {
            print("pin tapped at \(position), id:\(poiID)")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            if let poi = layer?.getPoi(poiID: poiID) {
                print("poi style 변경")
                poi.changeStyle(styleID: "selectedStyle")
            }
        }
        
        // Poi생성을 위한 LabelLayer 생성
        func createLabelLayer() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: layerOption)
        }
        
        // Poi의 Style 생성
        func createPoiStyle() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            
            // 검색 시 기본 핀
            let iconStyle = PoiIconStyle(symbol: UIImage(named: "map_pin_selected"))
            let poiStyle = PoiStyle(styleID: "defaultStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle, level: 0)])
            
            // 핀 탭시 변경되는 스타일
            let iconStyle2 = PoiIconStyle(symbol: UIImage(named: "map_pin_red"))
            let poiStyle2 = PoiStyle(styleID: "selectedStyle", styles: [PerLevelPoiStyle(iconStyle: iconStyle2, level: 0)])
            
            manager.addPoiStyle(poiStyle)
            manager.addPoiStyle(poiStyle2)
        }
        
        // Poi 생성 - 테스트용
        func createPois() {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            
            let poiOption = PoiOptions(styleID: "defaultStyle")
            poiOption.rank = 0
            poiOption.clickable = true
            
            let _ = layer?.addPois(option: poiOption, at: [MapPoint(longitude: 127.108678, latitude: 37.402001)])
            layer?.showAllPois()

        }
        
        /// map의 poi들을 Update하는 함수입니다.
        /// Binding된 pinList가 변경됨에 따라 호출되는 함수입니다.
        /// 기존 지도의 핀들은 모두 삭제되고, pinList 내의 아이템들만 지도에 표시됩니다.
        func updatePois(pinList: [Place]) {
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            
            let poiOption = PoiOptions(styleID: "defaultStyle")
            poiOption.rank = 0
            poiOption.clickable = true
            
            print("Kakao Map's pois update 실행")
            
            let pois = layer?.getAllPois().map { $0.map { return $0.itemID} } ?? []
            layer?.removePois(poiIDs: pois)
            
            var poiList: [MapPoint] = []
            
            pinList.forEach { place in
                poiList.append(MapPoint(longitude: place.y, latitude: place.x))
            }
    
            let _ = layer?.addPois(option: poiOption, at: poiList)
            layer?.showAllPois()
        }
    }
}
