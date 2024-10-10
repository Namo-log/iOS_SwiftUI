//
//  LocationManager.swift
//  SharedUtil
//
//  Created by 박민서 on 10/11/24.
//

import CoreLocation
import Combine

final public class LocationManager: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    /// 유저 위치
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
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
