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

    static func addItem(account: String, value: String, isForce: Bool) throws {    // acount가 키의 역할, value가 값의 역할
        
        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: value as AnyObject
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            
            if isForce {
                try updateItem(account: account, value: value)
                return
            } else {
                throw KeyChainError.duplicateItem
            }
        }
        
        guard status == errSecSuccess else {
            throw KeyChainError.unknown(status)
        }
    }
    
    
    // MARK: - 아이템 읽기
    
    static func readItem(account: String) throws -> Data {          // account가 키의 역할
        
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
            throw KeyChainError.itemNotFound
        }
        
        guard let readResult = result as? Data else {
            throw KeyChainError.invalidItemFormat
        }
        
        return readResult
    }
    
    
    // MARK: - 아이템 업데이트
    
    static func updateItem(account: String, value: String) throws {       // account가 키의 역할, value가 값의 역할
        
        let query: [String:AnyObject] = [
            
            kSecAttrService as String: service as AnyObject,
            kSecAttrAccount as String: account as AnyObject,
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: value as AnyObject
        ]
        
        let attributes: [String: AnyObject] = [
            
            kSecValueData as String: value as AnyObject
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
    static func deleteItem(account: String) throws {
        
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
