//
//  AuthenticationMode.swift
//  
//
//  Created by Alsey Coleman Miller on 4/11/23.
//

import Foundation

/// Authentication Mode
public enum AuthenticationMode: UInt8, CaseIterable, Codable {
    
    /// The old version authentication mode.
    case oldVersion         = 0
    
    /// The security authentication mode.
    case security           = 1
    
    /// The standard authentication mode.
    case standard           = 2
    
    /// The retention authentication mode.
    case retention          = 3
}
