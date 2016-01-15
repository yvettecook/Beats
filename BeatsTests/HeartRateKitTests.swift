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
        let completionBlock = { (success: Bool) -> Void in
            print("Yo")
        }
        
        heartRateKit.scanForMonitors(completionBlock)
        let state = heartRateKit.state
        XCTAssertEqual(state, HeartRateKitState.Scanning)
    }
    
    func testStateChangeWhenDeviceFound() {
        let expectation = expectationWithDescription("State will change to .FoundMonitor")
        
        let completionBlock = { (success: Bool) -> Void in
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.FoundMonitor)
            expectation.fulfill()
        }
        
        heartRateKit.scanForMonitors(completionBlock)
        
        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
//    func testCanConnectToFoundMonitor() {
//        heartRateKit.scanForMonitors()
//        let state = self.heartRateKit.state
//        print("State: \(state)")
//        XCTAssertEqual(state, HeartRateKitState.Connected)
//    }
    

    

}
