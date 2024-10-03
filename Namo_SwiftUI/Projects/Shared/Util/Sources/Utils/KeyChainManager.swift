//
//  KeyChainManager.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 10/2/24.
//

import Foundation

enum KeychainError: Error {
    case itemAddFailed(OSStatus)
    case itemUpdateFailed(OSStatus)
    case itemDeleteFailed(OSStatus)
    case itemReadFailed(OSStatus)
    case dataEncodingFailed
    case dataDecodingFailed
}

public struct KeyChainManager {
    
    // public static let service = Bundle.main.bundleIdentifier
    // TODO: Tuist Module - Bundle Identifier 관련 논의 필요
    public static let service = "com.mongmong.namo"
    
    // MARK: 키체인에 아이템 저장
    public static func addItem(key: String, value: String) throws {
        
        let valueData = value.data(using: .utf8)!
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecAttrAccessible: kSecAttrAccessibleWhenUnlocked,
            kSecValueData: valueData
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
                
        if status == errSecDuplicateItem { // key 중복 - 업데이트
            try updateItem(key: key, value: value)
        } else if status != errSecSuccess { // 중복 외 실패의 경우
            throw KeychainError.itemAddFailed(status)
        }
    }
    
    // MARK: 키체인 아이템 조회
    public static func readItem(key: String) throws -> String {
        
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key,
            kSecReturnAttributes: true,
            kSecReturnData: true
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        if status != errSecSuccess { throw KeychainError.itemReadFailed(status) }
        
        guard let existItem = item as? [String: Any],
              let data = existItem[kSecValueData as String] as? Data,
              let returnValue = String(data: data, encoding: .utf8)
        else { throw KeychainError.dataDecodingFailed }
        
        return returnValue
    }
    
    // MARK: 키체인 값 업데이트
	public static func updateItem(key: String, value: String) throws {
        guard let valueData = value.data(using: .utf8) else {
            throw KeychainError.dataEncodingFailed
        }
        
        let previousQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: key
        ]
        
        let updateQuery: [CFString: Any] = [kSecValueData: valueData]
        
        let status = SecItemUpdate(previousQuery as CFDictionary, updateQuery as CFDictionary)
        
        if status != errSecSuccess {
            throw KeychainError.itemUpdateFailed(status)
        }
    }
    
    // MARK: 키체인 아이템 삭제
	public static func deleteItem(key: String) {
        
        let deleteQuery: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                      kSecAttrService: service ?? "com.mongmong.namo",
                                      kSecAttrAccount: key]
        
        let status = SecItemDelete(deleteQuery as CFDictionary)
        if status == errSecSuccess {
            print("remove key-value data complete")
        } else {
            print("remove key-value data failed")
        }
    }
    
    // MARK: 키체인 아이템 존재 여부 확인
	public static func itemExists(key: String) -> Bool {
        
        let query: [CFString: Any] = [kSecClass: kSecClassGenericPassword,
                                kSecAttrService: service ?? "com.mongmong.namo",
                                kSecAttrAccount: key,
                                 kSecMatchLimit: kSecMatchLimitOne,
                           kSecReturnAttributes: false]
        
        let status = SecItemCopyMatching(query as CFDictionary, nil)
        
        return status == errSecSuccess
        
    }
}
