//
//  SessionRecorder.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import Foundation

class SessionRecorder: NSObject {
    
    override init() {
        super.init()
    }
    
    func startRecording() {
        
    }
    
    func pauseRecording() {
        
    }
    
    func finishRecording() {
        
    }
    
}

enum SessionRecorderState {
    case Recording
    case Paused
    case Finished
}