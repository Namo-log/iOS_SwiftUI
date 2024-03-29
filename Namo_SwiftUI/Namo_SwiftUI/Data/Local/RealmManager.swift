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
	
	private let realm: Realm
	
	private init() {
		let configuration = Realm.Configuration(
			// 테이블 수정 시 스키마 버전 +1
			schemaVersion: 1
//			migrationBlock: { migration, oldSchemaVersion in
//				// migration 작업
//				// migration은 특정 테이블 또는 속성을 Create 하는 경우는 작업 안하셔도 됩니다.
//				// 기존 테이블을 Update or Delete하는 경우만 하시면 됩니다.
//				
//				//	예시
//				if oldSchemaVersion < 1 {
//					migration.enumerateObjects(ofType: RealmSchedule.className()) { oldObject, newObject in
//						newObject!["startDate"] = String()
//					}
//				}
//			}
		)
		
		self.realm = try! Realm(configuration: configuration)
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
	 ...
	 
	 ================================================
	 
	 */
	
	/// Realm에 해당 데이터를 저장합니다.
	func writeObject<T: Object>(_ object: T) {
		do {
			try realm.write {
				realm.add(object)
			}
		} catch {
			// TODO: error handler로 처리
			print("데이터 저장 에러")
		}
	}
	
	/// 해당 타입의 데이터를 모두 가져옵니다.
	func getObjects<T: Object>(_ objectType: T.Type) -> [T] {
		return Array(realm.objects(objectType))
	}
	
	/// 해당 pk의 데이터를 가져옵니다.
	func getObject<T: Object>(_ objectType: T.Type, pk: Int) -> T? {
		return realm.object(ofType: objectType, forPrimaryKey: pk)
	}
	
	/// 해당 데이터를 삭제합니다.
	func deleteObject<T: Object>(_ object: T) {
		do {
			try realm.write {
				realm.delete(object)
			}
		} catch {
			// TODO: error handler로 처리
			print("데이터 삭제 에러")
		}
	}
	
	/// 해당 타입의 데이터를 모두 삭제합니다.
	func deleteObjects<T: Object>(_ objectType: T.Type) {
		do {
			try realm.write {
				realm.delete(realm.objects(objectType))
			}
		} catch {
			// TODO: error handler로 처리
			print("데이터 삭제 에러")
		}
	}
	
	/// 해당 데이터를 업데이트합니다.(delete and write)
	func updateObject<T: Object>(_ object: T, pk: Int) {
		guard let oldObject = getObject(T.self, pk: pk) else {
			// TODO: error handler로 처리
			print("해당 데이터가 없습니다.")
			return
		}
		
		do {
			try realm.write {
				deleteObject(oldObject)
				writeObject(object)
			}
		} catch {
			// TODO: error handler로 처리
			print("데이터 업데이트 에러")
		}
	}
}
