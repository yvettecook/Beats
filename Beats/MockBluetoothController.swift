//
//  MockBluetoothController.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class MockBluetoothController: NSObject, BluetoothControllerProtocol, MockCentralManagerDelegate, MockPeripheralDelegate {
    
    var state: BluetoothControllerState {
        didSet {
            delegate?.bluetooothControllerStateChanged(state)
        }
    }
    
    var centralManager: MockCentralManager?
    var delegate: BluetoothControllerDelegate?
    
    
    override init() {
        state = .StartedUp
        super.init()
        centralManager = MockCentralManager(delegate: self, queue: nil)
    }
    
    func scanForAvailableMonitors() {
        guard let centralManager = centralManager else { return }
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        state = .Scanning
    }
    
    
    // MARK: MockCentralManagerDelegate
    
    func centralManager(central: MockCentralManager, didDiscoverPeripheral peripheral: MockPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber) {
        didDiscoverPeripheralCalled = true
        state = .FoundMonitor
        centralManager?.connectPeripheral(peripheral, options: nil)
    }
    
    func centralManager(central: MockCentralManager, didConnectPeripheral peripheral: MockPeripheral) {
        didConnectPeripheralCalled = true
        state = .ConnectedMonitor
        peripheral.delegate = self
        peripheral.discoverServices(nil)
    }
    
    // MARK: MockPeripheralDelegate
    
    func peripheral(peripheral: MockPeripheral, didDiscoverServices error: NSError?) {
        didDiscoverServicesCalled = true
    }
 
    
    
    // MARK: Method called Flags
    
    var didDiscoverPeripheralCalled = false
    var didConnectPeripheralCalled = false
    var didDiscoverServicesCalled = false
    
}




enum BluetoothControllerState {
    case StartedUp
    case Scanning
    case FoundMonitor
    case ConnectedMonitor
}