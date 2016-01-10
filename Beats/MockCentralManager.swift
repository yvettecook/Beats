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
    
    init(delegate: MockCentralManagerDelegate?, queue: dispatch_queue_t?) {
        self.delegate = delegate
        super.init()
    }
    
    func scanForPeripheralsWithServices(serviceUUIDs: [CBUUID]?, options: [String : AnyObject]?) {
        
    }

}