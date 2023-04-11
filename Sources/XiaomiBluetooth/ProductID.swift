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
    
    case CGC1               = 0x0C3C
    case CGD1               = 0x0576
    case CGDK2              = 0x066F
    case CGG1               = 0x0347
    case CGG1_ENCRYPTED     = 0x0B48
    case CGH1               = 0x03D6
    case CGPR1              = 0x0A83
    case GCLS002            = 0x03BC
    case HHCCJCY01          = 0x0098
    case HHCCPOT002         = 0x015D
    case JQJCY01YM          = 0x02DF
    case JTYJGD03MI         = 0x0997
    case K9B_1BTN           = 0x1568
    case K9B_2BTN           = 0x1569
    case K9B_3BTN           = 0x0DFD
    case MS1BB_MI           = 0x1889
    case HS1BB_MI           = 0x2AEB
    case LYWSDCGQ           = 0x01AA
    case LYWSD02            = 0x045B
    case LYWSD02MMC         = 0x16E4
    case LYWSD03MMC         = 0x055B
    case MCCGQ02HL          = 0x098B
    case MHO_C303           = 0x06d3
    case MHO_C401           = 0x0387
    case MJYD02YL           = 0x07F6
    case MJZNMSQ01YD        = 0x04E9
    case MMCT201_1          = 0x00DB
    case MUE4094RT          = 0x03DD
    case M1S_T500           = 0x0489
    case RTCGQ02LM          = 0x0A8D
    case SJWS01LM           = 0x0863
    case V_SK152            = 0x045C
    case WX08ZM             = 0x040A
    case XMMF01JQD          = 0x04E1
    case XMWSDJ04MMC        = 0x1203
    case XMWXKG01YL         = 0x1949
    case XMZNMST02YD        = 0x098C
    case XMZNMS04LM         = 0x0784
    case XMZNMS08LM         = 0x0E39
    case YLAI003            = 0x07BF
    case YLYK01YL           = 0x0153
    case YLYK01YL_FANCL     = 0x068E
    case YLYK01YL_VENFAN    = 0x04E6
    case YLYB01YL_BHFRC     = 0x03BF
    case YLKG07YL_YLKG08YL  = 0x03B6
    case YM_K1501           = 0x0083
    case YM_K1501EU         = 0x0113
    case ZNMS16LM           = 0x069E
    case ZNMS17LM           = 0x069F
    case DSL_C08            = 0x0380
    case SU001_T            = 0x0DE7
    case MJZNZ018H          = 0x20DB
    case ZX1                = 0x18E3
}

// MARK: - CustomStringConvertible

extension ProductID: CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .CGC1:
            return "CGC1"
        case .CGD1:
            return "CGD1"
        case .CGDK2:
            return "CGDK2"
        case .CGG1:
            return "CGG1"
        case .CGG1_ENCRYPTED:
            return "CGG1-ENCRYPTED"
        case .CGH1:
            return "CGH1"
        case .CGPR1:
            return "CGPR1"
        case .GCLS002:
            return "GCLS002"
        case .HHCCJCY01:
            return "HHCCJCY01"
        case .HHCCPOT002:
            return "HHCCPOT002"
        case .JQJCY01YM:
            return "JQJCY01YM"
        case .JTYJGD03MI:
            return "JTYJGD03MI"
        case .K9B_1BTN:
            return "K9B-1BTN"
        case .K9B_2BTN:
            return "K9B-2BTN"
        case .K9B_3BTN:
            return "K9B-3BTN"
        case .MS1BB_MI:
            return "MS1BB(MI)"
        case .HS1BB_MI:
            return "HS1BB(MI)"
        case .LYWSDCGQ:
            return "LYWSDCGQ"
        case .LYWSD02:
            return "LYWSD02"
        case .LYWSD02MMC:
            return "LYWSD02MMC"
        case .LYWSD03MMC:
            return "LYWSD03MMC"
        case .MCCGQ02HL:
            return "MCCGQ02HL"
        case .MHO_C303:
            return "MHO-C303"
        case .MHO_C401:
            return "MHO-C401"
        case .MJYD02YL:
            return "MJYD02YL"
        case .MJZNMSQ01YD:
            return "MJZNMSQ01YD"
        case .MMCT201_1:
            return "MMC-T201-1"
        case .MUE4094RT:
            return "MUE4094RT"
        case .M1S_T500:
            return "M1S-T500"
        case .RTCGQ02LM:
            return "RTCGQ02LM"
        case .SJWS01LM:
            return "SJWS01LM"
        case .V_SK152:
            return "V-SK152"
        case .WX08ZM:
            return "WX08ZM"
        case .XMMF01JQD:
            return "XMMF01JQD"
        case .XMWSDJ04MMC:
            return "XMWSDJ04MMC"
        case .XMWXKG01YL:
            return "XMWXKG01YL"
        case .XMZNMST02YD:
            return "XMZNMST02YD"
        case .XMZNMS04LM:
            return "XMZNMS04LM"
        case .XMZNMS08LM:
            return "XMZNMS08LM"
        case .YLAI003:
            return "YLAI003"
        case .YLYK01YL:
            return "YLYK01YL"
        case .YLYK01YL_FANCL:
            return "YLYK01YL-FANCL"
        case .YLYK01YL_VENFAN:
            return "YLYK01YL-VENFAN"
        case .YLYB01YL_BHFRC:
            return "YLYB01YL-BHFRC"
        case .YLKG07YL_YLKG08YL:
            return "YLKG07YL/YLKG08YL"
        case .YM_K1501:
            return "YM-K1501"
        case .YM_K1501EU:
            return "YM-K1501EU"
        case .ZNMS16LM:
            return "ZNMS16LM"
        case .ZNMS17LM:
            return "ZNMS17LM"
        case .DSL_C08:
            return "DSL-C08"
        case .SU001_T:
            return "SU001-T"
        case .MJZNZ018H:
            return "MJZNZ018H"
        case .ZX1:
            return "ZX1"
        }
    }
}
