//
//  MockCentralManager.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation
import CoreBluetooth

class MockCentralManager: NSObject {
    
    var delegate: MockCentralManagerDelegate?
    
    var scanTimer: NSTimer?
    
    init(delegate: MockCentralManagerDelegate?, queue: dispatch_queue_t?) {
        self.delegate = delegate
        super.init()
    }
    
    func scanForPeripheralsWithServices(serviceUUIDs: [CBUUID]?, options: [String : AnyObject]?) {
        scanForPeripheralsWithServicesCalled = true
        
        scanTimer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: "discoverPeripheral", userInfo: nil, repeats: false)
    }
    
    
    // MARK: Helper methods
    
    func discoverPeripheral() {
        print("Discovered peripheral")
        
        discoveredPeripheral = true
        
        let peripheral = MockPeripheral()
        
        delegate?.centralManager(self, didDiscoverPeripheral: peripheral, advertisementData: ["CBAdvertisementDataLocalNameKey": "MockPolarH7"], RSSI: 42)
        
    }
    
    
    
    
    // MARK: Method Flags
    
    var scanForPeripheralsWithServicesCalled = false
    var discoveredPeripheral = false

}