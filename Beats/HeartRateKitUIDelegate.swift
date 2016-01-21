//
//  HeartRateKitUIDelegate.swift
//  Beats
//
//  Created by Yvette Cook on 20/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

protocol HeartRateKitUIDelegate {
    
    func hrKitDidUpdateState(state: HeartRateKitState)
    func hrKitDidUpdateBPM(bpm: Int)
    
}