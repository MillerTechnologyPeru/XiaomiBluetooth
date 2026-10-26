// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "XiaomiBluetooth",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13),
    ],
    products: [
        .library(
            name: "XiaomiBluetooth",
            targets: ["XiaomiBluetooth"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/PureSwift/Bluetooth.git",
            from: "8.0.0"
        ),
        .package(
            url: "https://github.com/PureSwift/GATT.git",
            from: "4.0.0"
        ),
    ],
    targets: [
        
        .target(
            name: "XiaomiBluetooth",
            dependencies: [
                .product(
                    name: "Bluetooth",
                    package: "Bluetooth"
                ),
                .product(
                    name: "GATT",
                    package: "GATT"
                ),
            ]
        ),
        .testTarget(
            name: "XiaomiBluetoothTests",
            dependencies: ["XiaomiBluetooth"]
        ),
    ]
)
