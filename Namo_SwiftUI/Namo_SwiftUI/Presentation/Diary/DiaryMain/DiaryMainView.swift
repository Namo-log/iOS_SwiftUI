//
//  DiaryMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct DiaryMainView: View {
	@State var showCalculateAlert: Bool = false
	@State var totalCost: String = ""

	let gridColumn: [GridItem] = Array(repeating: GridItem(.flexible()), count: 2)
	
	// TODO: dummy data입니다. 후에 데이터 전달 받아서 사용해주세요.
	let moimUseer: [MoimUser] = [
		MoimUser(userId: 1, userName: "연현", color: 3),
		MoimUser(userId: 2, userName: "램프", color: 2),
		MoimUser(userId: 3, userName: "고흐", color: 1),
		MoimUser(userId: 4, userName: "코코아", color: 4)
	]
	@State var selectedUser: [MoimUser] = []
	
	var body: some View {
		ZStack {
			Button(action: {
				withAnimation {
					showCalculateAlert = true
				}
			}, label: {
				Text("정산 보이기")
			})
		
			if showCalculateAlert {
				groupCalculateAlertView
			}
		}
		
	}
	
	var groupCalculateAlertView: some View {
		NamoAlertViewWithTopButton(
			showAlert: $showCalculateAlert,
			title: "정산 페이지",
			leftButtonTitle: "닫기",
			leftButtonAction: {},
			rightButtonTitle: "저장",
			rightButtonAction: {
				return true
			},
			content: AnyView(
				VStack(spacing: 20) {
					HStack(spacing: 0) {
						Text("총 금액")
							.font(.pretendard(.bold, size: 15))
						Spacer()
						HStack(spacing: 0) {
							TextField("금액 입력", text: $totalCost)
								.keyboardType(.numberPad)
								.multilineTextAlignment(.trailing)
							
							if (totalCost != "") {
								Text(" 원")
							}
						}
						.frame(width: (screenWidth-90)/2, height: 30)
						.foregroundStyle(Color.mainText)
						.padding(.trailing, 10)
						.background(Color(.mainGray))
						.clipShape(RoundedRectangle(cornerRadius: 8))
						.font(.pretendard(.regular, size: 15))
						
					}
					
					HStack {
						Text("인원 수")
							.font(.pretendard(.bold, size: 15))
						Spacer()
						HStack {
							Text("÷")
								.font(.pretendard(.regular, size: 15))
							Spacer()
							Text("\(selectedUser.count) 명")
								.font(.pretendard(.regular, size: 15))
						}
						.frame(width: (screenWidth-90)/2)
						.overlay(alignment: .bottom) {
							Rectangle()
								.fill(Color.black)
								.frame(height: 1)
								.offset(y: 10)
						}
					}
					
					HStack {
						Text("인당 금액")
							.font(.pretendard(.bold, size: 15))
						Spacer()
						if selectedUser.count == 0 {
							Text("0 원")
								.font(.pretendard(.regular, size: 15))
						} else {
							Text("\((Int(totalCost) ?? 0) / selectedUser.count) 원")
								.font(.pretendard(.regular, size: 15))
						}
					}
					
					LazyVGrid(columns: gridColumn) {
						ForEach(moimUseer, id: \.userId) { user in
							HStack(spacing: 20) {
								Button(
									action: {
										if selectedUser.contains(where: {$0 == user}) {
											selectedUser.removeAll(where: {$0 == user})
										} else {
											selectedUser.append(user)
										}
									}, label: {
										Image(selectedUser.contains(where: {$0 == user}) ? .isSelectedTrue : .isSelectedFalse)
											.resizable()
											.frame(width: 20, height: 20)
									}
								)
								
								Text(user.userName)
								Spacer()
							}
						}
					}
					
				}
					.padding(.top, 25)
					.padding(.bottom, 33)
			)
		)
	}
}

#Preview {
	DiaryMainView()
}
