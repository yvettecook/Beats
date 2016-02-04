//
//  RecordingControlsViewController.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class RecordingControlsViewControllerTests : XCTestCase {
    
    var recordingControlsVC: RecordingControlsViewController!
    var recorder: SessionRecorder!

    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        recordingControlsVC = storyboard.instantiateViewControllerWithIdentifier("RecordingControlsViewController") as! RecordingControlsViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = recordingControlsVC
        
        XCTAssertNotNil(recordingControlsVC.view)
        
        recorder = recordingControlsVC.sessionRecorder
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasASessionRecorder() {
        XCTAssertNotNil(recordingControlsVC.sessionRecorder)
    }
    
    func testCanStartRecording() {
        recordingControlsVC.startRecording()
        XCTAssertEqual(recorder.state, SessionRecorderState.Recording)
    }
    
    func testCanStopRecording() {
        recordingControlsVC.pauseRecording()
        XCTAssertEqual(recorder.state, SessionRecorderState.Paused)
    }
    
    func testCanFinishRecording() {
        recordingControlsVC.finishRecording()
        XCTAssertEqual(recorder.state, SessionRecorderState.Finished)
    }
    
    func testButtonTappedControlsRecording() {
        recordingControlsVC.buttonTapped(recordingControlsVC.startButton)
        XCTAssertEqual(recorder.state, SessionRecorderState.Recording)
        
        recordingControlsVC.buttonTapped(recordingControlsVC.stopButton)
        XCTAssertEqual(recorder.state, SessionRecorderState.Paused)
        
        recordingControlsVC.buttonTapped(recordingControlsVC.finishButton)
        XCTAssertEqual(recorder.state, SessionRecorderState.Finished)
    }
    
    func testIfStateNilRecordButtonShown() {
        recorder.state = .Inactive
        XCTAssertFalse(recordingControlsVC.startButton.hidden)
        XCTAssertTrue(recordingControlsVC.stopButton.hidden)
        XCTAssertTrue(recordingControlsVC.finishButton.hidden)
    }
    
    func testIfRecordingStopButtonShown() {
        recorder.state = .Recording
        XCTAssertTrue(recordingControlsVC.startButton.hidden)
        XCTAssertFalse(recordingControlsVC.stopButton.hidden)
        XCTAssertTrue(recordingControlsVC.finishButton.hidden)
    }
    
    func testIfPauseRecordingStartFinishButtonsShown() {
        recorder.state = .Paused
        XCTAssertFalse(recordingControlsVC.startButton.hidden)
        XCTAssertTrue(recordingControlsVC.stopButton.hidden)
        XCTAssertFalse(recordingControlsVC.finishButton.hidden)
    }
    
}

