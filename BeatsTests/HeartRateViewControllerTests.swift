//
//  HeartRateViewControllerTests.swift
//  Beats
//
//  Created by Yvette Cook on 21/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class HeartRateViewControllerTests: XCTestCase {
    
    var heartRateVC: HeartRateViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        heartRateVC = storyboard.instantiateViewControllerWithIdentifier("HeartRateViewController") as! HeartRateViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = heartRateVC
        
        XCTAssertNotNil(heartRateVC.view)
        
        heartRateVC.heartRateKit?.mode = .Demo
        heartRateVC.heartRateKit?.scanForMonitors()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasHeartRateKit() {
        XCTAssertNotNil(heartRateVC.heartRateKit)
        let delegate = heartRateVC.heartRateKit!.uiDelegate! as? HeartRateViewController
        XCTAssertNotNil(delegate)
        XCTAssertEqual(heartRateVC, delegate)
    }

    func testHeartRateViewDisplayCurrentHR() {
        weak var expectation = expectationWithDescription("Current heart rate should be displayed")
        
        let completion = { () -> Void in
            let currentHR = self.heartRateVC.heartRateKit?.currentHeartRate
            let displayBpm = self.heartRateVC.bpmLabel.text
            XCTAssertEqual(displayBpm, "\(currentHR!)")
            expectation?.fulfill()
        }
        
        asyncTest(completion, wait: 7)
        
        waitForExpectationsWithTimeout(7.5, handler: nil)
    }
    
    func testHasARecordingControlsVC() {
        XCTAssertNotNil(heartRateVC.recordingControlsVC)
    }

}
