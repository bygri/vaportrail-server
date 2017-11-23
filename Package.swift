// swift-tools-version:4.0

import PackageDescription

let package = Package(
  name: "VaportrailServer",
  products: [
    .executable(name: "vaportrail", targets: ["Run"]),
  ],
  dependencies: [
    .package(url: "https://github.com/vapor/vapor.git", .upToNextMajor(from: "2.2.0")),
    .package(url: "https://github.com/bygri/vaportrail.git", .exact("0.0.1-alpha.1")),
    .package(url: "https://github.com/vapor/mysql-provider.git", .upToNextMajor(from: "2.0.0")),
  ],
  targets: [
    .target(name: "Run",
      dependencies: ["VaportrailServer", "MySQLProvider", "Vapor"]),
  ]
)
