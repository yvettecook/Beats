//
//  MockCentralManagerDelegate.swift
//  Beats
//
//  Created by Yvette Cook on 10/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

protocol MockCentralManagerDelegate {
    
    func centralManager(central: MockCentralManager, didDiscoverPeripheral peripheral: MockPeripheral,
        advertisementData: [String : AnyObject], RSSI: NSNumber)
    
    func centralManager(central: MockCentralManager, didConnectPeripheral peripheral: MockPeripheral)
    
}