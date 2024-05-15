//
//  PlaceInteractor.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

protocol PlaceInteractor {
    func fetchPlaceList(query: String) async 
    func getPlaceList(query: String) async -> [Place]?
    func selectPlace(place: Place?)
    func clearPlaces(isSave: Bool)
    func appendPlaceList(place: Place)
}
