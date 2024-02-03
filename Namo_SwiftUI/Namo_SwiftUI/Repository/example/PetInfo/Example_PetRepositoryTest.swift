//
//  PetRepositoryTest.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation
import Alamofire

/// `PetRepository의 Test용 Implement Class` 입니다.
final class Example_PetRepositoryTest: Example_PetRepository {
    
    func fetchPetInfo(id: Int) async -> getPetInfoResponseModel? {
        // 테스트용 구현: 임의의 값을 반환
        return getPetInfoResponseModel(pet_id: id, pet_name: "Test Pet", profile_image: "test_image.jpg", status: "Active")
    }
    
    func fetchAllPetInfo() async -> getAllPetsResponseModel? {
        // 테스트용 구현: 임의의 값을 반환
        let randomInt = Int.random(in: 1...10)
        let pet1 = getPetInfoResponseModel(pet_id: randomInt%3, pet_name: "Pet \(randomInt%3)", profile_image: "image1.jpg", status: "Active")
        let pet2 = getPetInfoResponseModel(pet_id: randomInt, pet_name: "Pet \(randomInt)", profile_image: "image2.jpg", status: "Inactive")
        return [pet1, pet2]
    }
    
    func updatePetInfo(id: Int, dto: postPetInfoUpdateRequestModel) async -> postPetInfoUpdateResponseModel? {
        // 테스트용 구현: 임의의 값을 반환
        return postPetInfoUpdateResponseModel(pet_id: id, pet_name: "Updated Pet", profile_image: "updated_image.jpg", status: "Active")
    }
    
    func deletePetInfo(id: Int) async -> deletePetResponseModel? {
        // 테스트용 구현: 임의의 값을 반환
        return deletePetResponseModel(isDeleted: true)
    }
}
