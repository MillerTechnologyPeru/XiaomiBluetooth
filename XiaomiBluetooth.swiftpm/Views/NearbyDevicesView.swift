//
//  NearbyDevicesView.swift
//  
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import Bluetooth
import GATT
import XiaomiBluetooth

struct NearbyDevicesView: View {
    
    @EnvironmentObject
    var store: Store
    
    @State
    private var scanTask: Task<Void, Never>?
    
    var body: some View {
        list
        .navigationTitle(title)
        .navigationBarItems(trailing: scanButton)
        .onAppear {
            scanTask?.cancel()
            scanTask = Task {
                // start scanning after delay
                try? await store.central.wait(for: .poweredOn)
                if store.isScanning == false {
                    toggleScan()
                }
            }
        }
        .onDisappear {
            scanTask?.cancel()
            scanTask = nil
            if store.isScanning {
                store.stopScanning()
            }
        }
    }
}

private extension NearbyDevicesView {
    
    enum ScanState {
        case bluetoothUnavailable
        case scanning
        case stopScan
    }
    
    struct Item: Equatable, Hashable, Identifiable {
        
        var id: NativePeripheral.ID {
            peripheral.id
        }
        
        let peripheral: NativePeripheral
        
        let product: ProductID
        
        let address: BluetoothAddress?
        
        let version: UInt8
    }
    
    var items: [Item] {
        var items = [Item]()
        items.reserveCapacity(store.peripherals.count)
        for (peripheral, beacons) in store.peripherals {
            let _ = beacons
                .values
                .sorted(by: { $0.frameCounter < $1.frameCounter })
                .sorted(by: { $0.address != nil && $1.address == nil })
                .first
                .flatMap { beacon in
                    items.append(
                        Item(
                            peripheral: peripheral,
                            product: beacon.product,
                            address: beacon.address,
                            version: beacon.version
                        )
                    )
                }
        }
        return items
    }
    
    var state: ScanState {
        if store.state != .poweredOn {
            return .bluetoothUnavailable
        } else if store.isScanning {
            return .scanning
        } else {
            return .stopScan
        }
    }
    
    var scanButton: some View {
        Button(action: {
            toggleScan()
        }, label: {
            switch state {
            case .bluetoothUnavailable:
                Image(systemName: "exclamationmark.triangle.fill")
                    .symbolRenderingMode(.multicolor)
            case .scanning:
                Image(systemName: "stop.fill")
                    .symbolRenderingMode(.monochrome)
            case .stopScan:
                Image(systemName: "arrow.clockwise")
                    .symbolRenderingMode(.monochrome)
            }
        })
    }
    
    var title: LocalizedStringKey {
        "Xiaomi"
    }
    
    var list: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: {
                    MiBeaconDetailView(
                        peripheral: item.peripheral,
                        product: item.product,
                        version: item.version,
                        address: item.address
                    )
                }, label: {
                    MiBeaconAdvertisementRow(
                        product: item.product,
                        address: item.address
                    )
                })
            }
        }
    }
    
    func toggleScan() {
        if store.isScanning {
            store.stopScanning()
        } else {
            self.scanTask?.cancel()
            self.scanTask = Task {
                guard await store.central.state == .poweredOn,
                      store.isScanning == false else {
                    return
                }
                do {
                    try await store.scan()
                }
                catch { store.log("⚠️ Unable to scan. \(error.localizedDescription)") }
            }
        }
    }
}
