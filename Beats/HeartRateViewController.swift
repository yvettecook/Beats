//
//  HeartRateViewController.swift
//  Beats
//
//  Created by Yvette Cook on 20/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

class HeartRateViewController: UIViewController, HeartRateKitUIDelegate {
    
    var heartRateKit: HeartRateKit?
    
    @IBOutlet weak var bpmLabel: UILabel!
    
    override func viewDidLoad() {
        heartRateKit = HeartRateKit.sharedInstance
        heartRateKit?.uiDelegate = self
    }
 
    func hrKitDidUpdateState(state: HeartRateKitState) {
        
    }
    
    func hrKitDidUpdateBPM(bpm: Int) {
        bpmLabel.text = "\(bpm)"
    }

    
}