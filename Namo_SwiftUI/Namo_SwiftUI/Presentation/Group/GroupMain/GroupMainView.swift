//
//  GroupMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI
import Factory

struct GroupMainView: View {
	@Injected(\.moimInteractor) var moimInteractor
	
	@State var myGroups: [GroupDTO] = []
	
	// New Group
	@State var showNewGroupAlert: Bool = false
	@State var groupName: String = ""
	
	// Group Code
	@State var showGroupCodeAlert: Bool = false
	@State var groupCode: String = ""
	
    var body: some View {
		ZStack {
			VStack(spacing: 26.5) {
				header
				
				groupList
			}
			
			if showNewGroupAlert {
				newGroupAlertView
			}
			
			if showGroupCodeAlert {
				groupCodeAlertView
			}
		}
		.padding(.top, 16.5)
		.onAppear {
			self.myGroups = moimInteractor.getDummyGroups()
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
					GroupListItem(group: group)
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
			rightButtonAction: {},
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
						
						Image(.icGroup)
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
	}
	
	private var groupCodeAlertView: some View {
		NamoAlertViewWithTopButton(
			showAlert: $showGroupCodeAlert,
			title: "그룹 코드",
			leftButtonTitle: "닫기",
			leftButtonAction: {},
			rightButtonTitle: "저장",
			rightButtonAction: {},
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


