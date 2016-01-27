//
//  HeartRateKit.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

final class HeartRateKit : NSObject, BluetoothControllerDelegate {
    
    static let sharedInstance = HeartRateKit()
    
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
            case .Inactive:
                break
            case .Bluetooth:
                bluetoothController = BluetoothController()
                bluetoothController?.delegate = self
            case .Demo:
                bluetoothController = MockBluetoothController()
                bluetoothController?.delegate = self
            }
        }
    }
    
    private override init() {
        state = .Inactive
        mode = .Inactive
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
        currentHeartRate = hr
        uiDelegate?.hrKitDidUpdateBPM(hr)
    }

}


enum HeartRateKitMode {
    case Inactive
    case Bluetooth
    case Demo
}

enum HeartRateKitState {
    case Inactive
    case Scanning
    case FoundMonitor
    case Connected
}
