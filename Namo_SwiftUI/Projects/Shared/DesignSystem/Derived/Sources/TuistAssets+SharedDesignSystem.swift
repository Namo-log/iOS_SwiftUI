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
    public static let icDiary = SharedDesignSystemImages(name: "icDiary")
    public static let icEditDiary = SharedDesignSystemImages(name: "icEditDiary")
    public static let icFavorite = SharedDesignSystemImages(name: "icFavorite")
    public static let icFavoriteFill = SharedDesignSystemImages(name: "icFavoriteFill")
    public static let icGroup = SharedDesignSystemImages(name: "icGroup")
    public static let icImageDelete = SharedDesignSystemImages(name: "icImageDelete")
    public static let icImageDownload = SharedDesignSystemImages(name: "icImageDownload")
    public static let icMap = SharedDesignSystemImages(name: "icMap")
    public static let icMore = SharedDesignSystemImages(name: "icMore")
    public static let icMoreVertical = SharedDesignSystemImages(name: "icMoreVertical")
    public static let icPencil = SharedDesignSystemImages(name: "icPencil")
    public static let icSearch = SharedDesignSystemImages(name: "icSearch")
    public static let icTrash = SharedDesignSystemImages(name: "icTrash")
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
    public static let noDiary = SharedDesignSystemImages(name: "noDiary")
    public static let noGroup = SharedDesignSystemImages(name: "noGroup")
    public static let noNetwork = SharedDesignSystemImages(name: "noNetwork")
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
