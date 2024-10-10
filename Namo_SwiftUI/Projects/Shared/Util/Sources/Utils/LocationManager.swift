//
//  LocationManager.swift
//  SharedUtil
//
//  Created by 박민서 on 10/11/24.
//

import CoreLocation
import Combine

public protocol LocationManagerProtocol {
    /// 위치 권한 체크
    /// 위치 사용 가능 여부를 반환 합니다.
    func checkLocationAuthorization() -> Bool
    /// 위치 권한 요청
    func requestLocationAuthorization()
    /// 위치 업데이트 요청 - 단발성 업데이트
    /// 업데이트된 내부 위치 정보의 현재 값 하나만 반환합니다.
    func requestLocationOnce() -> CLLocation?
    /// 위치 업데이트 요청 - 지속적으로 업데이트
    /// 처음 한 번만 호출해주세요
    func requestLocationUpdate()
    /// 위치 업데이트 중단 요청 - 지속적 업데이트 중단
    /// 마지막 한 번만 호출해주세요
    func requestStopLocationUpdate()
    /// 위치 정보 퍼블리셔
    var userLocationPublisher: AnyPublisher<CLLocation?, Never> { get }
}

/// 싱글톤으로 관리되는 LocationManager 입니다.
final public class LocationManager: NSObject {
    static let shared = LocationManager()
    
    /// 내부 CLLocationManager
    private var locationManager = CLLocationManager()
    /// 유저 위치
    @Published private var userLocation: CLLocation?
    
    private override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// LocationManager 권한 상태 따른 내부 처리
    private func handleLocationAuthStatus(_ status: CLAuthorizationStatus) {
        switch status {
            
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Authorized")
            return
        case .denied, .restricted:
            // TODO: 추후 미허가 따른 처리 필요
            print("Location Not Authorized")
            return
        case .notDetermined:
            print("Location Authorization Not Determined")
            locationManager.requestWhenInUseAuthorization() // 권한 요청
            
        @unknown default:
            break
        }
    }
}

// MARK: LocationManagerProtocol
extension LocationManager: LocationManagerProtocol {
    /// 위치 정보 퍼블리셔 제공
    public var userLocationPublisher: AnyPublisher<CLLocation?, Never> {
        $userLocation.eraseToAnyPublisher()
    }
    
    /// 위치 권한 체크
    /// 위치 사용 가능 여부를 반환 합니다.
    public func checkLocationAuthorization() -> Bool {
        // OS에서 해당 앱이 위치 권한이 allow 되어있는지 확인
        guard CLLocationManager.locationServicesEnabled() else {
            // TODO: 추후 처리 방법 필요
            print("시스템 설정에서 위치 서비스 활성화가 필요합니다.")
            return false
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return true
        default:
            return false
        }
    }
    
    /// 위치 권한 요청
    public func requestLocationAuthorization() {
        // OS에서 해당 앱이 위치 권한이 allow 되어있는지 확인
        guard CLLocationManager.locationServicesEnabled() else {
            print("시스템 설정에서 위치 서비스 활성화가 필요합니다.")
            return
        }
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// 위치 업데이트 요청 - 단발성 업데이트
    /// 업데이트된 내부 위치 정보의 현재 값 하나만 반환합니다.
    /// 매번 요청 가능
    public func requestLocationOnce() -> CLLocation? {
        locationManager.requestLocation()
        return userLocation
    }
    
    /// 위치 업데이트 요청 - 지속적으로 업데이트
    /// 처음 한 번만 호출해주세요
    public func requestLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
    
    /// 위치 업데이트 중단 요청 - 지속적 업데이트 중단
    /// 마지막 한 번만 호출해주세요
    public func requestStopLocationUpdate() {
        locationManager.stopUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // 위치 업데이트 시 호출
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = locations.last else { return }
        print("Location Updated: \(userLocation)")
        self.userLocation = userLocation
    }
    
    // 위치 권한 변경 시 호출
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.handleLocationAuthStatus(manager.authorizationStatus)
    }
    
    // CLLocationManager 관련 에러 발생시 호출
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Location Error: \(error.localizedDescription)")
    }
}
