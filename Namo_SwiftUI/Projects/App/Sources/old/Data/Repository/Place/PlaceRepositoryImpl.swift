////
////  PlaceRepositoryImpl.swift
////  Namo_SwiftUI
////
////  Created by 박민서 on 2/23/24.
////
//
//import CoreNetwork
//
//final class PlaceRepositoryImpl: PlaceRepository {
//    
//    /// KakaoMapRESTAPI를 통해 입력 쿼리에 해당하는 결과를 가져옵니다.
//    func getKakaoMapPlaces(query:String) async -> KakaoMapResponseDTO? {   
//        return await APIManager.shared.performRequestWithoutBaseResponse(endPoint: PlaceEndPoint.getKakaoMapAPIRequest(query: query))
//    }
//}
