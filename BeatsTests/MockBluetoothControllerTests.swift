//
//  MockBluetoothControllerTests.swift
//  Beats
//
//  Created by Yvette Cook on 08/01/2016.
//  Copyright © 2016 Yvette. All rights reserved.
//

import XCTest

@testable import Beats

class MockBluetoothControllerTests: XCTestCase {
    
    var mockBluetoothController: MockBluetoothController!

    override func setUp() {
        mockBluetoothController = MockBluetoothController()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testCanInitializeWithCentralManager() {
        XCTAssertNotNil(mockBluetoothController.centralManager)
    }
    
    func testHasState() {
        XCTAssertEqual(mockBluetoothController.state, BluetoothControllerState.StartedUp)
    }
    
    func testScanForAvailableDevicesChangesState() {
        mockBluetoothController.scanForAvailableMonitors()
        let state = mockBluetoothController.state
        
        XCTAssertEqual(state, BluetoothControllerState.Scanning)
    }
    
}
