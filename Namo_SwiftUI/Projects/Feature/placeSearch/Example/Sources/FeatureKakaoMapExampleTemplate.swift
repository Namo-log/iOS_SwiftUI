//
//  emptyfile.swift
//  Manifests
//
//  Created by 정현우 on 10/1/24.
//

import SwiftUI
import FeaturePlaceSearch
import KakaoMapsSDK
import SharedUtil

@main
struct FeatureKakaoMapExampleApp: App {
    @State var draw: Bool = false
    
    var body: some Scene {
        WindowGroup {
            KakaoMapView(draw: $draw).onAppear(perform: {              
                self.draw = true
            }).onDisappear(perform: {
                self.draw = false
            }).frame(maxWidth: .infinity, maxHeight: 380)
            Spacer()                 
        }
    }
}
