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
public enum CommonAsset {
  public enum Assets {
  public static let accentColor = CommonColors(name: "AccentColor")
    public static let blue = CommonColors(name: "Blue")
    public static let mainGray = CommonColors(name: "MainGray")
    public static let mainOrange = CommonColors(name: "MainOrange")
    public static let mainText = CommonColors(name: "MainText")
    public static let pink = CommonColors(name: "Pink")
    public static let purple = CommonColors(name: "Purple")
    public static let textBackground = CommonColors(name: "TextBackground")
    public static let textDisabled = CommonColors(name: "TextDisabled")
    public static let textPlaceholder = CommonColors(name: "TextPlaceholder")
    public static let textUnselected = CommonColors(name: "TextUnselected")
    public static let yellow = CommonColors(name: "Yellow")
    public static let arrow = CommonImages(name: "Arrow")
    public static let arrowBasic = CommonImages(name: "ArrowBasic")
    public static let logo = CommonImages(name: "Logo")
    public static let addNewCategory = CommonImages(name: "addNewCategory")
    public static let appLogoSquare2 = CommonImages(name: "app_logo_square 2")
    public static let btnAddImg = CommonImages(name: "btnAddImg")
    public static let btnAddImgWithoutLogo = CommonImages(name: "btnAddImgWithoutLogo")
    public static let btnAddRecord = CommonImages(name: "btn_add_record")
    public static let btnAddRecordOrange = CommonImages(name: "btn_add_record_orange")
    public static let btnCopy = CommonImages(name: "btn_copy")
    public static let btnSkip = CommonImages(name: "btn_skip")
    public static let checkMark = CommonImages(name: "checkMark")
    public static let downChevron = CommonImages(name: "downChevron")
    public static let downChevronBold = CommonImages(name: "downChevronBold")
    public static let dummy = CommonImages(name: "dummy")
    public static let floatingAdd = CommonImages(name: "floatingAdd")
    public static let icArrowOnlyHead = CommonImages(name: "icArrowOnlyHead")
    public static let icBack = CommonImages(name: "icBack")
    public static let icBackArrowOrange = CommonImages(name: "icBackArrowOrange")
    public static let icBackArrowWhite = CommonImages(name: "icBackArrowWhite")
    public static let icBottomCustomNoSelect = CommonImages(name: "icBottomCustomNoSelect")
    public static let icBottomCustomSelect = CommonImages(name: "icBottomCustomSelect")
    public static let icBottomDiaryNoSelect = CommonImages(name: "icBottomDiaryNoSelect")
    public static let icBottomDiarySelect = CommonImages(name: "icBottomDiarySelect")
    public static let icBottomHomeNoSelect = CommonImages(name: "icBottomHomeNoSelect")
    public static let icBottomHomeSelect = CommonImages(name: "icBottomHomeSelect")
    public static let icBottomShareNoSelect = CommonImages(name: "icBottomShareNoSelect")
    public static let icBottomShareSelect = CommonImages(name: "icBottomShareSelect")
    public static let icChevronBottomBlack = CommonImages(name: "icChevronBottomBlack")
    public static let icDiary = CommonImages(name: "icDiary")
    public static let icEditDiary = CommonImages(name: "icEditDiary")
    public static let icGroup = CommonImages(name: "icGroup")
    public static let icImageDelete = CommonImages(name: "icImageDelete")
    public static let icImageDownload = CommonImages(name: "icImageDownload")
    public static let icMap = CommonImages(name: "icMap")
    public static let icMore = CommonImages(name: "icMore")
    public static let icMoreVertical = CommonImages(name: "icMoreVertical")
    public static let icPencil = CommonImages(name: "icPencil")
    public static let icTrash = CommonImages(name: "icTrash")
    public static let icTrashWhite = CommonImages(name: "icTrashWhite")
    public static let icCannotDelete = CommonImages(name: "ic_cannot_delete")
    public static let icDeleteSchedule = CommonImages(name: "ic_delete_schedule")
    public static let icLoginApple = CommonImages(name: "ic_login_apple")
    public static let icLoginKakao = CommonImages(name: "ic_login_kakao")
    public static let icLoginNaver1 = CommonImages(name: "ic_login_naver 1")
    public static let isSelectedFalse = CommonImages(name: "isSelectedFalse")
    public static let isSelectedTrue = CommonImages(name: "isSelectedTrue")
    public static let loginLogo = CommonImages(name: "loginLogo")
    public static let mapPinRed = CommonImages(name: "map_pin_red")
    public static let mapPinSelected = CommonImages(name: "map_pin_selected")
    public static let mongi1 = CommonImages(name: "mongi 1")
    public static let rightChevronLight = CommonImages(name: "rightChevronLight")
    public static let settings = CommonImages(name: "settings")
    public static let upChevron = CommonImages(name: "upChevron")
    public static let upChevronBold = CommonImages(name: "upChevronBold")
    public static let vector1 = CommonImages(name: "vector1")
    public static let vector2 = CommonImages(name: "vector2")
    public static let whiteBlack = CommonImages(name: "white_black")
    public static let whiteBlackRound10 = CommonImages(name: "white_black_round10")
    public static let onboarding1 = CommonData(name: "onboarding1")
    public static let onboarding2 = CommonData(name: "onboarding2")
    public static let onboarding3 = CommonData(name: "onboarding3")
    public static let onboarding4 = CommonData(name: "onboarding4")
    public static let onboarding5 = CommonData(name: "onboarding5")
    public static let noDiary = CommonImages(name: "noDiary")
    public static let noGroup = CommonImages(name: "noGroup")
    public static let noNetwork = CommonImages(name: "noNetwork")
  }
  public enum PreviewAssets {
  }
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

public final class CommonColors {
  public fileprivate(set) var name: String

  #if os(macOS)
  public typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS) || os(visionOS)
  public typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  public private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if canImport(SwiftUI)
  private var _swiftUIColor: Any? = nil
  @available(iOS 13.0, tvOS 13.0, watchOS 6.0, macOS 10.15, visionOS 1.0, *)
  public private(set) var swiftUIColor: SwiftUI.Color {
    get {
      if self._swiftUIColor == nil {
        self._swiftUIColor = SwiftUI.Color(asset: self)
      }

      return self._swiftUIColor as! SwiftUI.Color
    }
    set {
      self._swiftUIColor = newValue
    }
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

public extension CommonColors.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, visionOS 1.0, *)
  convenience init?(asset: CommonColors) {
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
  init(asset: CommonColors) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }
}
#endif

public struct CommonData {
  public fileprivate(set) var name: String

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
  convenience init?(asset: CommonData) {
    let bundle = Bundle.module
    #if os(iOS) || os(tvOS) || os(visionOS)
    self.init(name: asset.name, bundle: bundle)
    #elseif os(macOS)
    self.init(name: NSDataAsset.Name(asset.name), bundle: bundle)
    #endif
  }
}
#endif

public struct CommonImages {
  public fileprivate(set) var name: String

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
  init(asset: CommonImages) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle)
  }

  init(asset: CommonImages, label: Text) {
    let bundle = Bundle.module
    self.init(asset.name, bundle: bundle, label: label)
  }

  init(decorative asset: CommonImages) {
    let bundle = Bundle.module
    self.init(decorative: asset.name, bundle: bundle)
  }
}
#endif

// swiftlint:enable all
// swiftformat:enable all
