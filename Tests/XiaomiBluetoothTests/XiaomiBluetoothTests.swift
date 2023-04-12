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
        
        XCTAssertEqual(beacon.id, "LYWSD03MMC/8/A4:C1:38:78:3C:8D")
        XCTAssertEqual(beacon.product, .LYWSD03MMC)
        XCTAssertEqual(beacon.address?.description, "A4:C1:38:78:3C:8D")
        XCTAssertEqual(beacon.frameCounter, 8)
        XCTAssertFalse(beacon.isEncrypted)
        XCTAssertEqual(beacon.version, 5)
        XCTAssertEqual(beacon.capability, [.noBinding, .frontBinding])
        XCTAssertNil(beacon.ioCapability)
    }
    
    func testMiBeaconEncrypted() {
        
        let data: LowEnergyAdvertisingData = [0x02, 0x01, 0x06, 0x19, 0x16, 0x95, 0xFE, 0x58, 0x58, 0x5B, 0x05, 0x0D, 0x8D, 0x3C, 0x78, 0x38, 0xC1, 0xA4, 0xB3, 0x9C, 0x54, 0xED, 0x05, 0x00, 0x00, 0x66, 0x7C, 0xA0, 0xF3]
        
        guard let beacon = MiBeacon(data) else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(beacon.id, "LYWSD03MMC/13/A4:C1:38:78:3C:8D")
        XCTAssertEqual(beacon.product, .LYWSD03MMC)
        XCTAssertEqual(beacon.address?.description, "A4:C1:38:78:3C:8D")
        XCTAssertEqual(beacon.frameCounter, 13)
        XCTAssert(beacon.isEncrypted)
        XCTAssertEqual(beacon.version, 5)
        XCTAssertNil(beacon.capability)
        
        print(beacon)
    }
    
    func testCharacteristic() {
        
        /*
         Apr 12 02:26:34.992  ATT Receive      0x004C  A4:C1:38:78:3C:8D  Read Response - EBE0CCC1-7A0A-4B0C-8A1A-6FF2997DA3A6 - Value: 9209 3D6F 0B
             Read Response - EBE0CCC1-7A0A-4B0C-8A1A-6FF2997DA3A6 - Value: 9209 3D6F 0B
             Opcode: 0x0B
             Value: 9209 3D6F 0B
         */
        
        let data = Data([0x92, 0x09, 0x3D, 0x6F, 0x0B])
        guard let value = TemperatureHumidityCharacteristic(data: data) else {
            XCTFail()
            return
        }
        XCTAssertEqual(type(of: value).uuid.rawValue, "EBE0CCC1-7A0A-4B0C-8A1A-6FF2997DA3A6")
        XCTAssertEqual(value.temperature.celcius, 24.50)
        XCTAssertEqual(value.humidity.rawValue, 61)
        XCTAssertEqual(value.batteryVoltage.voltage, 2.927)
    }
}
