import XCTest
import Bluetooth
import GATT
@testable import XiaomiBluetooth

final class XiaomiBluetoothTests: XCTestCase {
    
    func testMiBeacon() throws {
        
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x06, 0x0F, 0x16, 0x95, 0xFE, 0x30, 0x58, 0x5B, 0x05, 0x08, 0x8D, 0x3C, 0x78, 0x38, 0xC1, 0xA4, 0x08]
        
        guard let beacon = MiBeacon(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(beacon.product, .LYWSD03MMC)
        XCTAssertEqual(beacon.address?.description, "A4:C1:38:78:3C:8D")
        XCTAssertFalse(beacon.isEncrypted)
        XCTAssertEqual(beacon.version, 5)
        
        print(beacon)
    }
}
