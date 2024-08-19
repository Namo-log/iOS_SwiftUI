//
//  Bundle+.swift
//  Common
//
//  Created by 권석기 on 8/19/24.
//

import Foundation

extension Bundle {
    var baseUrl: String {
        guard let baseUrl = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("Couldn't find key BASE_URL in Info.plist")
        }
        return baseUrl
    }
}
