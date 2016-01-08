//
//  HeartRateKit.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class HeartRateKit : NSObject {
    
    var state: HeartRateKitState
    
    var bluetoothController: BluetoothControllerProtocol?
    
    override init() {
        state = .Inactive
        super.init()
    }
    
    func connectToMonitor() {
        
    }

}

enum HeartRateKitState {
    case Inactive
    case Searching
}