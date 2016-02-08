//
//  RecordingControlsViewController.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

final class RecordingControlsViewController: UIViewController, SessionRecorderDelegate {
    
    var sessionRecorder = SessionRecorder.sharedInstance
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        sessionRecorder.delegate = self
        sessionRecorder.state = .Inactive
    }
    
    func startRecording() {
        sessionRecorder.startRecording()
    }
    
    func pauseRecording() {
        sessionRecorder.pauseRecording()
    }
    
    func finishRecording() {
        sessionRecorder.finishRecording()
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        switch sender {
        case startButton:
            startRecording()
        case stopButton:
            pauseRecording()
        case finishButton:
            finishRecording()
        default:
            break
        }
    }
    
    func recorderDidUpdateState(state: SessionRecorderState) {
        switch state {
        case .Inactive:
            startButton.hidden = false
            finishButton.hidden = true
            stopButton.hidden = true
        case .Recording:
            startButton.hidden = true
            finishButton.hidden = true
            stopButton.hidden = false
        case .Paused:
            startButton.hidden = false
            finishButton.hidden = false
            stopButton.hidden = true
        default:
            break
        }
    }
    
}
