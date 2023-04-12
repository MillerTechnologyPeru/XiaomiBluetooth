//
//  MiBeacon.swift
//  
//
//  Created by Alsey Coleman Miller on 4/11/23.
//

import Foundation
import Bluetooth
import GATT

/// Xiaomi MiBeacon
public struct MiBeacon: Equatable, Hashable {
    
    internal let frameControl: FrameControl
    
    /// Xiaomi Product Identifier
    ///
    /// Product ID, the only one for each type of product, pid needs to apply on the [Xiaomi IoT developer platform](https://iot.mi.com/new/doc/introduction/main).
    public let product: ProductID
    
    /// Serial number, used for de-doneration, different events or attribute escalation requires different Frame Counter.
    public let frameCounter: UInt8
    
    /// Device Mac address
    public let address: BluetoothAddress?
    
    /// A set of options that represent the capabilities of a device.
    public let capability: Capability?
    
    /// I/O capability, at present, only high-security BLE access will use this field, and only MiBeacon v5 version is supported.
    ///
    ///  It is only used before binding; when the binding is completed and events are reported (such as opening and closing), this field is no longer needed.
    public let ioCapability: Capability.IO?
}

extension MiBeacon: Identifiable {
    
    public var id: String {
        product.description
        + "/"
        + frameCounter.description
        + (address.flatMap { "/" + $0.rawValue } ?? "")
    }
}

public extension MiBeacon {
    
    var isEncrypted: Bool {
        frameControl.contains(.isEncrypted)
    }
    
    var version: UInt8 {
        frameControl.version
    }
}

public extension MiBeacon {
    
    static var service: BluetoothUUID { .xiaomi }
    
    init?<T: GATT.AdvertisementData>(_ advertisementData: T) {
        guard let serviceData = advertisementData.serviceData else {
            return nil
        }
        self.init(serviceData: serviceData)
    }
    
    init?(serviceData: [BluetoothUUID: Data]) {
        guard let data = serviceData[MiBeacon.service] else {
            return nil
        }
        self.init(data: data)
    }
    
    init?(data: Data) {
        self.frameControl = FrameControl(rawValue: UInt16(littleEndian: UInt16(bytes: (data[0], data[1]))))
        guard let product = ProductID(rawValue: UInt16(littleEndian: UInt16(bytes: (data[2], data[3])))) else {
            return nil
        }
        self.product = product
        self.frameCounter = data[4]
        var index = 5
        if frameControl.contains(.macInclude) {
            let bytes = data.subdataNoCopy(in: index ..< index + 6)
            index += 6
            self.address = BluetoothAddress(littleEndian: BluetoothAddress(bytes: (bytes[0], bytes[1], bytes[2], bytes[3], bytes[4], bytes[5])))
        } else {
            self.address = nil
        }
        if self.frameControl.contains(.capabilityInclude) {
            let capability = Capability(rawValue: data[index])
            self.capability = capability
            index += 1
            if capability.contains(.io) {
                self.ioCapability = Capability.IO(rawValue: UInt16(littleEndian: UInt16(bytes: (data[index], data[index + 1]))))
                index += 2
            } else {
                self.ioCapability = nil
            }
        } else {
            self.capability = nil
            self.ioCapability = nil
        }
        
    }
}

