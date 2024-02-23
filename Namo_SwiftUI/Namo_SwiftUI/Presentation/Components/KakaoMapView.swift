//
//  KakaoMapView.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/6/24.
//

import Foundation
import SwiftUI
import KakaoMapsSDK
import Factory

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    @Binding var pinList: [Place]
    @Binding var selectedPlace: Place?
    
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
                context.coordinator.updatePois(pinList: pinList, selectedPlace: selectedPlace)
                /// pin tracking - is it really needed?
//                context.coordinator.trackFirstPin(pinList: pinList)
            }
        }
        else {
            context.coordinator.controller?.stopRendering()
            context.coordinator.controller?.stopEngine()
            // KakaoMapCoordinator의 Observer 등록 해제
            NotificationCenter.default.removeObserver(context.coordinator)
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
        /// KakaoMapController
        var controller: KMController?
//        var isFirst: Bool = true // 필요없을지도
        /// Map에서 참조하는 PlaceList 입니다.
        /// 해당 배열에 저장된 Place들을 기반으로 지도에 표시되고, 행동합니다.
        var pinList: [Place] = []
        /// 현재 지도 상에서 선택된 Place Poi입니다. - 이전에 선택된 poiID의 의미를 내포합니다
        var selectedPoi: String?
        /// 현재 화면 상(App)에서 선택된 Place 입니다. - 외부에서 주입된 선택된 Place입니다
        var selectedPlace: Place?
        
        /// appState의 placeState와 상호작용하기 위한 Interactor입니다
        @Injected(\.placeInteractor) var placeInteractor
        
        override init() {
            super.init()
            // KakaoMapView 외부와의 상호작용 위한 Observer 등록
            NotificationCenter.default.addObserver(self, selector: #selector(handlePlace(_:)), name: NSNotification.Name("SendPlace"), object: nil)
        }
        
        deinit {
            // Observer 등록 해제
            NotificationCenter.default.removeObserver(self)
        }
        
        // KMController 객체 생성 및 event delegate 지정
        func createController(_ view: KMViewContainer) {
            controller = KMController(viewContainer: view)
            controller?.delegate = self
        }
        
        // KakaoMap 기본 설정 및 view 추가
        func addViews() {
            let defaultPosition: MapPoint = MapPoint(longitude: 127.108678, latitude: 37.402001) // 추후 사용자 현재 위치 매니징 필요
            //지도(KakaoMap)를 그리기 위한 viewInfo를 생성
            let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", appName:"openmap", viewInfoName: "map", defaultPosition: defaultPosition, defaultLevel: 17)
            
            //KakaoMap 추가.
            if controller?.addView(mapviewInfo) == Result.OK {
                print("OK") //추가 성공. 성공시 추가적으로 수행할 작업을 진행한다.
                if let mapView = controller?.getView("mapview") as? KakaoMap {
                    mapView.eventDelegate = self // EventDelegate 전달
                    // map Layer 기본 설정
                    createLabelLayer(mapView)
                    createPoiStyle(mapView)
                }
            }
        }
        
        /// Place 선택 이벤트 Notification 처리 함수
        @objc func handlePlace(_ notification: Notification) {
            if let userInfo = notification.userInfo,
               let place = userInfo["place"] as? Place {
                placeInteractor.selectPlace(place: place)
            }
        }
        
        // MARK: Poi
        
        // Poi생성을 위한 LabelLayer 생성
        func createLabelLayer(_ view: KakaoMap) {
            let manager = view.getLabelManager()
            let layerOption = LabelLayerOptions(layerID: "PoiLayer", competitionType: .none, competitionUnit: .symbolFirst, orderType: .rank, zOrder: 0)
            let _ = manager.addLabelLayer(option: layerOption)
        }
        
        // Poi의 Style 생성
        func createPoiStyle(_ view: KakaoMap) {
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
        func updatePois(pinList: [Place], selectedPlace: Place?) {
            self.pinList = pinList // 내부 관리 pinList 저장
            self.selectedPlace = selectedPlace // 내부 관리 selectedPlace 저장
            
            // controller에서 "mapview"로 선언된 view 갖고오기
            guard let view = controller?.getView("mapview") as? KakaoMap else { return }
            let manager = view.getLabelManager() // view에 존재하는 labelManager 갖고오기
            let layer = manager.getLabelLayer(layerID: "PoiLayer") // labelManager에서 "PoiLayer"로 선언된 layer 갖고오기
            
            // guiManager 추가 후 원래 존재하던 infoWindow 삭제
            let guiManager = view.getGuiManager()
            guiManager.infoWindowLayer.clear()
            
            // 기존 layer에 존재하던 모든 Poi 삭제
            let pois = layer?.getAllPois().map { $0.map { return $0.itemID} } ?? []
            layer?.removePois(poiIDs: pois)
            
            // poi MapPoint Mapping
            let poiList = pinList.map { return MapPoint(longitude: $0.x, latitude: $0.y) }

            // poi Options 생성
            let poiOptions = pinList.map { place in
                let poiOption = PoiOptions(styleID: "defaultStyle", poiID: String(place.id))
                poiOption.rank = 0
                poiOption.clickable = true
                return poiOption
            }
            
            // layer에 optionList와 poiList를 1:1 mapping하여 추가
            let _ = layer?.addPois(options: poiOptions, at: poiList)
            // pois 공개
            layer?.showAllPois()
            
            // poi select 표시 해야하는 경우
            // Binding된 SelectedPlace가 존재하고, pinList에 해당 SelectedPlace가 존재할 때
            if let selectedPlace = self.selectedPlace, let pin = pinList.first(where: { $0.id == selectedPlace.id }) {
                DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                    self.showSelectionAtPoi(poiID: String(pin.id))
                }
            }
        }
        
        // KakaoMapEventDelegate - poi가 탭되었을 때 이벤트 delgate
        func poiDidTapped(kakaoMap: KakaoMap, layerID: String, poiID: String, position: MapPoint) {
            // pinList에서 해당 poiID에 해당하는 Place 확인
            if let place = pinList.first(where: { $0.id == Int(poiID) }) {
                // appState의 selectedPlace 변경
                placeInteractor.selectPlace(place: place)
            }
        }
        
        /// 특정 poiID에 해당하는 Poi를 kakaoMapView에서 선택합니다
        /// 선택된 poi는 selectedStyle로 변경되며, 카메라 시점이 변경됩니다.
        /// KakaoMapView에서 "선택 표시"를 담당하는 것이지, appState를 변경하지 않습니다.
        func showSelectionAtPoi(poiID: String) {
            guard let view = controller?.getView("mapview") as? KakaoMap else { return }
            let manager = view.getLabelManager()
            let layer = manager.getLabelLayer(layerID: "PoiLayer")
//            let trackingManager = view.getTrackingManager() // view에 존재하는 trackingManager 갖고오기 -> 안쓸듯
            
            // 현재 선택한 Poi
            if let curPoi = layer?.getPoi(poiID: poiID) {
                
                // 이전에 선택한 Poi 스타일 되돌리기
                if let selectedPoi = self.selectedPoi, let prePoi = layer?.getPoi(poiID: selectedPoi) {
                    prePoi.changeStyle(styleID: "defaultStyle")
                }
                // 선택한 poi 스타일 지정
                curPoi.changeStyle(styleID: "selectedStyle")
                
                // infoWindow 표시
                if let place = pinList.first(where: { $0.id == Int(poiID) }) {
                    createInfoWindow(view: view, position: MapPoint(longitude: place.x, latitude: place.y), place: place)
                }
                
                // TrackingManager에서 _currentDirectionArraPoi의 tracking을 시작한다.
//                if trackingManager.isTracking {
//                    trackingManager.stopTracking()
//                }
//                trackingManager.startTrackingPoi(curPoi)
//                print("TrackingCurrPinON")
                
                // 현재 Poi의 위치를 받아 카메라를 이동
                moveCamera(view: view, position: curPoi.position)
                // 지도에서 선택된 poi 업데이트
                self.selectedPoi = poiID
            }
        }
        
        /// pinList의 첫번째 place에 해당하는 Poi를 Track하게 합니다.
        /// Binding된 pinList가 변경됨에 따라 호출되는 함수입니다.
//        func trackFirstPin(pinList: [Place]) {
//            let view = controller?.getView("mapview") as! KakaoMap
//            let manager = view.getLabelManager()
//            let layer = manager.getLabelLayer(layerID: "PoiLayer")
//            let trackingManager = view.getTrackingManager()
//            // 현재 선택한 Poi
//            if let poiID = pinList.first?.id, let curPoi = layer?.getPoi(poiID: String(poiID)) {
//                // TrackingManager에서 _currentDirectionArraPoi의 tracking을 시작한다.
//                trackingManager.startTrackingPoi(curPoi)
//                print("TrackinFirstPinOn")
//            }
//        }
        
        /// 입력받은 position의 위치로 Camera를 이동합니다.
        /// isAnimate 변수에 따라 이동 시 애니메이션의 유무를 설정 가능합니다. - 기본 값은 true입니다.
        func moveCamera(view: KakaoMap, position: MapPoint, isAnimate: Bool = true) {
            // CameraUpdateType을 CameraPosition으로 생성하여 지도의 카메라를 특정 좌표로 이동시킨다. MapPoint, 카메라가 바라보는 높이, 회전각 및 틸트를 지정할 수 있다.
            let cameraUpdate = CameraUpdate.make(cameraPosition: CameraPosition(target: position, height: 200, rotation: 0, tilt: 0)) // height 확정 필요

            if isAnimate {
                //지정한 CameraUpdate 대로 카메라 애니메이션을 시작한다.
                //애니메이션의 옵션을 지정할 수 있다.
                //autoElevation : 장거리 이동시 카메라 높낮이를 올려 이동을 잘 보이도록 하는 애니메이션.
                //consecutive : animateCamera를 연속적으로 호출하는 경우, 각 애니메이션을 이어서 연속적으로 수행한다.
                //durationInMiliis : 애니메이션 동작시간(ms).
                view.animateCamera(
                    cameraUpdate: cameraUpdate,
                    options: CameraAnimationOptions(
                        autoElevation: true, // autoElevation 컨펌 필요
                        consecutive: true,
                        durationInMillis: 1500))
            } else {
                //애니메이션 없이 CameraUpdate에 지정된대로 카메라를 즉시 조정.
                view.moveCamera(cameraUpdate)
            }
        }
        
        // MARK: InfoWindow
        
        /// 컴포넌트를 구성하여 해당 위치에 place의 내용으로 InfoWindow를 생성한다.
        func createInfoWindow(view: KakaoMap, position: MapPoint, place: Place?) {

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
            
        /// GUI가 클릭될 때 발생하는 이벤트 delgate
        func guiDidTapped(_ gui: KakaoMapsSDK.GuiBase, componentName: String) {
            print("Gui: \(gui.name), Component: \(componentName) tapped")
            
            // InfoWindow의 position을 업데이트한다.
    //            (gui as? InfoWindow)?.position = MapPoint(longitude: 126.996, latitude: 37.533)
        }
        
    }
}



