import ProjectDescription

public let organization = "io.github.mudox"

let team = "7UXCWSGXF6"

let defaultDeploymentTarget = "16.0"

public func frameworkTargets(
  name: String,
  platform: Platform = .iOS,
  usePlatformSuffix: Bool = false,
  deploymentTarget: String? = nil,
  dependencies _: [TargetDependency] = [],
  addTestTarget: Bool = false,
  testTargetDependencies: [TargetDependency] = []
) -> [Target] {
  var targets: [Target] = []

  let settings: Settings = .settings(base: [
    "IPHONEOS_DEPLOYMENT_TARGET": .string(deploymentTarget ?? defaultDeploymentTarget),
  ])

  let mainTargetName = usePlatformSuffix ? "\(name)_\(platform)" : name

  let mainTarget = Target(
    name: mainTargetName,
    platform: platform,
    product: .framework,
    bundleId: "\(organization).\(name).\(platform)",
    infoPlist: .default,
    sources: ["Targets/\(name)/Sources/**"],
    resources: [],
    dependencies: [],
    settings: settings
  )

  targets.append(mainTarget)

  if addTestTarget {
    let testTarget = Target(
      name: usePlatformSuffix ? "\(name)Tests_\(platform)" : "\(name)Tests" ,
      platform: platform,
      product: .unitTests,
      bundleId: "\(organization).\(name)Tests.\(platform)",
      infoPlist: .default,
      sources: ["Targets/\(name)/Tests/**"],
      resources: [],
      dependencies: [.target(name: mainTargetName)] + testTargetDependencies,
      settings: settings
    )

    targets.append(testTarget)
  }

  return targets
}

public func applicationTargets(
  name: String,
  platform: Platform = .iOS,
  usePlatformSuffix: Bool = false,
  deploymentTarget: String? = nil,
  dependencies: [TargetDependency] = [],
  addTestTarget: Bool = false,
  testTargetDependencies: [TargetDependency] = []
) -> [Target] {
  var targets: [Target] = []

  let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen",
  ]

  let settings: Settings = .settings(base: [
    "DEVELOPMENT_TEAM": .string(team),
    "IPHONEOS_DEPLOYMENT_TARGET": .string(deploymentTarget ?? defaultDeploymentTarget),
  ])

  let appTargetName = usePlatformSuffix ? "\(name)_\(platform)" : name

  let mainTarget = Target(
    name: appTargetName,
    platform: platform,
    product: .app,
    bundleId: "\(organization).\(name).\(platform)",
    infoPlist: .extendingDefault(with: infoPlist),
    sources: ["Targets/\(name)/Sources/**"],
    resources: ["Targets/\(name)/Resources/**"],
    dependencies: dependencies,
    settings: settings
  )

  targets.append(mainTarget)

  if addTestTarget {
    let testTarget = Target(
      name: usePlatformSuffix ? "\(name)Tests_\(platform)" : "\(name)Tests",
      platform: platform,
      product: .unitTests,
      bundleId: "\(organization).\(name)Tests.\(platform)",
      infoPlist: .default,
      sources: ["Targets/\(name)/Tests/**"],
      dependencies: [.target(name: "\(name)")] + testTargetDependencies,
      settings: settings
    )

    targets.append(testTarget)
  }

  return targets
}
