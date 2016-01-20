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
    
    @IBOutlet weak var centralImage: UIImageView!
    @IBOutlet weak var demoButton: UIButton!
    
    override func viewDidLoad() {
        state = .Searching
        heartRateKit = HeartRateKit()
        heartRateKit?.uiDelegate = self
    }
    
    func setToDemoMode() {
        heartRateKit?.mode = .Demo
        heartRateKit?.scanForMonitors()
    }
    
    func hrKitDidUpdateState(state: HeartRateKitState) {
        print("State: \(state)")
        switch state {
        case .Connected:
            self.state = .Connected
            updateUI()
        default:
            break
        }
    }
    
    func updateUI() {
        switch self.state! {
        case .Searching:
            break
        case .Connected:
            view.backgroundColor = UIColor(red: 74/255, green: 198/255, blue: 183/255, alpha: 1)
            centralImage.image = UIImage(named: "tick")
        }
    }
    
    @IBAction func demoButtonTapped(sender: AnyObject) {
        setToDemoMode()
    }
}

enum UIState {
    case Searching
    case Connected
}
    