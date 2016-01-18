//
//  MockPeripheralDelegate.swift
//  Beats
//
//  Created by Yvette Cook on 17/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import CoreBluetooth

protocol MockPeripheralDelegate {
    
    func peripheral(peripheral: MockPeripheral, didDiscoverServices error: NSError?)
    func peripheral(peripheral: MockPeripheral, didDiscoverCharacteristics error: NSError?)
    func peripheral(peripheral: MockPeripheral, didUpdateValueForCharacteristic characteristic: CBCharacteristic, error: NSError?)
    
}