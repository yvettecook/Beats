//
//  MockPeripheral.swift
//  Beats
//
//  Created by Yvette Cook on 11/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import CoreBluetooth

class MockPeripheral : NSObject {
    
    var delegate: MockPeripheralDelegate?
    
    func discoverServices(serviceUUIDS: [CBUUID]?) {
        didDiscoverServicesCalled = true
        
        delegate?.peripheral(self, didDiscoverServices: nil)
    }
    
    
    // MARK: Method flags
    
    var didDiscoverServicesCalled = false
    
}