//
//  GroupMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import PhotosUI
import Factory
import SharedDesignSystem

enum GroupViewType: Hashable {
	// TODO: detail view model 구현 후 init으로 전달로 리팩토링
//	case detail(currentGroup: Moim)
	case detail
}

struct GroupMainView: View {
	@EnvironmentObject var moimState: MoimState
	@EnvironmentObject var appState: AppState
	let moimUseCase = GroupUseCase.shared
	@StateObject var groupMainVM = GroupMainViewModel()
	
    var body: some View {
		ZStack {
			VStack(spacing: 26.5) {
				header
				
				groupList
			}
			.padding(.top, 16.5)
			
			// TODO: AppState.shared.alertType으로는 content view의 state 변경이 안됨. 개선 필요
			if groupMainVM.state.showCreateGroupAlert {
				NamoAlertViewWithTopButton(
					showAlert: $groupMainVM.state.showCreateGroupAlert,
					title: "새 그룹",
					leftButtonTitle: "닫기",
					leftButtonAction: {
						groupMainVM.action(.closeNewGroupAlert)
					},
					rightButtonTitle: "완료",
					rightButtonAction: {
						guard groupMainVM.state.groupName != "" else { return false }
						
						groupMainVM.action(.createGroup)
						return true
					},
					content: AnyView(newGroupAlertView)
				)
			}
			
			if moimState.showGroupWithdrawToast {
				VStack {
					Spacer()
					
					ToastView(toastMessage: "\(moimState.currentMoim.groupName ?? "") 그룹에서 탈퇴하셨습니다.", bottomPadding: 150)
						.onAppear {
							withAnimation {
								moimUseCase.hideToast()
							}
						}
				}
			}
		}
		.onAppear {
			groupMainVM.action(.viewDidAppear)
		}
		.navigationDestination(for: GroupViewType.self) { viewType in
			switch viewType {
			case .detail:
				GroupCalendarView()
			}
		}
	}
	
	private var header: some View {
		HStack {
			Text("Group Calendar")
				.font(.pretendard(.semibold, size: 22))
			
			Spacer()
			
			Menu(content: {
				Button("그룹 생성", action: {
					withAnimation {
//						AppState.shared.alertType = .alertWithTopButton(
//							title: "새 그룹",
//							leftButtonTitle: "닫기",
//							leftButtonAction: {
//								groupMainVM.action(.closeNewGroupAlert)
//							},
//							rightButtonTitle: "완료",
//							rightButtonAction: {
//								groupMainVM.action(.createGroup)
//							},
//							content: AnyView(newGroupAlertView)
//						)
						groupMainVM.state.showCreateGroupAlert = true
					}
				})
				
				Button("그룹 코드", action: {
					withAnimation {
						AppState.shared.alertType = .alertWithTopButton(
							title: "그룹 코드",
							leftButtonTitle: "닫기",
							leftButtonAction: {
								groupMainVM.action(.closeGroupCodeAlert)
							},
							rightButtonTitle: "저장",
							rightButtonAction: {
								groupMainVM.action(.participateGroup)
							},
							content: AnyView(groupCodeAlertView)
						)
					}
				})
			}, label: {
				Image(asset: SharedDesignSystemAsset.Assets.icMore)
					.padding(10)
			})
			
		}
		.padding(.horizontal, 20)
	}
	
	private var noGroup: some View {
		VStack(spacing: 45) {
			Image(asset: SharedDesignSystemAsset.Assets.noGroup)
			
			Text("그룹 리스트가 없습니다\n그룹을 추가해 보세요!")
				.font(.pretendard(.light, size: 15))
				.lineLimit(2)
				.multilineTextAlignment(.center)
				.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
			
			Spacer()
			
		}
		.padding(.top, 151)
	}
	
	private var groupList: some View {
		VStack(spacing: 0) {
			if appState.isLoading {
				ProgressView()
				Spacer()
			} else if groupMainVM.state.groups.isEmpty {
				noGroup
			} else {
				ScrollView(.vertical, showsIndicators: false) {
					VStack(spacing: 20) {
						ForEach(groupMainVM.state.groups, id: \.groupId) { moim in
							GroupListItem(moim: moim)
								.tint(Color.black)
								.onTapGesture {
									groupMainVM.action(.selectGroup(group: moim))
								}
						}
						
						Spacer()
							.frame(height: 100)
					}
				}
				.refreshable {
					Task {
						await moimUseCase.getGroups()
					}
				}
			}
		}
	}
	
	private var newGroupAlertView: some View {
		VStack(spacing: 0) {
			HStack {
				Text("그룹명")
					.font(.pretendard(.bold, size: 15))
				
				Spacer()
				
				TextField("입력", text: $groupMainVM.state.groupName)
					.font(.pretendard(.regular, size: 15))
					.frame(width: 150)
					.overlay(alignment: .bottom) {
						Rectangle()
							.frame(width: 150, height: 1)
							.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
							.offset(y: 5)
					}
					
			}
			.padding(.bottom, 30)
			
			HStack(alignment: .top) {
				VStack(alignment: .leading, spacing: 10) {
					Text("커버 이미지")
						.font(.pretendard(.bold, size: 15))
					
					Text("추후 변경 불가")
						.font(.pretendard(.regular, size: 15))
				}
				
				Spacer()
				
				PhotosPicker(selection: $groupMainVM.state.pickedItem, matching: .images, label: {
					if let imageData = groupMainVM.state.groupImage,
					   let uiImage = UIImage(data: imageData) {
						Image(uiImage: uiImage)
							.resizable()
							.aspectRatio(contentMode: .fill)
							.frame(width: 60, height: 60)
							.clipShape(RoundedRectangle(cornerRadius: 5))
					} else {
						Image(asset: SharedDesignSystemAsset.Assets.icGroup)
					}
				})
				
			}
			.padding(.bottom, 20)
			
			HStack(spacing: 0) {
				Text("그룹 코드")
					.font(.pretendard(.bold, size: 15))
					.padding(.leading, 29)
				
				Spacer()
				
				Text("-")
					.font(.pretendard(.regular, size: 15))
					.padding(.trailing, 73)
			}
			.frame(height: 40)
			.frame(maxWidth: .infinity)
			.background(Color(asset: SharedDesignSystemAsset.Assets.mainGray))
			.cornerRadius(5)
			
		}
		.padding(.top, 27)
		.padding(.bottom, 22)
		.onDisappear {
			groupMainVM.action(.closeNewGroupAlert)
		}
		.onChange(of: groupMainVM.state.pickedItem) { item in
			groupMainVM.action(.groupImagePicked)
		}
	}
	
	private var groupCodeAlertView: some View {
		HStack {
			Text("그룹 코드")
				.font(.pretendard(.bold, size: 15))
			
			Spacer()
			
			TextField("입력", text: $groupMainVM.state.groupCode)
				.font(.pretendard(.regular, size: 15))
				.frame(width: 150)
				.overlay(alignment: .bottom) {
					Rectangle()
						.frame(width: 150, height: 1)
						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
						.offset(y: 5)
				}
				
		}
		.padding(.top, 47)
		.padding(.bottom, 52)
		.onDisappear {
			groupMainVM.action(.closeGroupCodeAlert)
		}
	}
}

#Preview {
    GroupMainView()
}


