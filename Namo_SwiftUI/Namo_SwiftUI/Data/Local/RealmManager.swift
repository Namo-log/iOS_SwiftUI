//
//  RealmManager.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 3/15/24.
//

import Foundation
import RealmSwift

class RealmManager {
	static let shared = RealmManager()
	
	// Realm객체 생성과 실제 트랜잭션은 같은 스레드에서 수행되어야 합니다.
	// 따라서 Realm에선 매 트랜잭션 마다 새로운 인스턴스를 생성하는 것을 권장합니다.
	private func getRealm() -> Realm {
		let configuration = Realm.Configuration(
			// 테이블 수정 시 스키마 버전 +1
			schemaVersion: 2
		)
		
		return try! Realm(configuration: configuration)
	}
	
	func getRealmPath() {
		let realm = getRealm()
		print("Realm path: \(realm.configuration.fileURL!)")
	}
	
	/*
	 Schema version management
	 이 곳에 스키마 버전 업데이트 내역을 작성해주세요.
	 
	 ================================================
	 
	 version: 1
	 date: 24.03.15
	 description:
	 - RealmSchedule 테이블 생성
	 
	 ================================================
	 
	 version: 2
	 date: 24.05.13
	 description:
	 - RealmSchedule의 hasDiary속성 Optional로 변경
	 
	 ================================================
	 
	 */
	
	/// Realm에 해당 데이터를 저장합니다.
	func writeObject<T: Object>(_ object: T) {
		let realm = getRealm()
		do {
			try realm.write {
				realm.add(object)
			}
		} catch {
			ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "데이터 저장 에러"))
		}
	}
	
	/// Realm에 해당 데이터들을 저장합니다.
	func writeObjects<T: Object>(_ objects: [T]) {
		let realm = getRealm()
		objects.forEach({ object in
			do {
				try realm.write {
					realm.add(object)
				}
			} catch {
				ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "데이터 저장 에러"))
			}
		})
	}
	
	/// 해당 타입의 데이터를 모두 가져옵니다.
	func getObjects<T: Object>(_ objectType: T.Type) -> [T] {
		let realm = getRealm()
		return Array(realm.objects(objectType))
	}
	
	/// 해당 pk의 데이터를 가져옵니다.
	func getObject<T: Object>(_ objectType: T.Type, pk: Int) -> T? {
		let realm = getRealm()
		return realm.object(ofType: objectType, forPrimaryKey: pk)
	}
	
	/// 해당 데이터를 삭제합니다.
	func deleteObject<T: Object>(_ object: T) {
		let realm = getRealm()
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "데이터 삭제 에러"))
		}
	}
	
	/// 해당 타입의 데이터를 모두 삭제합니다.
	func deleteObjects<T: Object>(_ objectType: T.Type) {
		let realm = getRealm()
		do {
			try realm.write {
				realm.delete(realm.objects(objectType))
			}
		} catch {
			ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "데이터 삭제 에러"))
		}
	}
	
	/// 해당 데이터를 업데이트합니다.(delete and write)
	func updateObject<T: Object>(_ object: T, pk: Int) {
		guard let oldObject = getObject(T.self, pk: pk) else {
			ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "해당 데이터가 없습니다."))
			return
		}
		
		let realm = getRealm()
		do {
			try realm.write {
				deleteObject(oldObject)
				writeObject(object)
			}
		} catch {
			ErrorHandler.shared.handle(type: .ignore, error: AppError.customError(title: "", message: "", localizedDescription: "데이터 업데이트 에러"))
		}
	}
}
