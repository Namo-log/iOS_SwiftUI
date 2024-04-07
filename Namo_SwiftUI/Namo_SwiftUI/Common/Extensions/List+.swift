//
//  List+.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 3/15/24.
//

import RealmSwift

extension List {
	func toArray<T>() -> [T] {
		return self.compactMap({$0 as? T})
	}
}
