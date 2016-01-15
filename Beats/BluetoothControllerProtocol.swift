//
//  BluetoothControllerProtocol.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

protocol BluetoothControllerProtocol {
    
    var delegate: BluetoothControllerDelegate? { get set }
    
    func scanForAvailableMonitors(completion: (Bool) -> Void)
    
} 