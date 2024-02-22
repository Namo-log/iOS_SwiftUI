//
//  PlaceInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

import Factory
import SwiftUI

struct PlaceInteractorImpl: PlaceInteractor {
    
    @Injected(\.appState) private var appState
    
    func getPlaceList(query: String) async {
        <#code#>
    }
    
    func selectPlace(placeId: Int) {
        <#code#>
    }
    
}

