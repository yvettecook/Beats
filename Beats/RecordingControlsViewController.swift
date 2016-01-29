//
//  RecordingControlsViewController.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import UIKit

final class RecordingControlsViewController: UIViewController, SessionRecorderDelegate {
    
    var sessionRecorder: SessionRecorder?
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    override func viewDidLoad() {
        sessionRecorder = SessionRecorder()
        sessionRecorder?.delegate = self
        sessionRecorder?.state = .Inactive
    }
    
    func startRecording() {
        guard let sessionRecorder = sessionRecorder else { return }
        sessionRecorder.startRecording()
    }
    
    func pauseRecording() {
        guard let sessionRecorder = sessionRecorder else { return }
        sessionRecorder.pauseRecording()
    }
    
    func finishRecording() {
        guard let sessionRecorder = sessionRecorder else { return }
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
