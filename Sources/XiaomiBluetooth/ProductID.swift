//
//  ProductID.swift
//  
//
//  Created by Alsey Coleman Miller on 4/11/23.
//

/// Xiaomi Product Identifier
///
/// Product ID, the only one for each type of product, pid needs to apply on the [Xiaomi IoT developer platform](https://iot.mi.com/new/doc/introduction/main).
public enum ProductID: UInt16, Codable, CaseIterable {
    
    case cgc1               = 0x0C3C
    case cgd1               = 0x0576
    case cgdk2              = 0x066F
    case cgg1               = 0x0347
    case cgg1Encrypted      = 0x0B48
    case cgh1               = 0x03D6
    case cgpr1              = 0x0A83
    case gcls002            = 0x03BC
    case hhccjcy01          = 0x0098
    case hhccpot002         = 0x015D
    case jqjcy01ym          = 0x02DF
    case jtyjgd03mi         = 0x0997
    case k9B1BTN            = 0x1568
    case k9B2BTN            = 0x1569
    case k9B3BTN            = 0x0DFD
    case ms1BBMI            = 0x1889
    case hs1BBMI            = 0x2AEB
    case lywsdcgq           = 0x01AA
    case lywsd02            = 0x045B
    case lywsd02mmc         = 0x16E4
    case lywsd03mmc         = 0x055B
}

extension ProductID: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .cgc1: return "CGC1"
        case .cgd1: return "CGD1"
        case .cgdk2: return "CGDK2"
        case .cgg1: return "CGG1"
        case .cgg1Encrypted: return "CGG1-ENCRYPTED"
        case .cgh1: return "CGH1"
        case .cgpr1: return "CGPR1"
        case .gcls002: return "GCLS002"
        case .hhccjcy01: return "HHCCJCY01"
        case .hhccpot002: return "HHCCPOT002"
        case .jqjcy01ym: return "JQJCY01YM"
        case .jtyjgd03mi: return "JTYJGD03MI"
        case .k9B1BTN: return "K9B-1BTN"
        case .k9B2BTN: return "K9B-2BTN"
        case .k9B3BTN: return "K9B-3BTN"
        case .ms1BBMI: return "MS1BB(MI)"
        case .hs1BBMI: return "HS1BB(MI)"
        case .lywsdcgq: return "LYWSDCGQ"
        case .lywsd02: return "LYWSD02"
        case .lywsd02mmc: return "LYWSD02MMC"
        case .lywsd03mmc: return "LYWSD03MMC"
        }
    }
}
