//
//  PetRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation
import Alamofire

/// `PetRepository의 Implement Class` 입니다.
final class Example_PetRepositoryImpl: Example_PetRepository  {
    func fetchPetInfo(id: Int) async -> getPetInfoResponseModel? {
        return await APIManager.shared.performRequestOld(endPoint: Example_PetEndPoint.getPetInfo(id: id))
    }
    
    func fetchAllPetInfo() async -> getAllPetsResponseModel? {
        return await APIManager.shared.performRequestOld(endPoint: Example_PetEndPoint.getAllPets)
    }
    
    func updatePetInfo(id: Int, dto: postPetInfoUpdateRequestModel) async -> postPetInfoUpdateResponseModel? {
        return await APIManager.shared.performRequestOld(endPoint: Example_PetEndPoint.postPetInfoUpdate(id: id, dto: dto))
    }
    
    func deletePetInfo(id: Int) async -> deletePetResponseModel? {
        return await APIManager.shared.performRequestOld(endPoint: Example_PetEndPoint.deletePet(id: id))
    }
    
    
}
