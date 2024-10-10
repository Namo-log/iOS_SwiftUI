//
//  LocationManager.swift
//  SharedUtil
//
//  Created by 박민서 on 10/11/24.
//

import CoreLocation
import Combine

final class LocationManager: NSObject, ObservableObject {
    private var locationManager = CLLocationManager()
    
    @Published var userLocation: CLLocation?
    
    override init() {
        super.init()
    }
}
