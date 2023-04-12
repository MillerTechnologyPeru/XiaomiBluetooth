//
//  Error.swift
//
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import Bluetooth
import XiaomiBluetooth

/// XiaomiBluetooth app errors.
public enum XiaomiBluetoothAppError: Error {
    
    case bluetoothUnavailable
    
    case unknownPeripheral(BluetoothAddress)
}
