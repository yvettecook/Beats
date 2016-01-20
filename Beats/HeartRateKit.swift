//
//  HeartRateKit.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class HeartRateKit : NSObject, BluetoothControllerDelegate {
    
    var bluetoothController: BluetoothControllerProtocol?
    var uiDelegate: HeartRateKitUIDelegate?
    
    var availableDeviceNames = [String]()
    var currentHeartRate: Int?
    
    var state: HeartRateKitState {
        didSet {
            uiDelegate?.hrKitDidUpdateState(state)
        }
    }
    
    var mode: HeartRateKitMode {
        didSet {
            switch mode {
            case .Bluetooth:
                bluetoothController = nil
            case .Demo:
                bluetoothController = MockBluetoothController()
                bluetoothController?.delegate = self
            }
        }
    }
    
    override init() {
        state = .Inactive
        mode = .Bluetooth
        super.init()
    }
    
    func scanForMonitors() {
        print("Scanning for monitors 1")
        bluetoothController!.scanForAvailableMonitors()
    }
    
    // MARK: BluetoothControllerDelegate
    
    func bluetooothControllerStateChanged(state: BluetoothControllerState) {
        print("Bluetooth Controller State: \(state)")
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
        print("Current HR: \(hr)")
        currentHeartRate = hr
    }

}


enum HeartRateKitMode {
    case Bluetooth
    case Demo
}

enum HeartRateKitState {
    case Inactive
    case Scanning
    case FoundMonitor
    case Connected
}
