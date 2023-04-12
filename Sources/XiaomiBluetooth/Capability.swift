//
//  Capability.swift
//  
//
//  Created by Alsey Coleman Miller on 4/11/23.
//

import Foundation

public extension MiBeacon {
    
    /// A set of options that represent the capabilities of a device in the context of wireless communication protocols.
    struct Capability: OptionSet, Equatable, Hashable {
        
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
}

public extension MiBeacon.Capability {
    
    /// The device is connectable.
    static var connectable: MiBeacon.Capability { MiBeacon.Capability(rawValue: 1 << 0) }
    
    /// The device is centralable.
    static var centralable: MiBeacon.Capability { MiBeacon.Capability(rawValue: 1 << 1) }
    
    /// The device is encryptable.
    static var encryptable: MiBeacon.Capability { MiBeacon.Capability(rawValue: 1 << 2) }
    
    /// The device does not support binding.
    static var noBinding: MiBeacon.Capability { MiBeacon.Capability(rawValue: 0 << 3) }
    
    /// The device supports front binding.
    static var frontBinding: MiBeacon.Capability { MiBeacon.Capability(rawValue: 1 << 3) }
    
    /// The device supports back binding.
    static var backBinding: MiBeacon.Capability { MiBeacon.Capability(rawValue: 2 << 3) }
    
    /// The device supports combo binding.
    static var comboBinding: MiBeacon.Capability { MiBeacon.Capability(rawValue: 3 << 3) }
    
    /// The device has an I/O capability.
    static var io: MiBeacon.Capability { MiBeacon.Capability(rawValue: 1 << 5) }
}

public extension MiBeacon.Capability {
    
    /// An option set that represents the input/output capabilities of a device.
    struct IO: OptionSet, Equatable, Hashable {
        
        public let rawValue: UInt8
        
        public init(rawValue: UInt8) {
            self.rawValue = rawValue
        }
    }
}

public extension MiBeacon.Capability.IO {
    
    /// The device can input 6 digits.
    static var digitsInput: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 0)
    }
    
    /// The device can input 6 letters.
    static var lettersInput: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 1)
    }
    
    /// The device can read NFC tags.
    static var nfcRead: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 2)
    }
    
    /// The device can recognize QR codes.
    static var qrCodeRead: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 3)
    }
    
    /// The device can output 6 digits.
    static var digitsOutput: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 4)
    }
    
    /// The device can output 6 letters.
    static var lettersOutput: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 5)
    }
    
    /// The device can generate NFC tags.
    static var nfcWrite: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 6)
    }
    
    /// The device can generate QR codes.
    static var qrCodeWrite: MiBeacon.Capability.IO {
        MiBeacon.Capability.IO(rawValue: 1 << 7)
    }
}
