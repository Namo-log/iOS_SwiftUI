//
//  LocationManager.swift
//  SharedUtil
//
//  Created by 박민서 on 10/11/24.
//

import CoreLocation
import Combine

protocol LocationManagerProtocol {
    /// 위치 권한 요청
    func requestLocationAuthorization()
    /// 위치 업데이트 요청
    func requestLocationUpdate()
}

final public class LocationManager: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    /// 유저 위치
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
}

// MARK: LocationManagerProtocol
extension LocationManager: LocationManagerProtocol {
    /// 위치 권한 요청
    func requestLocationAuthorization() {
        // OS에서 해당 앱이 위치 권한이 allow 되어있는지 확인
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation() // 위치 정보 요청
            locationManager.startUpdatingLocation() // 위치 업데이트 시작
        } else {
            print("위치 서비스 활성화가 필요합니다.")
        }
    }
    
    /// 위치 업데이트 요청
    func requestLocationUpdate() {
        locationManager.startUpdatingLocation()
    }
}

// MARK: CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    // 위치 업데이트 시 호출
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Location Updated: \(String(describing: locations.last))")
        self.userLocation = locations.last
    }
    
    // 위치 권한 변경 시 호출
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location Authorized")
        case .denied, .restricted:
            print("Location Not Authorized")
        case .notDetermined:
            print("Location Authorization Not Determined")
        default:
            break
        }
    }
}
