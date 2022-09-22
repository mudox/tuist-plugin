import ProjectDescription

public struct SwiftPackage {
  public let name: String
  public let githubAddress: String
  public let version: Version

  init(_ name: String, _ githubAddress: String, _ version: Version) {
    self.name = name
    self.githubAddress = githubAddress
    self.version = version
  }

  func version(_ newVersion: Version) -> Self {
    .init(name, githubAddress, newVersion)
  }

  var package: Package {
    .github(githubAddress, version)
  }

  var targetDependency: TargetDependency {
    .external(name: name)
  }
}

public extension SwiftPackage {
  // layout
  static let pinLayout = Self("PinLayout", "layoutBox/PinLayout", "1.10.3")
  static let flexLayout = Self("FlexLayout", "layoutBox/FlexLayout.git", "1.3.24")
  static let snapKit = Self("SnapKit", "SnapKit/SnapKit", "5.6.0")

  // network
  static let alamofire = Self("Alamofire", "Alamofire/Alamofire", "5.6.2")
  static let atlantis = Self("Atlantis", "ProxymanApp/atlantis", "1.18.2")

  // rx
  static let rxSwift = Self("RxSwift", "ReactiveX/RxSwift.git", "6.5.0")
}

public extension Package {
  static func github(_ token: String, _ version: Version) -> Self {
    remote(url: "https://github.com/\(token)", requirement: .upToNextMajor(from: version))
  }

  func version(_ newVersion: Version) -> Self {
    switch self {
    case let .remote(url: url, requirement: .upToNextMajor):
      return .remote(url: url, requirement: .upToNextMajor(from: newVersion))
    default:
      fatalError("Need case .remote(url, .upToNextMajor(from: version))")
    }
  }
}

public extension Package {
  // layout
  static let pinLayout = SwiftPackage.pinLayout.package
  static let flexLayout = SwiftPackage.flexLayout.package
  static let snapKit = SwiftPackage.snapKit.package

  // network
  static let alamofire = SwiftPackage.alamofire.package
  static let atlantis = SwiftPackage.atlantis.package

  // rx
  static let rxSwift = SwiftPackage.rxSwift.package
}

public extension TargetDependency {
  // layout
  static let pinLayout = SwiftPackage.pinLayout.targetDependency
  static let flexLayout = SwiftPackage.flexLayout.targetDependency
  static let snapKit = SwiftPackage.snapKit.targetDependency

  // network
  static let alamofire = SwiftPackage.alamofire.targetDependency
  static let atlantis = SwiftPackage.atlantis.targetDependency

  // rx
  static let rxSwift = SwiftPackage.rxSwift.targetDependency
}
