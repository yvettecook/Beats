//
//  ScanningViewController.swift
//  Beats
//
//  Created by Yvette Cook on 20/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

class ScanningViewController : UIViewController, HeartRateKitUIDelegate {
    
    var state: UIState?
    var heartRateKit: HeartRateKit?
    
    override func viewDidLoad() {
        state = .Searching
        heartRateKit = HeartRateKit()
        heartRateKit?.uiDelegate = self
    }
    
    func setToDemoMode() {
        heartRateKit?.mode = .Demo
    }
    
    func hrKitDidUpdateState(state: HeartRateKitState) {
        switch state {
        case .Connected:
            self.state = .Connected
        default:
            break
        }
    }
    
}

enum UIState {
    case Searching
    case Connected
}
    