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
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testHasABluetoothController() {
        XCTAssertNotNil(heartRateKit.bluetoothController)
    }
    
    func testCanTryConnectToHeartRateMonitor() {
        heartRateKit.connectToMonitor()
        let state = heartRateKit.state
        XCTAssertEqual(state, HeartRateKitState.Searching)
    }

}
