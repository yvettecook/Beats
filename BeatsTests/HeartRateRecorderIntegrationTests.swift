//
//  HeartRateRecorderIntegrationTests.swift
//  Beats
//
//  Created by Yvette Cook on 04/02/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
@testable import Beats

class HeartRateRecorderIntegrationTests: XCTestCase {
    
    var heartRateVC: HeartRateViewController!
    var sessionRecorder: SessionRecorder!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        heartRateVC = storyboard.instantiateViewControllerWithIdentifier("HeartRateViewController") as! HeartRateViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = heartRateVC
        
        XCTAssertNotNil(heartRateVC.view)
        
        heartRateVC.heartRateKit?.mode = .Demo
        heartRateVC.heartRateKit?.scanForMonitors()
        sessionRecorder = SessionRecorder.sharedInstance
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testHeartRateIsRecorded() {
        weak var expectation = expectationWithDescription("Heart rate should be saved to session")
        
        let completion = { () -> Void in
            let valueCount = self.sessionRecorder.currentSession?.values?.count
            XCTAssertTrue(valueCount > 2)
            expectation?.fulfill()
        }
        
        heartRateVC.recordingControlsVC?.startRecording()
        asyncTest(completion, wait: 4)
        
        waitForExpectationsWithTimeout(5.5, handler: nil)
    }
    
    func testSessionIsEndedWhenFinishButtonTapped() {
        heartRateVC.recordingControlsVC?.startRecording()
        heartRateVC.recordingControlsVC?.finishRecording()
        XCTAssertEqual(sessionRecorder.state, SessionRecorderState.Finished)
        XCTAssertNotNil(sessionRecorder.currentSession?.endTime)
    }


}
