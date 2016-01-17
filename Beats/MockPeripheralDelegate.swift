//
//  MockPeripheralDelegate.swift
//  Beats
//
//  Created by Yvette Cook on 17/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

protocol MockPeripheralDelegate {
    
    func peripheral(peripheral: MockPeripheral, didDiscoverServices error: NSError?)
    
}