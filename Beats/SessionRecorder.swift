//
//  SessionRecorder.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class SessionRecorder: NSObject {
    
    var delegate: SessionRecorderDelegate?
    
    var state: SessionRecorderState {
        didSet {
            delegate?.recorderDidUpdateState(state)
        }
    }
    
    override init() {
        state = .Inactive
        super.init()
    }
    
    func startRecording() {
        state = .Recording
    }
    
    func pauseRecording() {
        state = .Paused
    }
    
    func finishRecording() {
        state = .Finished
    }
    
}

enum SessionRecorderState {
    case Inactive
    case Recording
    case Paused
    case Finished
}