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
        heartRateKit.scanForMonitors()
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            let state = self.heartRateKit.state
            XCTAssertEqual(state, HeartRateKitState.FoundMonitor)
        }
        
    }

}
