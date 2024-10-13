//
//  String+.swift
//  SharedUtil
//
//  Created by 박민서 on 9/28/24.
//

import Foundation

extension String {
    /// 정규식을 사용하여 문자열이 규칙에 맞는지 검증
    public func matches(regex: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let range = NSRange(location: 0, length: self.utf16.count)
            return regex.firstMatch(in: self, options: [], range: range) != nil
        } catch {
            print("Invalid regex: \(error.localizedDescription)")
            return false
        }
    }

}
