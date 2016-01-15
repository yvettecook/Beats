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
    
    var awaitingScanCompletion: ((success: Bool) -> Void)?
    
    override init() {
        state = .StartedUp
        super.init()
        centralManager = MockCentralManager(delegate: self, queue: nil)
    }
    
    func scanForAvailableMonitors(completion: (Bool) -> Void) {
        guard let centralManager = centralManager else { return }
        centralManager.scanForPeripheralsWithServices(nil, options: nil)
        state = .Scanning
        awaitingScanCompletion = completion
    }
    
    
    // MARK: MockCBCentralMethods
    
    func centralManager(central: MockCentralManager, didDiscoverPeripheral peripheral: MockPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber) {
        didDiscoverPeripheralCalled = true
        guard let awaitingScanCompletion = awaitingScanCompletion else { return }
        state = .FoundMonitor
        awaitingScanCompletion(success: true)
    }
    
    
    
    // MARK: Method called Flags
    
    var didDiscoverPeripheralCalled = false
    
}




enum BluetoothControllerState {
    case StartedUp
    case Scanning
    case FoundMonitor
}