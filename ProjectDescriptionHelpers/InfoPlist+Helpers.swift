import ProjectDescription

public extension [String: InfoPlist.Value] {

  static let initialVersion: [String: InfoPlist.Value] =  [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
  ]

  static let storyboard: [String: InfoPlist.Value] =  [
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
  ]

  // Required since iOS 14
  // Ref: https://github.com/ProxymanApp/atlantis#required-configuration-for-ios-14
  static let atlantis: [String: InfoPlist.Value] =  [
    "NSLocalNetworkUsageDescription": "Atlantis would use Bonjour Service to discover Proxyman app from your local network.",
    "NSBonjourServices": ["_Proxyman._tcp"]
  ]

}
