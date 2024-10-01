////
////  GroupMainViewModel.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 7/15/24.
////
//
//import SwiftUI
//import PhotosUI
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//
//class GroupMainViewModel: ObservableObject {
//	
//	struct State {
//		// 그룹 리스트
//		var groups: [GroupInfo] = []
//		// 그룹 생성 alert 보이게
//		var showCreateGroupAlert: Bool = false
//		// 그룹 생성 시 이름
//		var groupName: String = ""
//		// PhotoPicker에서 가져온 이미지
//		var pickedItem: PhotosPickerItem?
//		// 그룹 생성 시 이미지
//		var groupImage: Data?
//		// 그룹 참여 시 코드
//		var groupCode: String = ""
//		// 그룹 탈퇴 후 토스트
//		var showWithdrewToast: Bool = false
//		var withdrewGroupName: String? = nil
//	}
//	
//	enum Action {
//		case viewDidAppear
//		// 그룹 생성
//		case closeNewGroupAlert
//		case createGroup
//		// 그룹 참가
//		case closeGroupCodeAlert
//		case participateGroup
//		// 그룹 리스트 새로고침
//		case refreshGroupList
//		// 그룹 선택
//		case selectGroup(group: GroupInfo)
//		// 그룹 생성 시 이미지 선택
//		case groupImagePicked
//	}
//	
//	let groupUseCase = GroupUseCase.shared
//	@Published var state: State
//	@Injected(\.moimState) var moimState
//	
//	
//	init(state: State = .init()) {
//		self.state = state
//	}
//	
//	func action(_ action: Action) {
//		switch action {
//		case .viewDidAppear:
//			Task {
//				await viewDidAppear()
//			}
//		case .closeNewGroupAlert:
//			Task {
//				await closeNewGroupAlert()
//			}
//		case .createGroup:
//			Task {
//				await createGroup()
//			}
//		case .closeGroupCodeAlert:
//			Task {
//				await closeGroupCodeAlert()
//			}
//		case .participateGroup:
//			Task {
//				await participateGroup()
//			}
//		case .refreshGroupList:
//			Task {
//				await refreshGroupList()
//			}
//		case let .selectGroup(group):
//			Task {
//				await selectGroup(group: group)
//			}
//		case .groupImagePicked:
//			Task {
//				await groupImagePicked()
//			}
//		}
//	}
//	
//	private func viewDidAppear() async {
//		await MainActor.run {
//			AppState.shared.isLoading = true
//		}
//		await getGroups()
//		await MainActor.run {
//			AppState.shared.isLoading = false
//		}
//	}
//	
//	private func closeNewGroupAlert() async {
//		await MainActor.run {
//			state.groupName = ""
//			state.pickedItem = nil
//			state.groupImage = nil
////			AppState.shared.alertType = nil
//			AppState.shared.isTabbarOpaque = false
//			state.showCreateGroupAlert = false
//		}
//	}
//	
//	private func createGroup() async {
//		if await groupUseCase.createGroup(groupName: state.groupName, image: state.groupImage) {
//			await getGroups()
//			await closeNewGroupAlert()
//		}
//	}
//	
//	private func participateGroup() async {
//		if await groupUseCase.participateGroup(groupCode: state.groupCode) {
//			await getGroups()
//			await closeGroupCodeAlert()
//		}
//	}
//	
//	private func closeGroupCodeAlert() async {
//		await MainActor.run {
//			state.groupCode = ""
//			AppState.shared.alertType = nil
//		}
//	}
//	
//	private func refreshGroupList() async {
//		await getGroups()
//	}
//	
//	private func groupImagePicked() async {
//		guard let item = state.pickedItem else {
//			print("image load failed")
//			return
//		}
//		
//		if let image = try? await item.loadTransferable(type: Data.self) {
//			let compressedImage = UIImage(data: image)?.jpegData(compressionQuality: 0.2)
//			await MainActor.run {
//				state.groupImage = compressedImage
//			}
//		} else {
//			print("image transfer failed")
//		}
//	}
//	
//	private func selectGroup(group: GroupInfo) async {
//		await MainActor.run {
//			moimState.currentMoim = group
//			AppState.shared.navigationPath.append(GroupViewType.detail)
//		}
//		
//		await groupUseCase.getMoimSchedule(moimId: group.groupId)
//	}
//	
//	// MARK: -  sub functions
//	private func getGroups() async {
//		let groups = await groupUseCase.getGroups()
//		await MainActor.run {
//			state.groups = groups
//		}
//	}
//}
