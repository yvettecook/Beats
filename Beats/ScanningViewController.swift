//
//  ScanningViewController.swift
//  Beats
//
//  Created by Yvette Cook on 20/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

final class ScanningViewController : UIViewController, HeartRateKitUIDelegate {
    
    var state: UIState?
    var heartRateKit: HeartRateKit?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var centralImage: UIImageView!
    @IBOutlet weak var demoButton: UIButton!
    
    
    
    override func viewDidLoad() {
        state = .Searching
        heartRateKit = HeartRateKit.sharedInstance
        heartRateKit?.uiDelegate = self
        heartRateKit?.mode = .Bluetooth
    }
    
    func setToDemoMode() {
        heartRateKit?.mode = .Demo
        heartRateKit?.scanForMonitors()
    }
    
    func hrKitDidUpdateState(state: HeartRateKitState) {
        switch state {
        case .Connected:
            self.state = .Connected
            updateUI()
        default:
            break
        }
    }
    
    func hrKitDidUpdateBPM(bpm: Int) {
        if !segueToHeartRateTriggered { self.transitionToNextView() }
        
    }
    
    func updateUI() {
        switch self.state! {
        case .Searching:
            break
        case .Connected:
            connectedUI()
        }
    }
    
    func connectedUI() {
        view.backgroundColor = UIColor(red: 74/255, green: 198/255, blue: 183/255, alpha: 1)
        centralImage.image = UIImage(named: "tick")
        demoButton.hidden = true
        titleLabel.text = "Connected"
        if heartRateKit?.mode == .Demo {
            subtitleLabel.text = "In demo mode"
        } else {
            subtitleLabel.text = ""
        }
    }
    
    @IBAction func demoButtonTapped(sender: AnyObject) {
        setToDemoMode()
    }
    
    func transitionToNextView() {
        segueCount++
        self.segueToHeartRateTriggered = true
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 2 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            self.performSegueWithIdentifier("SegueToHeartRate", sender: self)
        }
    }
    
    
    // MARK: Testing flags
    
    var segueToHeartRateTriggered = false
    var segueCount = 0
}

enum UIState {
    case Searching
    case Connected
}
    