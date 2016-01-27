//
//  MockCharacteristic.swift
//  Beats
//
//  Created by Yvette Cook on 19/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import CoreBluetooth

final class MockCharacteristic: CBMutableCharacteristic {
    
    var trueCharacteristic: CBMutableCharacteristic?
    var mockValue: NSData?
    
    init(type: CBUUID,
        properties: CBCharacteristicProperties,
        permissions: CBAttributePermissions) {
        super.init(type: type, properties: properties, value: nil, permissions: permissions)
    }
    
}