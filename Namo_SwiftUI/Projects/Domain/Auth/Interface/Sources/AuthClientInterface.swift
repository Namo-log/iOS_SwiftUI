//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/18/24.
//

import Foundation
import ComposableArchitecture

public struct AuthClient {
   
    public init() {
    }
}

extension AuthClient: TestDependencyKey {
    public static var previewValue = Self(
        
    )
    
    public static let testValue = Self(
        
    )
}
