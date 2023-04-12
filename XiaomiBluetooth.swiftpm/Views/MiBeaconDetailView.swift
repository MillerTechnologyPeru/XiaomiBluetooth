//
//  MiBeaconDetailView.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import GATT
import XiaomiBluetooth

struct MiBeaconDetailView: View {
    
    let peripheral: NativePeripheral
    
    let product: ProductID
    
    let version: UInt8
    
    @EnvironmentObject
    private var store: Store
    
    @State
    var reloadTask: Task<Void, Never>?
    
    @State
    private var error: String?
    
    @State
    private var isReloading = false
    
    @State
    private var address: BluetoothAddress?
    
    @State
    private var capability: MiBeacon.Capability = []
    
    @State
    private var ioCapability: MiBeacon.Capability.IO = []
    
    init(
        peripheral: NativePeripheral,
        product: ProductID,
        version: UInt8,
        address: BluetoothAddress?
    ) {
        self.peripheral = peripheral
        self.product = product
        self.version = version
        self.address = address
    }
    
    var body: some View {
        StateView(
            product: product,
            address: address,
            version: version,
            capability: capability,
            ioCapability: ioCapability
        )
        .refreshable {
            reload()
        }
        .onAppear {
            reload()
        }
        .onDisappear {
            reloadTask?.cancel()
        }
    }
}

extension MiBeaconDetailView {
    
    func reload() {
        let oldTask = reloadTask
        reloadTask = Task {
            self.error = nil
            self.isReloading = true
            defer { self.isReloading = false }
            await oldTask?.value
            do {
                guard let beacons = store.peripherals[peripheral], beacons.isEmpty == false else {
                    throw CentralError.unknownPeripheral
                }
                self.address = beacons.compactMapValues { $0.address }.values.first
                self.capability = beacons.compactMap { $0.value.capability }.first ?? []
                self.ioCapability = beacons.compactMap { $0.value.ioCapability }.first ?? []
            }
            catch {
                self.error = error.localizedDescription
            }
        }
    }
}

extension MiBeaconDetailView {
    
    struct StateView: View {
        
        let product: ProductID
        
        let address: BluetoothAddress?
        
        let version: UInt8
        
        let capability: MiBeacon.Capability
        
        let ioCapability: MiBeacon.Capability.IO
        
        var body: some View {
            List {
                Section("Advertisement") {
                    if let address = self.address {
                        SubtitleRow(
                            title: Text("Address"),
                            subtitle: Text(verbatim: address.rawValue)
                        )
                    }
                    SubtitleRow(
                        title: Text("Version"),
                        subtitle: Text(verbatim: version.description)
                    )
                    if capability.isEmpty == false {
                        SubtitleRow(
                            title: Text("Capability"),
                            subtitle: Text(verbatim: capability.description)
                        )
                    }
                    if ioCapability.isEmpty == false {
                        SubtitleRow(
                            title: Text("IO Capability"),
                            subtitle: Text(verbatim: ioCapability.description)
                        )
                    }
                }
            }
            .navigationTitle("\(product.description)")
        }
    }
}
