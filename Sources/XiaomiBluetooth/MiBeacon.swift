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
        if frameControl.contains(.macInclude) {
            self.address = BluetoothAddress(littleEndian: BluetoothAddress(bytes: (data[5], data[6], data[7], data[8], data[9], data[10])))
        } else {
            self.address = nil
        }
    }
}
