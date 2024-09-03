//
//  FriendListView.swift
//  FeatureFriendInterface
//
//  Created by 정현우 on 9/2/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

public struct FriendListView: View {
	@Perception.Bindable var store: StoreOf<FriendListStore>
	
	public init(store: StoreOf<FriendListStore>) {
		self.store = store
	}
	
	public var body: some View {
		WithPerceptionTracking {
			VStack(spacing: 20) {
				searchSection
					.padding(.top, 20)
					.padding(.horizontal, 30)
				
				friendListSection
					.padding(.horizontal, 22)
				
			}
			.overlay(alignment: .bottomTrailing) {
				addFriendButton
			}
			.namoPopupView(
				isPresented: $store.showAddFriendPopup,
				title: "새 친구",
				content: {
					addFriendPopup
				}
			)
			.namoPopupView(
				isPresented: $store.showFriendInfoPopup,
				title: "친구 정보",
				content: {
					friendInfoPopup
				}
			)
			.namoToastView(
				isPresented: $store.showAddFriendRequestToast,
				title: store.addFriendRequestToastMessage
			)
		}
    }
	
	private var searchSection: some View {
		HStack(spacing: 32) {
			VStack(spacing: 4) {
				HStack(spacing: 8) {
					Image(asset: SharedDesignSystemAsset.Assets.icSearch)
						.resizable()
						.frame(width: 20, height: 20)
					
					TextField(
						"",
						text: $store.friendSearchTerm,
						prompt: Text("닉네임 혹은 이름 입력")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.textPlaceholder)
					)
					.font(.pretendard(.regular, size: 15))
				}
				
				Rectangle()
					.fill(Color.textPlaceholder)
					.frame(height: 1)
			}
			
			
			Button(
				action: {
					
				},
				label: {
					Text("검색")
						.font(.pretendard(.bold, size: 15))
						.background {
							RoundedRectangle(cornerRadius: 4)
								.fill(Color.mainOrange)
								.frame(width: 58, height: 30)
						}
				}
			)
			.tint(Color.white)

		}
	}
	
	private var friendListSection: some View {
		ScrollView {
			LazyVStack(spacing: 20) {
				ForEach(store.friends, id: \.id) { friend in
					FriendItemView(
						friend: friend,
						favoriteToggleAction: {
							store.send(.favoriteBtnTapped(friend.id))
						}
					)
					.onTapGesture {
						store.send(.showFriendInfoPopup(friend))
					}
				}
			}
			.padding(.top, 3)
			.padding(.horizontal, 3)
			
			Spacer()
				.frame(height: 100)
		}
		.scrollIndicators(.hidden)
	}
	
	private var addFriendButton: some View {
		Button(
			action: {
				store.send(.showAddFriendPopup, animation: .default)
			},
			label: {
				Image(asset: SharedDesignSystemAsset.Assets.floatingAdd)
					.resizable()
					.frame(width: 56, height: 56)
			}
		)
		.padding(.trailing, 24)
		.padding(.bottom, 24)
	}
	
	private var addFriendPopup: some View {
		VStack(spacing: 0) {
			HStack(spacing: 0) {
				Text("닉네임")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
				
				Spacer()
				
				VStack(spacing: 4) {
					TextField(
						"",
						text: $store.addFriendNickname,
						prompt: Text("입력")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.textPlaceholder)
					)
					.font(.pretendard(.regular, size: 15))
					
					Rectangle()
						.fill(Color.textPlaceholder)
						.frame(height: 1)
				}
				.frame(maxWidth: 180)
			}
			.padding(.bottom, 24)
			
			HStack(spacing: 0) {
				Text("태그 4자리")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
				
				Spacer()
				
				VStack(spacing: 4) {
					TextField(
						"",
						text: $store.addFriendTag,
						prompt: Text("입력")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.textPlaceholder)
					)
					.font(.pretendard(.regular, size: 15))
					
					Rectangle()
						.fill(Color.textPlaceholder)
						.frame(height: 1)
				}
				.frame(maxWidth: 180)
			}
			.padding(.bottom, 32)
			
			Button(
				action: {
					store.send(.addFriendRequestTapped)
				}, label: {
					HStack(spacing: 12) {
						Image(asset: SharedDesignSystemAsset.Assets.icAddFriend)
							.resizable()
							.frame(width: 20, height: 20)
						
						Text("친구 신청")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.colorBlack)
					}
					.padding(.horizontal, 20)
					.padding(.vertical, 10)
					.background(
						Capsule()
							.stroke(Color.colorBlack, lineWidth: 1)
					)
				}
			)
		}
		.padding(.top, 36)
		.padding(.bottom, 30)
		.padding(.horizontal, 32)
		.onAppear() {
			store.send(.resetAddFriendState)
		}
	}
	
	private var friendInfoPopup: some View {
		VStack(alignment: .leading, spacing: 0) {
			if let friend = store.selectedFriend {
				friendInfoPopupImageAndNickname(friend: friend)
				.padding(.bottom, 20)
				
				friendInfoPopupDescriptionAndBirth(friend: friend)
				.padding(.bottom, 32)
				
				friendInfoPopupButtons(friend: friend)
			}
		}
		.padding(.horizontal, 30)
		.padding(.top, 20)
		.padding(.bottom, 26)
	}
	
	private func friendInfoPopupImageAndNickname(friend: DummyFriend) -> some View {
		HStack(spacing: 0) {
			friend.image
				.frame(width: 72, height: 72)
				.clipShape(RoundedRectangle(cornerRadius: 15))
				.padding(.trailing, 20)
			
			VStack(alignment: .leading, spacing: 6) {
				Text(friend.nickname)
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
					.lineLimit(1)
				
				Text("#\(friend.tag)")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
					.lineLimit(1)
			}
			
			Spacer(minLength: 20)
			
			Button(
				action: {
					store.send(.favoriteBtnTappedInInfo)
				}, label: {
					Image(asset: friend.isFavorite ? SharedDesignSystemAsset.Assets.icFavoriteFill : SharedDesignSystemAsset.Assets.icFavorite)
						.resizable()
						.frame(width: 28, height: 28)
				}
			)
		}
	}
	
	private func friendInfoPopupDescriptionAndBirth(friend: DummyFriend) -> some View {
		VStack(alignment: .leading, spacing: 0) {
			Text(friend.description)
				.font(.pretendard(.regular, size: 15))
				.foregroundStyle(Color.mainText)
				.padding(.bottom, 16)
			
			HStack {
				Text("이름")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
				
				Spacer()
				
				Text(friend.name)
					.font(.pretendard(.regular, size: 15))
					.foregroundStyle(Color.mainText)
			}
			.padding(.bottom, 16)
			
			HStack {
				Text("생일")
					.font(.pretendard(.bold, size: 15))
					.foregroundStyle(Color.mainText)
				
				Spacer()
				
				Text(friend.birthday)
					.font(.pretendard(.regular, size: 15))
					.foregroundStyle(Color.mainText)
			}
		}
	}
	
	private func friendInfoPopupButtons(friend: DummyFriend) -> some View {
		HStack {
			Spacer(minLength: 0)
			
			Button(
				action: {
				
				}, label: {
					HStack(spacing: 12) {
						Image(asset: SharedDesignSystemAsset.Assets.icTrashcan)
							.resizable()
							.frame(width: 20, height: 20)
						
						Text("일정")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.colorBlack)
					}
					.frame(width: 120, height: 40)
					.background(
						Capsule()
							.stroke(Color.colorBlack, lineWidth: 1)
					)
				}
			)
			.padding(.horizontal, 16)
			
			Button(
				action: {
					
				}, label: {
					HStack(spacing: 12) {
						Image(asset: SharedDesignSystemAsset.Assets.icCalendar)
							.resizable()
							.frame(width: 20, height: 20)
						
						Text("삭제")
							.font(.pretendard(.regular, size: 15))
							.foregroundColor(Color.colorBlack)
					}
					.frame(width: 120, height: 40)
					.background(
						Capsule()
							.stroke(Color.colorBlack, lineWidth: 1)
					)
				}
			)
			
			Spacer(minLength: 0)
			
		}
	}
}
