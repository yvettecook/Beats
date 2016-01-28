//
//  RecordingControlsViewController.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

final class RecordingControlsViewController: UIViewController {
    
    var heartRateKit: HeartRateKit?
    
    override func viewDidLoad() {
        heartRateKit = HeartRateKit.sharedInstance
    }
    
    
}
