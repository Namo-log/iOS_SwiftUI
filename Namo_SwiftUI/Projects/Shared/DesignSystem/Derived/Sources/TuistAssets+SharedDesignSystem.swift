// swiftlint:disable all
// swift-format-ignore-file
// swiftformat:disable all
// Generated using tuist — https://github.com/tuist/tuist

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif
#if canImport(SwiftUI)
  import SwiftUI
#endif

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
public enum SharedDesignSystemAsset: Sendable {
  public enum Assets {
  public static let accentColor = SharedDesignSystemColors(name: "AccentColor")
    public static let black = SharedDesignSystemColors(name: "Black")
    public static let blue = SharedDesignSystemColors(name: "Blue")
    public static let itemBackground = SharedDesignSystemColors(name: "ItemBackground")
    public static let mainGray = SharedDesignSystemColors(name: "MainGray")
    public static let mainOrange = SharedDesignSystemColors(name: "MainOrange")
    public static let mainText = SharedDesignSystemColors(name: "MainText")
    public static let pink = SharedDesignSystemColors(name: "Pink")
    public static let purple = SharedDesignSystemColors(name: "Purple")
    public static let textDisabled = SharedDesignSystemColors(name: "TextDisabled")
    public static let textPlaceholder = SharedDesignSystemColors(name: "TextPlaceholder")
    public static let textUnselected = SharedDesignSystemColors(name: "TextUnselected")
    public static let yellow = SharedDesignSystemColors(name: "Yellow")
    public static let arrow = SharedDesignSystemImages(name: "Arrow")
    public static let arrowBasic = SharedDesignSystemImages(name: "ArrowBasic")
    public static let check = SharedDesignSystemImages(name: "Check")
    public static let checkActive = SharedDesignSystemImages(name: "CheckActive")
    public static let logo = SharedDesignSystemImages(name: "Logo")
    public static let addNewCategory = SharedDesignSystemImages(name: "addNewCategory")
    public static let appLogoSquare2 = SharedDesignSystemImages(name: "app_logo_square 2")
    public static let btnAddImg = SharedDesignSystemImages(name: "btnAddImg")
    public static let btnAddImgWithoutLogo = SharedDesignSystemImages(name: "btnAddImgWithoutLogo")
    public static let btnAddRecord = SharedDesignSystemImages(name: "btn_add_record")
    public static let btnAddRecordOrange = SharedDesignSystemImages(name: "btn_add_record_orange")
    public static let btnCopy = SharedDesignSystemImages(name: "btn_copy")
    public static let btnSkip = SharedDesignSystemImages(name: "btn_skip")
    public static let checkMark = SharedDesignSystemImages(name: "checkMark")
    public static let downChevron = SharedDesignSystemImages(name: "downChevron")
    public static let downChevronBold = SharedDesignSystemImages(name: "downChevronBold")
    public static let dummy = SharedDesignSystemImages(name: "dummy")
    public static let floatingAdd = SharedDesignSystemImages(name: "floatingAdd")
    public static let icAddFriend = SharedDesignSystemImages(name: "icAddFriend")
    public static let icArrowOnlyHead = SharedDesignSystemImages(name: "icArrowOnlyHead")
    public static let icBack = SharedDesignSystemImages(name: "icBack")
    public static let icBackArrowOrange = SharedDesignSystemImages(name: "icBackArrowOrange")
    public static let icBackArrowWhite = SharedDesignSystemImages(name: "icBackArrowWhite")
    public static let icBottomCustomNoSelect = SharedDesignSystemImages(name: "icBottomCustomNoSelect")
    public static let icBottomCustomSelect = SharedDesignSystemImages(name: "icBottomCustomSelect")
    public static let icBottomDiaryNoSelect = SharedDesignSystemImages(name: "icBottomDiaryNoSelect")
    public static let icBottomDiarySelect = SharedDesignSystemImages(name: "icBottomDiarySelect")
    public static let icBottomHomeNoSelect = SharedDesignSystemImages(name: "icBottomHomeNoSelect")
    public static let icBottomHomeSelect = SharedDesignSystemImages(name: "icBottomHomeSelect")
    public static let icBottomShareNoSelect = SharedDesignSystemImages(name: "icBottomShareNoSelect")
    public static let icBottomShareSelect = SharedDesignSystemImages(name: "icBottomShareSelect")
    public static let icCalendar = SharedDesignSystemImages(name: "icCalendar")
    public static let icChevronBottomBlack = SharedDesignSystemImages(name: "icChevronBottomBlack")
    public static let icEditDiary = SharedDesignSystemImages(name: "icEditDiary")
    public static let icFavorite = SharedDesignSystemImages(name: "icFavorite")
    public static let icFavoriteFill = SharedDesignSystemImages(name: "icFavoriteFill")
    public static let icImageDelete = SharedDesignSystemImages(name: "icImageDelete")
    public static let icImageDownload = SharedDesignSystemImages(name: "icImageDownload")
    public static let icMore = SharedDesignSystemImages(name: "icMore")
    public static let icMoreVertical = SharedDesignSystemImages(name: "icMoreVertical")
    public static let icPencil = SharedDesignSystemImages(name: "icPencil")
    public static let icTrashWhite = SharedDesignSystemImages(name: "icTrashWhite")
    public static let icTrashcan = SharedDesignSystemImages(name: "icTrashcan")
    public static let icCannotDelete = SharedDesignSystemImages(name: "ic_cannot_delete")
    public static let icDeleteSchedule = SharedDesignSystemImages(name: "ic_delete_schedule")
    public static let icLoginApple = SharedDesignSystemImages(name: "ic_login_apple")
    public static let icLoginKakao = SharedDesignSystemImages(name: "ic_login_kakao")
    public static let icLoginNaver1 = SharedDesignSystemImages(name: "ic_login_naver 1")
    public static let icNotification = SharedDesignSystemImages(name: "ic_notification")
    public static let icNotificationActive = SharedDesignSystemImages(name: "ic_notification_active")
    public static let isSelectedFalse = SharedDesignSystemImages(name: "isSelectedFalse")
    public static let isSelectedTrue = SharedDesignSystemImages(name: "isSelectedTrue")
    public static let loginLogo = SharedDesignSystemImages(name: "loginLogo")
    public static let mapPinRed = SharedDesignSystemImages(name: "map_pin_red")
    public static let mapPinSelected = SharedDesignSystemImages(name: "map_pin_selected")
    public static let mongi1 = SharedDesignSystemImages(name: "mongi 1")
    public static let mongiIcon = SharedDesignSystemImages(name: "mongi_icon")
    public static let rightChevronLight = SharedDesignSystemImages(name: "rightChevronLight")
    public static let settings = SharedDesignSystemImages(name: "settings")
    public static let upChevron = SharedDesignSystemImages(name: "upChevron")
    public static let upChevronBold = SharedDesignSystemImages(name: "upChevronBold")
    public static let vector1 = SharedDesignSystemImages(name: "vector1")
    public static let vector2 = SharedDesignSystemImages(name: "vector2")
    public static let whiteBlack = SharedDesignSystemImages(name: "white_black")
    public static let whiteBlackRound10 = SharedDesignSystemImages(name: "white_black_round10")
    public static let onboarding1 = SharedDesignSystemData(name: "onboarding1")
    public static let onboarding2 = SharedDesignSystemData(name: "onboarding2")
    public static let onboarding3 = SharedDesignSystemData(name: "onboarding3")
    public static let onboarding4 = SharedDesignSystemData(name: "onboarding4")
    public static let onboarding5 = SharedDesignSystemData(name: "onboarding5")
    public static let icAdd = SharedDesignSystemImages(name: "ic_add")
    public static let icAddUser = SharedDesignSystemImages(name: "ic_add_user")
    public static let icAdded = SharedDesignSystemImages(name: "ic_added")
    public static let icAddedSelected = SharedDesignSystemImages(name: "ic_added_selected")
    public static let icArchive = SharedDesignSystemImages(name: "ic_archive")
    public static let icArrowLeft = SharedDesignSystemImages(name: "ic_arrow_left")
    public static let icArrowLeftThick = SharedDesignSystemImages(name: "ic_arrow_left_thick")
    public static let icCalendar = SharedDesignSystemImages(name: "ic_calendar")
    public static let icCategory = SharedDesignSystemImages(name: "ic_category")
    public static let icCheck = SharedDesignSystemImages(name: "ic_check")
    public static let icCheckCircle = SharedDesignSystemImages(name: "ic_check_circle")
    public static let icCheckCircleSelected = SharedDesignSystemImages(name: "ic_check_circle_selected")
    public static let icCircleLarge = SharedDesignSystemImages(name: "ic_circle_large")
    public static let icCircleSelectedLarge = SharedDesignSystemImages(name: "ic_circle_selected_large")
    public static let icCircleSelectedSmall = SharedDesignSystemImages(name: "ic_circle_selected_small")
    public static let icCircleSmall = SharedDesignSystemImages(name: "ic_circle_small")
    public static let icCopy = SharedDesignSystemImages(name: "ic_copy")
    public static let icCustom = SharedDesignSystemImages(name: "ic_custom")
    public static let icCustomSelected = SharedDesignSystemImages(name: "ic_custom_selected")
    public static let icDiary1 = SharedDesignSystemImages(name: "ic_diary 1")
    public static let icDiary = SharedDesignSystemImages(name: "ic_diary")
    public static let icDiarySelected = SharedDesignSystemImages(name: "ic_diary_selected")
    public static let icDivision = SharedDesignSystemImages(name: "ic_division")
    public static let icDown = SharedDesignSystemImages(name: "ic_down")
    public static let icDownThick = SharedDesignSystemImages(name: "ic_down_thick")
    public static let icDownload = SharedDesignSystemImages(name: "ic_download")
    public static let icEdit = SharedDesignSystemImages(name: "ic_edit")
    public static let icExit = SharedDesignSystemImages(name: "ic_exit")
    public static let icFilter = SharedDesignSystemImages(name: "ic_filter")
    public static let icGroup1 = SharedDesignSystemImages(name: "ic_group 1")
    public static let icGroup = SharedDesignSystemImages(name: "ic_group")
    public static let icGroupSelected = SharedDesignSystemImages(name: "ic_group_selected")
    public static let icHeart = SharedDesignSystemImages(name: "ic_heart")
    public static let icHeartSelected = SharedDesignSystemImages(name: "ic_heart_selected")
    public static let icHome = SharedDesignSystemImages(name: "ic_home")
    public static let icHomeSelected = SharedDesignSystemImages(name: "ic_home_selected")
    public static let icImage = SharedDesignSystemImages(name: "ic_image")
    public static let icInbox = SharedDesignSystemImages(name: "ic_inbox")
    public static let icIndividual = SharedDesignSystemImages(name: "ic_individual")
    public static let icLeft = SharedDesignSystemImages(name: "ic_left")
    public static let icLeftThick = SharedDesignSystemImages(name: "ic_left_thick")
    public static let icList = SharedDesignSystemImages(name: "ic_list")
    public static let icMap = SharedDesignSystemImages(name: "ic_map")
    public static let icMoire = SharedDesignSystemImages(name: "ic_moire")
    public static let icNewUpdate = SharedDesignSystemImages(name: "ic_newUpdate")
    public static let icNewUpdateNo = SharedDesignSystemImages(name: "ic_newUpdate_no")
    public static let icPin = SharedDesignSystemImages(name: "ic_pin")
    public static let icPinSelected = SharedDesignSystemImages(name: "ic_pin_selected")
    public static let icPoint = SharedDesignSystemImages(name: "ic_point")
    public static let icPointSmall = SharedDesignSystemImages(name: "ic_point_small")
    public static let icPrivate = SharedDesignSystemImages(name: "ic_private")
    public static let icRatioCircle = SharedDesignSystemImages(name: "ic_ratio_circle")
    public static let icRatioCircleSelected = SharedDesignSystemImages(name: "ic_ratio_circle_selected")
    public static let icRecord = SharedDesignSystemImages(name: "ic_record")
    public static let icRight = SharedDesignSystemImages(name: "ic_right")
    public static let icRightThick = SharedDesignSystemImages(name: "ic_right_thick")
    public static let icSearch = SharedDesignSystemImages(name: "ic_search")
    public static let icSetting = SharedDesignSystemImages(name: "ic_setting")
    public static let icShare = SharedDesignSystemImages(name: "ic_share")
    public static let icShop = SharedDesignSystemImages(name: "ic_shop")
    public static let icShopSelected = SharedDesignSystemImages(name: "ic_shop_selected")
    public static let icSquare = SharedDesignSystemImages(name: "ic_square")
    public static let icStore = SharedDesignSystemImages(name: "ic_store")
    public static let icStoreSelected = SharedDesignSystemImages(name: "ic_store_selected")
    public static let icTrash = SharedDesignSystemImages(name: "ic_trash")
    public static let icUp = SharedDesignSystemImages(name: "ic_up")
    public static let icUpThick = SharedDesignSystemImages(name: "ic_up_thick")
    public static let icXmark = SharedDesignSystemImages(name: "ic_xmark")
    public static let icXmarkWhite = SharedDesignSystemImages(name: "ic_xmark_white")
    public static let addPictrue = SharedDesignSystemImages(name: "addPictrue")
    public static let noDiary = SharedDesignSystemImages(name: "noDiary")
    public static let noGroup = SharedDesignSystemImages(name: "noGroup")
    public static let noNetwork = SharedDesignSystemImages(name: "noNetwork")
    public static let noPicture = SharedDesignSystemImages(name: "noPicture")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class SharedDesignSystemColors: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public var color: Color {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIColor: SwiftUI.Color {
      return SwiftUI.Color(asset: self)
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension SharedDesignSystemColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: SharedDesignSystemColors) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Color {
  init(asset: SharedDesignSystemColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct SharedDesignSystemData: Sendable {
  public let name: String

  #if os(iOS) || os(tvOS) || os(macOS) || os(visionOS)
  @available(iOS 9.0, macOS 10.11, visionOS 1.0, *)
  public var data: NSDataAsset {
    guard let data = NSDataAsset(asset: self) else {
      fatalError("Unable to load data asset named \(name).")
    }
    return data
  }
  #endif
}

#if os(iOS) || os(tvOS) || os(macOS) || os(visionOS)
@available(iOS 9.0, macOS 10.11, visionOS 1.0, *)
public extension NSDataAsset {
  convenience init?(asset: SharedDesignSystemData) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct SharedDesignSystemImages: Sendable {
  public let name: String

  #if os(macOS)
  public typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Image = UIImage
  #endif

  public var image: Image {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let image = bundle.image(forResource: NSImage.Name(name))
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if canImport(SwiftUI)
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public var swiftUIImage: SwiftUI.Image {
    SwiftUI.Image(asset: self)
  }
  #endif
}

#if canImport(SwiftUI)
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
public extension SwiftUI.Image {
  init(asset: SharedDesignSystemImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: SharedDesignSystemImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: SharedDesignSystemImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
