//
//  MoimInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

struct MoimInteractorImpl: MoimInteractor {
	func getDummyGroups() -> [GroupDTO] {
		return [
			GroupDTO(
				groupId: 1,
				groupName: "나모iOS",
				groupImageUrl: "https://namo.s3.ap-northeast-2.amazonaws.com/memo/394e7aad-b7f2-4863-84c5-d010b39b4503.jpg",
				groupCode: "0af8f945-5685-4108-80f8-4ad1fc6d516a",
				moimUsers: [
					GroupUser(userId: 1, userName: "연현", userColor: 1),
					GroupUser(userId: 2, userName: "고흐", userColor: 2),
					GroupUser(userId: 3, userName: "램프", userColor: 3),
					GroupUser(userId: 4, userName: "서리", userColor: 4),
				]
			),
			GroupDTO(
				groupId: 2,
				groupName: "테스트",
				groupImageUrl: "https://namo.s3.ap-northeast-2.amazonaws.com/memo/394e7aad-b7f2-4863-84c5-d010b39b4503.jpg",
				groupCode: "0af8f945-5685-4108-80f8-4ad1fc6d516a",
				moimUsers: [
					GroupUser(userId: 1, userName: "연현", userColor: 1),
				]
			),
		]
	}
	
}
