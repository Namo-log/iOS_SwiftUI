//
//  KeyChainManager.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/23/24.
//

import Foundation
import Security

enum KeyChainError: Error {
    
    case itemNotFound
    case duplicateItem
    case invalidItemFormat
    case unknown(OSStatus)
}

class KeyChainManager {
    
    static let service = Bundle.main.bundleIdentifier
    
    // MARK: - 아이템 추가

    static func addItem(key account: String, value password: String) throws {    // acount가 key의 역할, password가 value의 역할. isForce는 중복일 떄 강제 실행 여부
        
        guard let valueData = password.data(using: .utf8) else {
            throw KeyChainError.invalidItemFormat
        }
        
        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: valueData as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            
            try updateItem(key: account, value: password)
            
//            if isForce {
//                try updateItem(key: account, value: password)
//                return
//            } else {
//                throw KeyChainError.duplicateItem
//            }
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
    
    // MARK: - 아이템 읽기
    
    static func readItem(key account: String) -> String {          // account가 키의 역할

        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: kCFBooleanTrue
        ]
        
        var result: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
//            throw KeyChainError.itemNotFound
            print("키에 맞는 값을 찾을 수 없음")
            return status.description
        }
        
        guard let readResult = result as? Data else {
//            throw KeyChainError.invalidItemFormat
            print("적합하지 않은 형식!")
            return status.description
        }
        
        // Data 타입을 String 타입으로 변환
        guard let stringValue = String(data: readResult, encoding: .utf8) else {
//            throw KeyChainError.invalidItemFormat
            print("적합하지 않은 형식")
            return status.description
        }
    
        return stringValue
    }
    
    // MARK: - 아이템 업데이트
    
    static func updateItem(key account: String, value password: String) throws {       // account가 키의 역할, value가 값의 역할
        
        guard let valueData = password.data(using: .utf8) else {
            throw KeyChainError.invalidItemFormat
        }
        
        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let attributes: [String: AnyObject] = [
            
            kSecValueData as String: valueData as AnyObject
        ]
        
        let status = SecItemUpdate(query as CFDictionary, attributes as CFDictionary)
        
        guard status != errSecDuplicateItem else {
            throw KeyChainError.duplicateItem
        }
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
    
    // MARK: - 아이템 삭제
    static func deleteItem(key account: String) throws {
        
        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
}
