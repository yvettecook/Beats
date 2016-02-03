//
//  ScanningViewControllerTests.swift
//  Beats
//
//  Created by Yvette Cook on 19/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class ScanningViewControllerTests: XCTestCase {
    
    var scanningVC: ScanningViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        scanningVC = storyboard.instantiateViewControllerWithIdentifier("ScanningViewController") as! ScanningViewController
        UIApplication.sharedApplication().keyWindow!.rootViewController = scanningVC
        
        XCTAssertNotNil(scanningVC.view)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasState() {
        XCTAssertNotNil(scanningVC.state)
    }
    
    func testHasHeartRateKit() {
        XCTAssertNotNil(scanningVC.heartRateKit)
    }

    func testCanSetHRKitToDemo() {
        scanningVC.setToDemoMode()
        XCTAssertEqual(scanningVC.heartRateKit!.mode, HeartRateKitMode.Demo)
    }
    
    func testCanUpdateVCStateWhenHRKitStateChanges() {
        scanningVC.setToDemoMode()
        scanningVC.heartRateKit?.state = .Connected
        XCTAssertEqual(self.scanningVC.state, UIState.Connected)
    }
    
    func testUpdatesUIOnStateChange() {
        let initialImage = scanningVC.centralImage.image
        XCTAssertEqual(initialImage, UIImage(named: "ellipses"))
        scanningVC.setToDemoMode()
        scanningVC.heartRateKit?.state = .Connected
        let secondImage = scanningVC.centralImage.image
        XCTAssertEqual(secondImage, UIImage(named: "tick"))
    }
    
    func testLeavesScanningScreenAfterConnected() {
        weak var expectation = expectationWithDescription("Should leave screen on connection")
        
        let completion = { () -> Void in
            XCTAssertTrue(self.scanningVC.segueToHeartRateTriggered)
            expectation?.fulfill()
        }
        
        scanningVC.setToDemoMode()
        scanningVC.heartRateKit?.state = .Connected
        
        asyncTest(completion, wait: 5)
        
        waitForExpectationsWithTimeout(5.5, handler: nil)
    }
    
    func testOnlyTransitionsToNextViewOnce() {
        weak var expectation = expectationWithDescription("Should only transition once")
        
        let completion = { () -> Void in
            let count = self.scanningVC.segueCount
            print("Count: \(count)")
            XCTAssertTrue(count == 1)
            expectation?.fulfill()
        }
        
        scanningVC.setToDemoMode()
        scanningVC.heartRateKit?.state = .Connected
        
        asyncTest(completion, wait: 5)
        
        waitForExpectationsWithTimeout(5.5, handler: nil)
    }
    
}
