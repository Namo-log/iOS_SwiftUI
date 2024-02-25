//
//  GroupMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import PhotosUI
import Factory

struct GroupMainView: View {
	@Injected(\.moimInteractor) var moimInteractor
	@Injected(\.moimRepository) var moimRepository
	
	@State var myGroups: [Moim] = []
	
	// New Group
	@State var showNewGroupAlert: Bool = false
	@State var groupName: String = ""
	
	// Group Code
	@State var showGroupCodeAlert: Bool = false
	@State var groupCode: String = ""
	
	// photo picker
	@State var pickedItem: PhotosPickerItem?
	@State var pickedImage: Data?
	
    var body: some View {
		ZStack {
			VStack(spacing: 26.5) {
				header
				
				groupList
			}
			.padding(.top, 16.5)
			
			if showNewGroupAlert {
				newGroupAlertView
			}
			
			if showGroupCodeAlert {
				groupCodeAlertView
			}
		}
		.onAppear {
			Task {
				self.myGroups = await moimInteractor.getGroups()
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
					showNewGroupAlert = true
				})
				
				Button("그룹 코드", action: {
					showGroupCodeAlert = true
				})
			}, label: {
				Image(.icMore)
					.padding(10)
			})
			
		}
		.padding(.horizontal, 20)
	}
	
	private var groupList: some View {
		ScrollView(.vertical) {
			VStack(spacing: 20) {
				ForEach(myGroups, id: \.groupId) { group in
					NavigationLink(destination: GroupCalendarView(moim: group), label: {
						GroupListItem(group: group)
							.tint(Color.black)
					})
					
				}
				
				Spacer()
			}
		}
	}
	
	private var newGroupAlertView: some View {
		NamoAlertViewWithTopButton(
			showAlert: $showNewGroupAlert,
			title: "새 그룹",
			leftButtonTitle: "닫기",
			leftButtonAction: {},
			rightButtonTitle: "완료",
			rightButtonAction: {
				let response = await moimRepository.createMoim(groupName: groupName, image: pickedImage)
				
				// response가 잘 들어왔으면, 그룹 목록 새로고침
				if response != nil {
					Task {
						self.myGroups = await moimInteractor.getGroups()
					}
					return true
				}
				
				return false
			},
			content: AnyView(
				VStack(spacing: 0) {
					HStack {
						Text("그룹명")
							.font(.pretendard(.bold, size: 15))
						
						Spacer()
						
						TextField("입력", text: $groupName)
							.font(.pretendard(.regular, size: 15))
							.frame(width: 150)
							.overlay(alignment: .bottom) {
								Rectangle()
									.frame(width: 150, height: 1)
									.foregroundStyle(Color(.mainText))
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
						
						PhotosPicker(selection: $pickedItem, matching: .images, label: {
							if let imageData = pickedImage,
							   let uiImage = UIImage(data: imageData) {
								Image(uiImage: uiImage)
									.resizable()
									.aspectRatio(contentMode: .fill)
									.frame(width: 60, height: 60)
									.clipShape(RoundedRectangle(cornerRadius: 5))
							} else {
								Image(.icGroup)
							}
						})
						.onChange(of: pickedItem) { item in
							if item == nil {return}
							
							Task {
								if let image = try? await item?.loadTransferable(type: Data.self) {
									let compressedImage = UIImage(data: image)?.jpegData(compressionQuality: 0.2)
									pickedImage = compressedImage
								} else {
									print("image load failed")
								}
							}
						}
						
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
					.background(Color(.mainGray))
					.cornerRadius(5)
					
				}
					.padding(.top, 27)
					.padding(.bottom, 22)
			)
		)
		.onDisappear {
			groupName = ""
			pickedItem = nil
			pickedImage = nil
		}
	}
	
	private var groupCodeAlertView: some View {
		NamoAlertViewWithTopButton(
			showAlert: $showGroupCodeAlert,
			title: "그룹 코드",
			leftButtonTitle: "닫기",
			leftButtonAction: {},
			rightButtonTitle: "저장",
			rightButtonAction: {
				let response = await moimRepository.participateMoim(groupCode: groupCode)
				
				// 그룹 참여에 성공했으면, 그룹 목록 새로고침
				if response {
					Task {
						self.myGroups = await moimInteractor.getGroups()
					}
					return true
				}
				
				return false
			},
			content: AnyView(
				HStack {
					Text("그룹 코드")
						.font(.pretendard(.bold, size: 15))
					
					Spacer()
					
					TextField("입력", text: $groupCode)
						.font(.pretendard(.regular, size: 15))
						.frame(width: 150)
						.overlay(alignment: .bottom) {
							Rectangle()
								.frame(width: 150, height: 1)
								.foregroundStyle(Color(.mainText))
								.offset(y: 5)
						}
						
				}
				.padding(.top, 47)
				.padding(.bottom, 52)
			)
		)
	}
}

#Preview {
    GroupMainView()
}


