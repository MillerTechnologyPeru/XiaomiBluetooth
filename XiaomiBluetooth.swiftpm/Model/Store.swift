//
//  Store.swift
//
//
//  Created by Alsey Coleman Miller on 4/12/23.
//

import Foundation
import SwiftUI
import CoreBluetooth
import Bluetooth
import GATT
import DarwinGATT
import XiaomiBluetooth

@MainActor
public final class Store: ObservableObject {
    
    // MARK: - Properties
    
    @Published
    public private(set) var state: DarwinBluetoothState = .unknown
    
    @Published
    public private(set) var isScanning = false
    
    @Published
    public private(set) var peripherals = [NativeCentral.Peripheral: MiBeacon]()
    
    lazy var central = NativeCentral()
    
    private var scanStream: AsyncCentralScan<NativeCentral>?
    
    // MARK: - Initialization
    
    public static let shared = Store()
    
    private init() {
        central.log = { [unowned self] in self.log("📲 Central: " + $0) }
        observeBluetoothState()
    }
    
    // MARK: - Methods
    
    /// The Bluetooth LE peripheral for the speciifed device identifier..
    subscript (peripheral address: BluetoothAddress) -> NativeCentral.Peripheral? {
        return peripherals.first(where: { $0.value.address == address })?.key
    }
    
    private func observeBluetoothState() {
        // observe state
        Task { [weak self] in
            while let self = self {
                let newState = await self.central.state
                let oldValue = self.state
                if newState != oldValue {
                    self.state = newState
                }
                try await Task.sleep(timeInterval: 0.5)
            }
        }
    }
    
    public func scan(duration: TimeInterval? = nil) async throws {
        let bluetoothState = await central.state
        guard bluetoothState == .poweredOn else {
            throw XiaomiBluetoothAppError.bluetoothUnavailable
        }
        let filterDuplicates = true //preferences.filterDuplicates
        self.peripherals.removeAll(keepingCapacity: true)
        stopScanning()
        isScanning = true
        let scanStream = central.scan(
            with: [.xiaomi],
            filterDuplicates: filterDuplicates
        )
        self.scanStream = scanStream
        let task = Task { [unowned self] in
            defer { Task { await MainActor.run { self.isScanning = false } } }
            for try await scanData in scanStream {
                guard found(scanData) else { continue }
            }
        }
        if let duration = duration {
            precondition(duration > 0.001)
            try await Task.sleep(timeInterval: duration)
            scanStream.stop()
            try await task.value // throw errors
        } else {
            // error not thrown
            Task { [unowned self] in
                do { try await task.value }
                catch is CancellationError { }
                catch {
                    self.log("Error scanning: \(error)")
                }
            }
        }
    }
    
    public func stopScanning() {
        scanStream?.stop()
        scanStream = nil
        isScanning = false
    }
    
    private func found(_ scanData: ScanData<NativeCentral.Peripheral, NativeCentral.Advertisement>) -> Bool {
        guard let advertisement = MiBeacon(scanData.advertisementData) else {
            return false
        }
        let oldValue = self.peripherals[scanData.peripheral]
        if oldValue != advertisement {
            self.peripherals[scanData.peripheral] = advertisement
        }
        return false
    }
    
    public func log(_ message: String) {
        print(message)
    }
}
