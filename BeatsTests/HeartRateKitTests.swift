//
//  HeartRateKitTests.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class HeartRateKitTests: XCTestCase {
    
    var heartRateKit: HeartRateKit!
    
    override func setUp() {
        heartRateKit = HeartRateKit()
        heartRateKit.bluetoothController = MockBluetoothController()
        heartRateKit.bluetoothController!.delegate = heartRateKit
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasABluetoothController() {
        XCTAssertNotNil(heartRateKit.bluetoothController)
    }
    
    func testCanTryConnectToHeartRateMonitor() {
        heartRateKit.scanForMonitors()
        let state = heartRateKit.state
        XCTAssertEqual(state, HeartRateKitState.Scanning)
    }
    
    func testStateChangeWhenDeviceFound() {
        let expectation = expectationWithDescription("State will change to .FoundMonitor")
        
        let completionBlock = { () -> Void in
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.FoundMonitor)
            expectation.fulfill()
        }
        
        heartRateKit.scanForMonitors()
        
        asyncTest(completionBlock, wait: 3)
        
        waitForExpectationsWithTimeout(3, handler: nil)
    }
    
    func testCanConnectToAvailableMonitor() {
        let expectation = expectationWithDescription("Should connect to available monitor")
        
        let completionBlock = { () -> Void in
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.Connected)
            expectation.fulfill()
        }
        
        heartRateKit.scanForMonitors()
        
        asyncTest(completionBlock, wait: 4)
        
        waitForExpectationsWithTimeout(4.0, handler: nil)
    }

}