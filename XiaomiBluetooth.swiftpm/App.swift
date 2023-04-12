import Foundation
import SwiftUI
import CoreBluetooth
import Bluetooth
import GATT
import XiaomiBluetooth

@main
struct XiaomiBluetoothApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(Store.shared)
        }
    }
}
