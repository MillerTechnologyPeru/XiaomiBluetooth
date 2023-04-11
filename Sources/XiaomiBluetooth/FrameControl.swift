//
//  FrameControl.swift
//  
//
//  Created by Alsey Coleman Miller on 4/11/23.
//

import Foundation

internal extension MiBeacon {
    
    /// Frame Control
    struct FrameControl: OptionSet, Equatable, Hashable {
        
        public let rawValue: UInt16
        
        public init(rawValue: UInt16) {
            self.rawValue = rawValue
        }
    }
}

extension MiBeacon.FrameControl {
    
    /// Indicates whether the packet has been encrypted.
    static var isEncrypted: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 3)
    }
      
    /// Indicates whether the packet includes a fixed MAC address.
    static var macInclude: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 4)
    }
    
    /// Indicates whether the packet includes capability information.
    /// This bit is mandatory to be 1 before the device is bound.
    static var capabilityInclude: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 5)
    }
      
    /// Indicates whether the packet includes an object.
    static var objectInclude: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 6)
      }
      
    /// Indicates whether the packet is using mesh access.
    /// This bit is mandatory to be 0 for standard BLE access products and high-security access, and mandatory to be 1 for Mesh access.
    static var mesh: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 7)
      }
      
    /// Indicates whether the device has been registered and bound.
    /// This bit is used to indicate whether the device has been reset.
    static var registered: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 8)
      }
      
    /// Indicates whether the packet is requesting the app for registration binding.
    /// This bit is only valid when the user selects the device to confirm the pairing on the developer platform.
    static var solicited: MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: 1 << 9)
      }
      
    /// Returns a FrameControl instance with the authentication mode bits set based on the input mode.
    ///
    /// - Parameter mode: The authentication mode to use. Must be a value between 0 and 3.
    static func authenticationMode(_ mode: AuthenticationMode) -> MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: UInt16(mode.rawValue & 0b0000_0011) << 10)
    }
      
    /// Returns a FrameControl instance with the version bits set based on the input version number.
    ///
    /// - Parameter version: The version number to use. Must be a value between 0 and 15.
    static func version(_ version: Int) -> MiBeacon.FrameControl {
        return MiBeacon.FrameControl(rawValue: UInt16(version & 0b1111) << 12)
    }
    
    /// A FrameControl instance with the mesh and capabilityInclude bits set to 1.
    static var meshAccess: MiBeacon.FrameControl {
        return [mesh, capabilityInclude]
    }
}
