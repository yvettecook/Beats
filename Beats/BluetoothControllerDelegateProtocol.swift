//
//  BluetoothControllerDelegateProtocol.swift
//  Beats
//
//  Created by Yvette Cook on 10/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

protocol BluetoothControllerDelegate {
    
    func bluetooothControllerStateChanged(state: BluetoothControllerState)
    
}