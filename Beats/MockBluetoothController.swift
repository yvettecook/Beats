//
//  MockBluetoothController.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class MockBluetoothController: NSObject, BluetoothControllerProtocol, MockCentralManagerDelegate {
    
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
        
//        guard let onFound = onFound else { return }
//        onFound("Yo")
    }
    
    
    // MARK: MockCBCentralMethods
    
    func centralManager(central: MockCentralManager, didDiscoverPeripheral peripheral: MockPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber) {
        didDiscoverPeripheralCalled = true
    }
    
    
    
    // MARK: Method called Flags
    
    var didDiscoverPeripheralCalled = false
    
}




enum BluetoothControllerState {
    case StartedUp
    case Scanning
}