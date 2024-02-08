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
    class KakaoMapCoordinator: NSObject, MapControllerDelegate, KakaoMapEventDelegate, GuiEventDelegate {
        
        var controller: KMController?
        var first: Bool
        var pinList: [Place] = []

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
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName:"openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 17)
            
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
        
        // MARK: Poi
        
        // KakaoMapEventDelegate - poi가 탭되었을 때 이벤트
        func poiDidTapped(kakaoMap: KakaoMap, layerID: String, poiID: String, position: MapPoint) {
            print("pin tapped at \(position), id:\(poiID)")
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            if let poi = layer?.getPoi(poiID: poiID) {
                layer?.getAllPois()?.forEach { poi in
                    poi.changeStyle(styleID: "defaultStyle")
                }
                print("poi style 변경")
                poi.changeStyle(styleID: "selectedStyle")
                print("infoWindow 표시")
                let place = pinList.first(where: { $0.id == Int(poiID) })
                createInfoWindow(position: position, place: place)
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
        
        /// map의 poi들을 Update하는 함수입니다.
        /// Binding된 pinList가 변경됨에 따라 호출되는 함수입니다.
        /// 기존 지도의 핀들은 모두 삭제되고, pinList 내의 아이템들만 지도에 표시됩니다.
        func updatePois(pinList: [Place]) {
            self.pinList = pinList
            let view = controller?.getView("mapview") as! KakaoMap
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
            
            print("Kakao Map's pois update 실행")
            
            let pois = layer?.getAllPois().map { $0.map { return $0.itemID} } ?? []
            layer?.removePois(poiIDs: pois)
        
            let poiList = pinList.map { return MapPoint(longitude: $0.y, latitude: $0.x) }
    
            let poiOptions = pinList.map { place in
                let poiOption = PoiOptions(styleID: "defaultStyle", poiID: String(place.id))
                poiOption.rank = 0
                poiOption.clickable = true
                return poiOption
            }
            
            let _ = layer?.addPois(options: poiOptions, at: poiList)
            layer?.showAllPois()
        }
        
        // MARK: InfoWindow
        
        // 컴포넌트를 구성하여 해당 위치에 place의 내용으로 InfoWindow를 생성한다.
        func createInfoWindow(position: MapPoint, place: Place?) {
            let view = controller?.getView("mapview") as! KakaoMap

            let guiManager = view.getGuiManager()
            // guiManager 추가 후 원래 존재하던 infoWindow 삭제
            guiManager.infoWindowLayer.clear()
            
            // InfoWindow객체 생성
            let infoWindow = InfoWindow("infoWindow");
            
            // bodyImage
            let bodyImage = GuiImage("bgImage")
            bodyImage.image = UIImage(named: "white_black_round10.png")
            bodyImage.imageStretch = GuiEdgeInsets(top: 9, left: 9, bottom: 9, right: 9)
            
            // tailImage
            let tailImage = GuiImage("tailImage")
            tailImage.image = UIImage(named: "white_black.png")
            
            //bodyImage의 child로 들어갈 layout.
            let layout: GuiLayout = GuiLayout("layout")
            layout.arrangement = .horizontal    //가로배치
            let button1: GuiButton = GuiButton(place?.name ?? "이름 없음")
            button1.image = UIImage.vector3
            button1.align.hAlign = .center
            button1.align.vAlign = .middle
            button1.imageSize = .init(width: 20, height: 20)
            button1.padding = .init(left: 10, right: 5, top: 10, bottom: 10)
            
            let text = GuiText("text")
            let style = TextStyle()
            text.addText(text: "\(place?.name ?? "이름 없음")", style: style)
            //Text의 정렬. Layout의 크기는 child component들의 크기를 모두 합친 크기가 되는데, Layout상의 배치에 따라 공간의 여분이 있는 component는 align을 지정할 수 있다.
            text.align = GuiAlignment(vAlign: .middle, hAlign: .left)   // 좌중단 정렬.
            
            //body image의 child component로 레이아웃을 넣는다.
            bodyImage.child = layout
            infoWindow.body = bodyImage
            infoWindow.tail = tailImage
            infoWindow.bodyOffset.y = -10
            
            // layout구성요소
            layout.addChild(text)
            layout.addChild(button1)
            
            // InfoWindow가 표시될 위치
            infoWindow.position = position
            infoWindow.positionOffset.y = -30
            infoWindow.delegate = self
            
            // guiManager를 통해 InfoWindow를 뷰에 추가한다. 뷰에 추가하기 전까지는 뷰 위에 표시되지 않는다.
            guiManager.infoWindowLayer.addInfoWindow(infoWindow)
            infoWindow.show()
        }
            
        // 버튼이 클릭될 때 발생
        func guiDidTapped(_ gui: KakaoMapsSDK.GuiBase, componentName: String) {
            print("Gui: \(gui.name), Component: \(componentName) tapped")
            
            // InfoWindow의 position을 업데이트한다.
//            (gui as? InfoWindow)?.position = MapPoint(longitude: 126.996, latitude: 37.533)
        }
        
    }
}
