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
    var stubRecorder: StubSessionRecorder!
    
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        recordingControlsVC = storyboard.instantiateViewControllerWithIdentifier("RecordingControlsViewController") as! RecordingControlsViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = recordingControlsVC
        
        XCTAssertNotNil(recordingControlsVC.view)
        
        stubRecorder = StubSessionRecorder()
        recordingControlsVC.sessionRecorder = stubRecorder
        stubRecorder.delegate = recordingControlsVC
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasASessionRecorder() {
        XCTAssertNotNil(recordingControlsVC.sessionRecorder)
    }
    
    func testCanStartRecording() {
        recordingControlsVC.startRecording()
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Recording)
    }
    
    func testCanStopRecording() {
        recordingControlsVC.pauseRecording()
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Paused)
    }
    
    func testCanFinishRecording() {
        recordingControlsVC.finishRecording()
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Finished)
    }
    
    func testButtonTappedControlsRecording() {
        recordingControlsVC.buttonTapped(recordingControlsVC.startButton)
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Recording)
        
        recordingControlsVC.buttonTapped(recordingControlsVC.stopButton)
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Paused)
        
        recordingControlsVC.buttonTapped(recordingControlsVC.finishButton)
        XCTAssertEqual(stubRecorder.state, SessionRecorderState.Finished)
    }
    
    func testIfStateNilRecordButtonShown() {
        stubRecorder.state = .Inactive
        XCTAssertFalse(recordingControlsVC.startButton.hidden)
        XCTAssertTrue(recordingControlsVC.stopButton.hidden)
        XCTAssertTrue(recordingControlsVC.finishButton.hidden)
    }
    
    func testIfRecordingStopButtonShown() {
        stubRecorder.state = .Recording
        XCTAssertTrue(recordingControlsVC.startButton.hidden)
        XCTAssertFalse(recordingControlsVC.stopButton.hidden)
        XCTAssertTrue(recordingControlsVC.finishButton.hidden)
    }
    
    func testIfPauseRecordingStartFinishButtonsShown() {
        stubRecorder.state = .Paused
        XCTAssertFalse(recordingControlsVC.startButton.hidden)
        XCTAssertTrue(recordingControlsVC.stopButton.hidden)
        XCTAssertFalse(recordingControlsVC.finishButton.hidden)
    }
}


class StubSessionRecorder: SessionRecorder {
    
    override init() {
        super.init()
        state = .Inactive
    }
    
    override func startRecording() {
        state = .Recording
    }
    
    override func pauseRecording() {
        state = .Paused
    }
    
    override func finishRecording() {
        state = .Finished
    }

}
