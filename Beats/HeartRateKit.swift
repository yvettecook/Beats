//
//  HeartRateKit.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class HeartRateKit : NSObject, BluetoothControllerDelegate {
    
    var state: HeartRateKitState
    var bluetoothController: BluetoothControllerProtocol?
    
    var availableDeviceNames = [String]()
    
    var currentHeartRate: Int?
    
    override init() {
        state = .Inactive
        super.init()
    }
    
    func scanForMonitors() {
        bluetoothController!.scanForAvailableMonitors()
    }
    
    // MARK: BluetoothControllerDelegate
    
    func bluetooothControllerStateChanged(state: BluetoothControllerState) {
        switch state {
        case .Scanning:
            self.state = .Scanning
        case .FoundMonitor:
            self.state = .FoundMonitor
        case .ConnectedMonitor:
            self.state = .Connected
        default:
            break
        }
    }
    
    func heartRateUpdated(hr: Int) {
        
    }

}

enum HeartRateKitState {
    case Inactive
    case Scanning
    case FoundMonitor
    case Connected
}
