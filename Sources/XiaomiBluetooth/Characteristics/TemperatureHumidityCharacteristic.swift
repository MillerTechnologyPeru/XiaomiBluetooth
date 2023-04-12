//
//  TemperatureHumidityCharacteristic.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import Bluetooth
import GATT

/// Mi Thermometer Characteristic
public struct TemperatureHumidityCharacteristic: Equatable, Hashable, Codable {
    
    public static var uuid: BluetoothUUID { BluetoothUUID(rawValue: "EBE0CCC1-7A0A-4B0C-8A1A-6FF2997DA3A6")! }
    
    public static var service: BluetoothUUID { BluetoothUUID(rawValue: "EBE0CCB0-7A0A-4B0C-8A1A-6FF2997DA3A6")! }
    
    internal static var length: Int { 5 }
    
    public var temperature: Temperature
    
    public var humidity: Humidity
    
    public var batteryVoltage: BatteryVoltage
    
    public init?(data: Data) {
        guard data.count == Self.length,
            let humidity = Humidity(rawValue: data[2]) else {
            return nil
        }
        self.temperature = Temperature(rawValue: UInt16(littleEndian: UInt16(bytes: (data[0], data[1]))))
        self.humidity = humidity
        self.batteryVoltage = BatteryVoltage(rawValue: UInt16(littleEndian: UInt16(bytes: (data[3], data[4]))))
    }
}

public extension TemperatureHumidityCharacteristic {
    
    struct Temperature: RawRepresentable, Equatable, Hashable, Codable {
        
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
    }
}

extension TemperatureHumidityCharacteristic.Temperature: CustomStringConvertible {
    
    public var description: String {
        return "\(celcius) C°"
    }
}

public extension TemperatureHumidityCharacteristic.Temperature {
    
    var celcius: Float {
        Float(rawValue) / 100
    }
}


public extension TemperatureHumidityCharacteristic {
    
    struct Humidity: RawRepresentable, Equatable, Hashable, Codable {
        
        public let rawValue: UInt8
        
        public init?(rawValue: UInt8) {
            guard rawValue <= Self.max.rawValue else {
                return nil
            }
            self.init(rawValue)
        }
        
        private init(_ raw: UInt8) {
            self.rawValue = raw
        }
    }
}

extension TemperatureHumidityCharacteristic.Humidity: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: UInt8) {
        assert(value <= 100)
        self.init(Swift.min(value, Self.max.rawValue))
    }
}

public extension TemperatureHumidityCharacteristic.Humidity {
    
    static var min: TemperatureHumidityCharacteristic.Humidity { .init(0) }
    
    static var max: TemperatureHumidityCharacteristic.Humidity { .init(100) }
}

extension TemperatureHumidityCharacteristic.Humidity: CustomStringConvertible {
    
    public var description: String {
        return "\(rawValue)%"
    }
}

public extension TemperatureHumidityCharacteristic {
    
    struct BatteryVoltage: RawRepresentable, Equatable, Hashable, Codable {
                
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
    }
}

public extension TemperatureHumidityCharacteristic.BatteryVoltage {
    
    var voltage: Double {
        Double(rawValue) / 1000
    }
}

extension TemperatureHumidityCharacteristic.BatteryVoltage: CustomStringConvertible {
    
    public var description: String {
        return "\(voltage)V"
    }
}
