//
//  SessionRecorderTests.swift
//  Beats
//
//  Created by Yvette Cook on 28/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest
@testable import Beats

class SessionRecorderTests: XCTestCase {
    
    var sessionRecorder: SessionRecorder!

    override func setUp() {
        sessionRecorder = SessionRecorder.sharedInstance
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSingletonIsSame() {
        let recorder1 = SessionRecorder.sharedInstance
        XCTAssertEqual(sessionRecorder, recorder1)
    }

    func testCanStartRecording() {
        sessionRecorder.startRecording()
        XCTAssertEqual(sessionRecorder.state, SessionRecorderState.Recording)
    }
    
    func testCanStopRecording() {
        sessionRecorder.pauseRecording()
        XCTAssertEqual(sessionRecorder.state, SessionRecorderState.Paused)
    }
    
    func testCanFinishRecording() {
        sessionRecorder.finishRecording()
        XCTAssertEqual(sessionRecorder.state, SessionRecorderState.Finished)
    }

    func testCanCreateNewSession() {
        sessionRecorder.newSession()
        XCTAssertNotNil(sessionRecorder.currentSession)
    }
    
    func testCanAddValueToSessionIfRecording() {
        sessionRecorder.startRecording()
        sessionRecorder.newSession()
        sessionRecorder.addValue(1)
        let sessionLength = sessionRecorder.currentSession!.values?.count
        XCTAssertEqual(sessionLength, 1)
    }
    
    func testDoesNotAddValueIfPaused() {
        sessionRecorder.newSession()
        sessionRecorder.pauseRecording()
        sessionRecorder.addValue(1)
        let sessionLength = sessionRecorder.currentSession!.values?.count
        XCTAssertEqual(sessionLength, 0)
    }
    
}

