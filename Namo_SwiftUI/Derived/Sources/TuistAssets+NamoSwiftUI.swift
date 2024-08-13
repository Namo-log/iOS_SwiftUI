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
public enum NamoSwiftUIAsset: Sendable {
  public enum Assets {
  public static let accentColor = NamoSwiftUIColors(name: "AccentColor")
    public static let blue = NamoSwiftUIColors(name: "Blue")
    public static let mainGray = NamoSwiftUIColors(name: "MainGray")
    public static let mainOrange = NamoSwiftUIColors(name: "MainOrange")
    public static let mainText = NamoSwiftUIColors(name: "MainText")
    public static let pink = NamoSwiftUIColors(name: "Pink")
    public static let purple = NamoSwiftUIColors(name: "Purple")
    public static let textBackground = NamoSwiftUIColors(name: "TextBackground")
    public static let textDisabled = NamoSwiftUIColors(name: "TextDisabled")
    public static let textPlaceholder = NamoSwiftUIColors(name: "TextPlaceholder")
    public static let textUnselected = NamoSwiftUIColors(name: "TextUnselected")
    public static let yellow = NamoSwiftUIColors(name: "Yellow")
    public static let arrow = NamoSwiftUIImages(name: "Arrow")
    public static let arrowBasic = NamoSwiftUIImages(name: "ArrowBasic")
    public static let logo = NamoSwiftUIImages(name: "Logo")
    public static let addNewCategory = NamoSwiftUIImages(name: "addNewCategory")
    public static let appLogoSquare2 = NamoSwiftUIImages(name: "app_logo_square 2")
    public static let btnAddImg = NamoSwiftUIImages(name: "btnAddImg")
    public static let btnAddImgWithoutLogo = NamoSwiftUIImages(name: "btnAddImgWithoutLogo")
    public static let btnAddRecord = NamoSwiftUIImages(name: "btn_add_record")
    public static let btnAddRecordOrange = NamoSwiftUIImages(name: "btn_add_record_orange")
    public static let btnCopy = NamoSwiftUIImages(name: "btn_copy")
    public static let btnSkip = NamoSwiftUIImages(name: "btn_skip")
    public static let checkMark = NamoSwiftUIImages(name: "checkMark")
    public static let downChevron = NamoSwiftUIImages(name: "downChevron")
    public static let downChevronBold = NamoSwiftUIImages(name: "downChevronBold")
    public static let dummy = NamoSwiftUIImages(name: "dummy")
    public static let floatingAdd = NamoSwiftUIImages(name: "floatingAdd")
    public static let icArrowOnlyHead = NamoSwiftUIImages(name: "icArrowOnlyHead")
    public static let icBack = NamoSwiftUIImages(name: "icBack")
    public static let icBackArrowOrange = NamoSwiftUIImages(name: "icBackArrowOrange")
    public static let icBackArrowWhite = NamoSwiftUIImages(name: "icBackArrowWhite")
    public static let icBottomCustomNoSelect = NamoSwiftUIImages(name: "icBottomCustomNoSelect")
    public static let icBottomCustomSelect = NamoSwiftUIImages(name: "icBottomCustomSelect")
    public static let icBottomDiaryNoSelect = NamoSwiftUIImages(name: "icBottomDiaryNoSelect")
    public static let icBottomDiarySelect = NamoSwiftUIImages(name: "icBottomDiarySelect")
    public static let icBottomHomeNoSelect = NamoSwiftUIImages(name: "icBottomHomeNoSelect")
    public static let icBottomHomeSelect = NamoSwiftUIImages(name: "icBottomHomeSelect")
    public static let icBottomShareNoSelect = NamoSwiftUIImages(name: "icBottomShareNoSelect")
    public static let icBottomShareSelect = NamoSwiftUIImages(name: "icBottomShareSelect")
    public static let icChevronBottomBlack = NamoSwiftUIImages(name: "icChevronBottomBlack")
    public static let icDiary = NamoSwiftUIImages(name: "icDiary")
    public static let icEditDiary = NamoSwiftUIImages(name: "icEditDiary")
    public static let icGroup = NamoSwiftUIImages(name: "icGroup")
    public static let icImageDelete = NamoSwiftUIImages(name: "icImageDelete")
    public static let icImageDownload = NamoSwiftUIImages(name: "icImageDownload")
    public static let icMap = NamoSwiftUIImages(name: "icMap")
    public static let icMore = NamoSwiftUIImages(name: "icMore")
    public static let icMoreVertical = NamoSwiftUIImages(name: "icMoreVertical")
    public static let icPencil = NamoSwiftUIImages(name: "icPencil")
    public static let icTrash = NamoSwiftUIImages(name: "icTrash")
    public static let icTrashWhite = NamoSwiftUIImages(name: "icTrashWhite")
    public static let icCannotDelete = NamoSwiftUIImages(name: "ic_cannot_delete")
    public static let icDeleteSchedule = NamoSwiftUIImages(name: "ic_delete_schedule")
    public static let icLoginApple = NamoSwiftUIImages(name: "ic_login_apple")
    public static let icLoginKakao = NamoSwiftUIImages(name: "ic_login_kakao")
    public static let icLoginNaver1 = NamoSwiftUIImages(name: "ic_login_naver 1")
    public static let isSelectedFalse = NamoSwiftUIImages(name: "isSelectedFalse")
    public static let isSelectedTrue = NamoSwiftUIImages(name: "isSelectedTrue")
    public static let loginLogo = NamoSwiftUIImages(name: "loginLogo")
    public static let mapPinRed = NamoSwiftUIImages(name: "map_pin_red")
    public static let mapPinSelected = NamoSwiftUIImages(name: "map_pin_selected")
    public static let mongi1 = NamoSwiftUIImages(name: "mongi 1")
    public static let rightChevronLight = NamoSwiftUIImages(name: "rightChevronLight")
    public static let settings = NamoSwiftUIImages(name: "settings")
    public static let upChevron = NamoSwiftUIImages(name: "upChevron")
    public static let upChevronBold = NamoSwiftUIImages(name: "upChevronBold")
    public static let vector1 = NamoSwiftUIImages(name: "vector1")
    public static let vector2 = NamoSwiftUIImages(name: "vector2")
    public static let whiteBlack = NamoSwiftUIImages(name: "white_black")
    public static let whiteBlackRound10 = NamoSwiftUIImages(name: "white_black_round10")
    public static let onboarding1 = NamoSwiftUIData(name: "onboarding1")
    public static let onboarding2 = NamoSwiftUIData(name: "onboarding2")
    public static let onboarding3 = NamoSwiftUIData(name: "onboarding3")
    public static let onboarding4 = NamoSwiftUIData(name: "onboarding4")
    public static let onboarding5 = NamoSwiftUIData(name: "onboarding5")
    public static let noDiary = NamoSwiftUIImages(name: "noDiary")
    public static let noGroup = NamoSwiftUIImages(name: "noGroup")
    public static let noNetwork = NamoSwiftUIImages(name: "noNetwork")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class NamoSwiftUIColors: Sendable {
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

public extension NamoSwiftUIColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: NamoSwiftUIColors) {
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
  init(asset: NamoSwiftUIColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct NamoSwiftUIData: Sendable {
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
  convenience init?(asset: NamoSwiftUIData) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct NamoSwiftUIImages: Sendable {
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
  init(asset: NamoSwiftUIImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: NamoSwiftUIImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: NamoSwiftUIImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
