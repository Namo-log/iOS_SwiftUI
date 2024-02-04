//
//  testDTO.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/30/24.
//

import Foundation

// get 예시용 ---------------------
struct testGetDeDTO: Decodable {
    var asdfasdfasdfasd: String
}

// post 예시용 ---------------------
struct testEnDTO: Encodable {
    var asdf: String
}

struct testDeDTOItem: Decodable {
    var asdf: String
    var test: Int
}

typealias testDeDTO = [testDeDTOItem]

// test 용 ---------------------
struct testDecodeDTOItem: Codable {
    let status: Status
    let id, user, text: String
    let v: Int
    let source, updatedAt, type, createdAt: String
    let deleted, used: Bool

    enum CodingKeys: String, CodingKey {
        case status
        case id = "_id"
        case user, text
        case v = "__v"
        case source, updatedAt, type, createdAt, deleted, used
    }
}

struct Status: Codable {
    let verified: Bool
    let sentCount: Int
}

typealias testDecodeDTO = [testDecodeDTOItem]
