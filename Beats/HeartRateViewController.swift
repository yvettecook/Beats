//
//  HeartRateViewController.swift
//  Beats
//
//  Created by Yvette Cook on 20/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

final class HeartRateViewController: UIViewController, HeartRateKitUIDelegate {
    
    var heartRateKit: HeartRateKit?
    var recordingControlsVC: RecordingControlsViewController?
    var sessionRecorder = SessionRecorder.sharedInstance
    
    @IBOutlet weak var bpmLabel: UILabel!
    @IBOutlet weak var recordingControlsView: UIView!
    
    override func viewDidLoad() {
        heartRateKit = HeartRateKit.sharedInstance
        heartRateKit?.uiDelegate = self
        sessionRecorder.newSession()
    }
 
    func hrKitDidUpdateState(state: HeartRateKitState) {
        
    }
    
    func hrKitDidUpdateBPM(bpm: Int) {
        bpmLabel.text = "\(bpm)"
        sessionRecorder.addValue(bpm)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "EmbedControls" {
            guard
                let vc = segue.destinationViewController as? RecordingControlsViewController
                else { fatalError("Incorrect EmbedControls segue") }
            recordingControlsVC = vc
        }
    }

}

