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
    
    func testScanForAvailableMonitorsChangesState() {
        mockBluetoothController.scanForAvailableMonitors()
        let state = mockBluetoothController.state
        
        XCTAssertEqual(state, BluetoothControllerState.Scanning) 
    }
    
    func testOnScanForAvailableMonitorsCentralManagerScanMethodCalled() {
        mockBluetoothController.scanForAvailableMonitors()
        XCTAssertTrue(mockBluetoothController!.centralManager!.scanForPeripheralsWithServicesCalled)
    }
    
    func testOnScanForAvailableMonitorsPeripheralIsFound() {
        mockBluetoothController.scanForAvailableMonitors()
        
        let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 4 * Int64(NSEC_PER_SEC))
        dispatch_after(time, dispatch_get_main_queue()) {
            XCTAssertTrue(self.mockBluetoothController.didDiscoverPeripheralCalled)
        }
    }
}
