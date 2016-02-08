//
//  SessionRecorder.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class SessionRecorder{
    
    var delegate: SessionRecorderDelegate?
    
    var currentSession: Session?
    
    var state: SessionRecorderState {
        didSet {
            delegate?.recorderDidUpdateState(state)
        }
    }
    
    static let sharedInstance = SessionRecorder()
    
    internal init() {
        state = .Inactive
    }
    
    // MARK: Recording
    
    func startRecording() {
        state = .Recording
    }
    
    func pauseRecording() {
        state = .Paused
    }
    
    func finishRecording() {
        state = .Finished
        currentSession?.end()
    }
    
    // MARK: Sessions
    
    func newSession() {
        currentSession = Session()
    }
    
    func addValue(value: Int) {
        if state == .Recording {
            currentSession?.addValue(value)
        }
    }

}

enum SessionRecorderState {
    case Inactive
    case Recording
    case Paused
    case Finished
}