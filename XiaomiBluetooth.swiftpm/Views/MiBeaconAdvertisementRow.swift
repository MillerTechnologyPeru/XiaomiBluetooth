//
//  XiaomiBluetoothAdvertisementRow.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import XiaomiBluetooth

struct MiBeaconAdvertisementRow: View {
    
    let product: ProductID
    
    let address: BluetoothAddress?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: product.description)
                .font(.title3)
            if let address = self.address {
                Text(verbatim: address.rawValue)
                    .foregroundColor(.gray)
                    .font(.subheadline)
            }
        }
    }
}

#if DEBUG
struct XiaomiBluetoothAdvertisementRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                MiBeaconAdvertisementRow(
                    product: .LYWSD03MMC,
                    address: BluetoothAddress(rawValue: "A4:C1:38:78:3C:8D")!
                )
                MiBeaconAdvertisementRow(
                    product: .LYWSD02MMC,
                    address: BluetoothAddress(rawValue: "A4:C1:38:78:3C:01")!
                )
                MiBeaconAdvertisementRow(
                    product: .CGC1,
                    address: nil
                )
            }
        }
    }
}
#endif
