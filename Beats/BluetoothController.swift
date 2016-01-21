//
//  BluetoothController.swift
//  Beats
//
//  Created by Yvette Cook on 21/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import CoreBluetooth

class BluetoothController: NSObject, BluetoothControllerProtocol, CBCentralManagerDelegate, CBPeripheralDelegate {
    
    var state: BluetoothControllerState {
        didSet {
            print("State did change: \(state)")
            delegate?.bluetooothControllerStateChanged(state)
        }
    }
    
    var centralManager: CBCentralManager?
    var delegate: BluetoothControllerDelegate?
    
    let heartRateServiceUUID = "180D"
    let measurementCharacteristicUUID = "2A37"
    
    var currentMonitor: CBPeripheral?
    
    
    override init() {
        state = .StartedUp
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil, options: nil)
    }
    
    func scanForAvailableMonitors() {
        guard let centralManager = centralManager else { return }
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        state = .Scanning
    }
    
    
    // MARK: MockCentralManagerDelegate
    
    func centralManagerDidUpdateState(central: CBCentralManager) {
        switch central.state {
        case .PoweredOff:
            print("CoreBluetooth BLE hardware is powered off")
        case .PoweredOn:
            print("CoreBluetooth BLE hardware is powered on and ready")
            scanForAvailableMonitors()
        case .Unauthorized:
            print("CoreBluetooth BLE state is unauthorized")
        case .Unknown:
            print("CoreBluetooth BLE state is unknown")
        case .Unsupported:
            print("CoreBluetooth BLE hardware is unsupported on this platform")
        case .Resetting:
            print("CoreBluetooth BLE hardware is resetting")
        }
    }
    
    func centralManager(central: CBCentralManager, didDiscoverPeripheral peripheral: CBPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber) {
        state = .FoundMonitor
        self.currentMonitor = peripheral
        peripheral.delegate = self
        centralManager?.connectPeripheral(peripheral, options: nil)
    }
    
    func centralManager(central: CBCentralManager, didConnectPeripheral peripheral: CBPeripheral) {
        state = .ConnectedMonitor
        peripheral.delegate = self
        peripheral.discoverServices([CBUUID(string: heartRateServiceUUID)])
    }
    
    func centralManager(central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: NSError?) {
        print("Did disconnect peripheral")
        centralManager?.scanForPeripheralsWithServices(nil, options: nil)
    }
    
    // MARK: MockPeripheralDelegate
    
    func peripheral(peripheral: CBPeripheral, didDiscoverServices error: NSError?) {
        for service in peripheral.services! {
            print("Discovered service: \(service.UUID.UUIDString)")
            if service.UUID.UUIDString == heartRateServiceUUID {
                peripheral.discoverCharacteristics(nil, forService:service)
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didDiscoverCharacteristicsForService service: CBService, error: NSError?) {
        if service.UUID.UUIDString == heartRateServiceUUID {
            
            self.centralManager?.stopScan()
            
            for char in service.characteristics! {
                if char.UUID.UUIDString == measurementCharacteristicUUID {
                    peripheral.setNotifyValue(true, forCharacteristic: char)
                }
            }
        }
    }
    
    func peripheral(peripheral: CBPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?) {
        if characteristic.UUID.UUIDString == measurementCharacteristicUUID {
            self.getHeartBPMData(characteristic, error: error)
        }
    }
    
    
    // MARK: Heart Rate
    
    func getHeartBPMData(characteristic: CBCharacteristic, error: NSError?) {
        guard let data = characteristic.value else { return }
        
        let count = data.length / sizeof(UInt8)
        var array = [UInt8](count: count, repeatedValue: 0)
        data.getBytes(&array, length:count * sizeof(UInt8))
        
        if ((array[0] & 0x01) == 0) {
            let bpm = array[1]
            let bpmInt = Int(bpm)
            delegate?.heartRateUpdated(bpmInt)
        }
        
    }

    
}