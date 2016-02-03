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
        heartRateKit = HeartRateKit.sharedInstance
        heartRateKit.mode = .Demo
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
        weak var expectation = expectationWithDescription("State will change to .FoundMonitor")
        
        let completionBlock = { () -> Void in
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.FoundMonitor)
            expectation?.fulfill()
        }
        
        heartRateKit.scanForMonitors()
        
        asyncTest(completionBlock, wait: 2)
        
        waitForExpectationsWithTimeout(2.5, handler: nil)
    }
    
    func testCanConnectToAvailableMonitor() {
        weak var expectation = expectationWithDescription("Should connect to available monitor")
        
        let completionBlock = { () -> Void in
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.Connected)
            expectation?.fulfill()
        }
        
        heartRateKit.scanForMonitors()
        
        asyncTest(completionBlock, wait: 4)
        
        waitForExpectationsWithTimeout(4.0, handler: nil)
    }
    
    func testCanReceiveHeartRate() {
        weak var expectation = expectationWithDescription("Should receive a heart rate from Bluetooth Controller")
        
        let completionBlock = { () -> Void in
            XCTAssertNotNil(self.heartRateKit.currentHeartRate)
            XCTAssertTrue(self.heartRateKit.currentHeartRate > 50)
            expectation?.fulfill()
        }
        
        heartRateKit.scanForMonitors()
        
        asyncTest(completionBlock, wait: 5)
        
        waitForExpectationsWithTimeout(5.5, handler: nil)
    }
    
    func testCanBeSetToDemoMode() {
        heartRateKit.mode = .Bluetooth
        XCTAssertEqual(heartRateKit.mode, HeartRateKitMode.Bluetooth)
        heartRateKit.mode = .Demo
        let controller = heartRateKit.bluetoothController as? MockBluetoothController
        XCTAssertNotNil(controller)
    }
    
}