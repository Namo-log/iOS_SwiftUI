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
public enum NamoAppAsset: Sendable {
  public enum Assets {
  public static let accentColor = NamoAppColors(name: "AccentColor")
    public static let blue = NamoAppColors(name: "Blue")
    public static let mainGray = NamoAppColors(name: "MainGray")
    public static let mainOrange = NamoAppColors(name: "MainOrange")
    public static let mainText = NamoAppColors(name: "MainText")
    public static let pink = NamoAppColors(name: "Pink")
    public static let purple = NamoAppColors(name: "Purple")
    public static let textBackground = NamoAppColors(name: "TextBackground")
    public static let textDisabled = NamoAppColors(name: "TextDisabled")
    public static let textPlaceholder = NamoAppColors(name: "TextPlaceholder")
    public static let textUnselected = NamoAppColors(name: "TextUnselected")
    public static let yellow = NamoAppColors(name: "Yellow")
    public static let arrow = NamoAppImages(name: "Arrow")
    public static let arrowBasic = NamoAppImages(name: "ArrowBasic")
    public static let logo = NamoAppImages(name: "Logo")
    public static let addNewCategory = NamoAppImages(name: "addNewCategory")
    public static let appLogoSquare2 = NamoAppImages(name: "app_logo_square 2")
    public static let btnAddImg = NamoAppImages(name: "btnAddImg")
    public static let btnAddImgWithoutLogo = NamoAppImages(name: "btnAddImgWithoutLogo")
    public static let btnAddRecord = NamoAppImages(name: "btn_add_record")
    public static let btnAddRecordOrange = NamoAppImages(name: "btn_add_record_orange")
    public static let btnCopy = NamoAppImages(name: "btn_copy")
    public static let btnSkip = NamoAppImages(name: "btn_skip")
    public static let checkMark = NamoAppImages(name: "checkMark")
    public static let downChevron = NamoAppImages(name: "downChevron")
    public static let downChevronBold = NamoAppImages(name: "downChevronBold")
    public static let dummy = NamoAppImages(name: "dummy")
    public static let floatingAdd = NamoAppImages(name: "floatingAdd")
    public static let icArrowOnlyHead = NamoAppImages(name: "icArrowOnlyHead")
    public static let icBack = NamoAppImages(name: "icBack")
    public static let icBackArrowOrange = NamoAppImages(name: "icBackArrowOrange")
    public static let icBackArrowWhite = NamoAppImages(name: "icBackArrowWhite")
    public static let icBottomCustomNoSelect = NamoAppImages(name: "icBottomCustomNoSelect")
    public static let icBottomCustomSelect = NamoAppImages(name: "icBottomCustomSelect")
    public static let icBottomDiaryNoSelect = NamoAppImages(name: "icBottomDiaryNoSelect")
    public static let icBottomDiarySelect = NamoAppImages(name: "icBottomDiarySelect")
    public static let icBottomHomeNoSelect = NamoAppImages(name: "icBottomHomeNoSelect")
    public static let icBottomHomeSelect = NamoAppImages(name: "icBottomHomeSelect")
    public static let icBottomShareNoSelect = NamoAppImages(name: "icBottomShareNoSelect")
    public static let icBottomShareSelect = NamoAppImages(name: "icBottomShareSelect")
    public static let icChevronBottomBlack = NamoAppImages(name: "icChevronBottomBlack")
    public static let icDiary = NamoAppImages(name: "icDiary")
    public static let icEditDiary = NamoAppImages(name: "icEditDiary")
    public static let icGroup = NamoAppImages(name: "icGroup")
    public static let icImageDelete = NamoAppImages(name: "icImageDelete")
    public static let icImageDownload = NamoAppImages(name: "icImageDownload")
    public static let icMap = NamoAppImages(name: "icMap")
    public static let icMore = NamoAppImages(name: "icMore")
    public static let icMoreVertical = NamoAppImages(name: "icMoreVertical")
    public static let icPencil = NamoAppImages(name: "icPencil")
    public static let icTrash = NamoAppImages(name: "icTrash")
    public static let icTrashWhite = NamoAppImages(name: "icTrashWhite")
    public static let icCannotDelete = NamoAppImages(name: "ic_cannot_delete")
    public static let icDeleteSchedule = NamoAppImages(name: "ic_delete_schedule")
    public static let icLoginApple = NamoAppImages(name: "ic_login_apple")
    public static let icLoginKakao = NamoAppImages(name: "ic_login_kakao")
    public static let icLoginNaver1 = NamoAppImages(name: "ic_login_naver 1")
    public static let isSelectedFalse = NamoAppImages(name: "isSelectedFalse")
    public static let isSelectedTrue = NamoAppImages(name: "isSelectedTrue")
    public static let loginLogo = NamoAppImages(name: "loginLogo")
    public static let mapPinRed = NamoAppImages(name: "map_pin_red")
    public static let mapPinSelected = NamoAppImages(name: "map_pin_selected")
    public static let mongi1 = NamoAppImages(name: "mongi 1")
    public static let rightChevronLight = NamoAppImages(name: "rightChevronLight")
    public static let settings = NamoAppImages(name: "settings")
    public static let upChevron = NamoAppImages(name: "upChevron")
    public static let upChevronBold = NamoAppImages(name: "upChevronBold")
    public static let vector1 = NamoAppImages(name: "vector1")
    public static let vector2 = NamoAppImages(name: "vector2")
    public static let whiteBlack = NamoAppImages(name: "white_black")
    public static let whiteBlackRound10 = NamoAppImages(name: "white_black_round10")
    public static let onboarding1 = NamoAppData(name: "onboarding1")
    public static let onboarding2 = NamoAppData(name: "onboarding2")
    public static let onboarding3 = NamoAppData(name: "onboarding3")
    public static let onboarding4 = NamoAppData(name: "onboarding4")
    public static let onboarding5 = NamoAppData(name: "onboarding5")
    public static let noDiary = NamoAppImages(name: "noDiary")
    public static let noGroup = NamoAppImages(name: "noGroup")
    public static let noNetwork = NamoAppImages(name: "noNetwork")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class NamoAppColors: Sendable {
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

public extension NamoAppColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: NamoAppColors) {
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
  init(asset: NamoAppColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct NamoAppData: Sendable {
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
  convenience init?(asset: NamoAppData) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct NamoAppImages: Sendable {
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
  init(asset: NamoAppImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: NamoAppImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: NamoAppImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
